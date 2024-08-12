import 'package:flutter/material.dart';

class BottomSheetButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const BottomSheetButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        minimumSize: const Size(120, 40), // 버튼 크기
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
