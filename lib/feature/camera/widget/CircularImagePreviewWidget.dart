import 'package:flutter/material.dart';
import 'dart:io';

class CircularImagePreview extends StatelessWidget {
  final File imageFile;
  const CircularImagePreview({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    const double circleSize = 100;

    return ClipOval(
      child: Image.file(
        imageFile,
        width: circleSize,
        height: circleSize,
        fit: BoxFit.cover,
      ),
    );
  }
}
