import 'package:flutter/material.dart';

import '../../../model/FriendModel.dart';
import 'FriendBottomSheet.dart';

class FriendBottomSheetLauncher {
  static void show({
    required BuildContext context,
    required FriendModel friend,
    required String imageUrl,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => FriendBottomSheetWidget(
        friend: friend,
        imageUrl: imageUrl,
      ),
    );
  }
}
