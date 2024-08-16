import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/FriendModel.dart';
import '../../../model/UserReportModel.dart';
import '../../user_report/provider/userReportProvider.dart';
import '../../../utils/AppStrings.dart';

class ReportModalSheet extends ConsumerWidget {
  final FriendModel friend;
  final String loginUserId = 'loginUserId'; // 로그인한 사용자의 ID로 대체

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
                reportUser(context, ref, AppStrings.reportReasonSpamAccount),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            child: const Text(AppStrings.reportReasonFakeAccount),
            onPressed: () =>
                reportUser(context, ref, AppStrings.reportReasonFakeAccount),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            child: const Text(AppStrings.reportReasonInappropriateNamePhoto),
            onPressed: () => reportUser(
                context, ref, AppStrings.reportReasonInappropriateNamePhoto),
          ),
        ],
      ),
    );
  }

  void reportUser(BuildContext context, WidgetRef ref, String reason) async {
    final report = UserReportModel(
      reportedUserId: friend.friendId,
      reporterUserId: loginUserId,
      reason: reason,
      timestamp: DateTime.now(),
    );

    try {
      await ref.read(userReportProvider.notifier).addReport(report);
      if (!context.mounted) return;
      Navigator.of(context).pop();
      showSnackBar(context, AppStrings.reportSuccessMessage);
    } catch (e) {
      if (!context.mounted) return;
      showSnackBar(context, AppStrings.reportErrorMessage);
    }
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
