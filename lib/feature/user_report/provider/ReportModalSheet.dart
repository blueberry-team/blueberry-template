import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/FriendModel.dart';
import '../../../model/UserReportModel.dart';
import '../../user_report/provider/userReportProvider.dart';
import '../../../utils/AppStrings.dart';

class ReportModalSheet extends ConsumerWidget {
  final FriendModel friend;

  const ReportModalSheet({super.key, required this.friend});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppStrings.reportConfirmationMessage
                .replaceFirst('%s', friend.name),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            child: const Text(AppStrings.reportReasonSpamAccount),
            onPressed: () =>
                _report(context, ref, AppStrings.reportReasonSpamAccount),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            child: const Text(AppStrings.reportReasonFakeAccount),
            onPressed: () =>
                _report(context, ref, AppStrings.reportReasonFakeAccount),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            child: const Text(AppStrings.reportReasonInappropriateNamePhoto),
            onPressed: () => _report(
                context, ref, AppStrings.reportReasonInappropriateNamePhoto),
          ),
        ],
      ),
    );
  }

  void _report(BuildContext context, WidgetRef ref, String reason) async {
    final report = UserReportModel(
      reportedUserId: friend.userId,
      reporterUserId: 'currentUserId', // 현재 로그인한 사용자의 ID로 대체
      reason: reason,
      timestamp: DateTime.now(),
    );

    try {
      await ref.read(userReportProvider.notifier).addReport(report);
      if (!context.mounted) return;
      Navigator.of(context).pop();
      _showSnackBar(context, AppStrings.reportSuccessMessage);
    } catch (e) {
      if (!context.mounted) return;
      _showSnackBar(context, AppStrings.reportErrorMessage);
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
