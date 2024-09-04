import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/FriendModel.dart';
import '../../../model/UserReportModel.dart';
import '../../../utils/AppStrings.dart';
import '../../userreport/provider/userReportProvider.dart';

class UserReportBottomSheetWidget extends ConsumerWidget {
  final FriendModel friend;
  final String loginUserId = 'loginUserId'; // 로그인한 사용자의 ID로 대체

  const UserReportBottomSheetWidget({super.key, required this.friend});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;

    return Container(
      height: screenHeight * 0.3,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200], // 배경색 지정
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppStrings.reportConfirmationMessage
                .replaceFirst('%s', friend.name),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14),
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
      reportedUserId: friend.userID,
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
