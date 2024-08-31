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
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        minimumSize: const Size(140, 50),
        textStyle: const TextStyle(
          fontSize: 16, // 더 큰 텍스트 크기
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
