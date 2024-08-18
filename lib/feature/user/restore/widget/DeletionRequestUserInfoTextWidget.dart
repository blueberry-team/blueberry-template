import 'package:blueberry_flutter_template/core/widget/EmailTextWidget.dart';
import 'package:blueberry_flutter_template/core/widget/UserSignUpDataTextWidget.dart';
import 'package:blueberry_flutter_template/feature/user/restore/widget/UserDeletionDateTextWidget.dart';
import 'package:blueberry_flutter_template/feature/user/restore/widget/UserDeletionRequestDateTextWidget.dart';
import 'package:flutter/material.dart';

class DeletionRequestUserInfoListWidget extends StatelessWidget {
  const DeletionRequestUserInfoListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, Widget>> userInfoItems = [
      {'아이디: ': const EmailTextWidget()},
      {'최초 계정 생성 일: ': const UserSignUpTextWidget()},
      {'탈퇴 요청 일: ': const UserDeletionRequestDateTextWidget()},
      {'탈퇴 예정 일: ': const UserDeletionDateTextWidget()},
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: userInfoItems.length,
        itemBuilder: (context, index) {
          final item = userInfoItems[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                Text(item.keys.first),
                item.values.first,
              ],
            ),
          );
        },
      ),
    );
  }
}
