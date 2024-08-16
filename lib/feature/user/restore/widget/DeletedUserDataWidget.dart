import 'package:blueberry_flutter_template/feature/user/restore/widget/DeletionRequestUserInfoTextWidget.dart';
import 'package:blueberry_flutter_template/feature/user/restore/widget/RestoreDeletionUserBottomButtonWidget.dart';
import 'package:flutter/material.dart';


class DeletedUserDataWidget extends StatelessWidget {
  const DeletedUserDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // ignore the back button
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: DeletionRequestUserInfoListWidget()
          ),
          RestoreDeletionUserBottomButtonWidget(),
        ],
      ),
    );
  }
}
