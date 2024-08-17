import 'package:blueberry_flutter_template/feature/camera/widget/CameraPreviewPageWidget.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class CameraPreviewScreen extends StatelessWidget {
  final File imageFile;
  const CameraPreviewScreen(this.imageFile, {super.key});

  @override
  Widget build(BuildContext context) {
    return CameraPreviewPageWidget(imageFile: imageFile);
  }
}
