import 'package:flutter/material.dart';

PopupMenuItem<int> buildPopupMenuItem({
  required IconData icon,
  required String text,
  required int value,
}) {
  return PopupMenuItem<int>(
    value: value,
    child: Row(
      children: [
        Icon(icon),
        const SizedBox(width: 10),
        Text(text),
      ],
    ),
  );
}
