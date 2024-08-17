
import 'package:blueberry_flutter_template/feature/camera/service/CameraService.dart';
import 'package:blueberry_flutter_template/utils/AppStrings.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraErrorMessageWidget extends StatelessWidget {
  final CameraService cameraService;
  const CameraErrorMessageWidget({super.key, required this.cameraService});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ValueListenableBuilder<CameraLensDirection>(
        valueListenable: cameraService.cameraDirectionNotifier,
        builder: (context, direction, child) {
          return Text(
            direction == CameraLensDirection.front
                ? AppStrings.setFrontCamera
                : AppStrings.setBackCamera,
            style: const TextStyle(color: Colors.white),
          );
        },
      ),
    );
  }
}
