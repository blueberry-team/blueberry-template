import 'package:blueberry_flutter_template/feature/camera/widget/CameraErrorMessageWidget.dart';
import 'package:blueberry_flutter_template/utils/ShadowStyle.dart';
import 'package:blueberry_flutter_template/feature/camera/service/CameraService.dart';
import 'package:blueberry_flutter_template/utils/Talker.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPreviewWidget extends StatelessWidget {
  final CameraService cameraService;
  final Size size;

  const CameraPreviewWidget({
    super.key,
    required this.cameraService,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: size.width,
          height: size.width * 1.3,
          color: Colors.black,
          child: ValueListenableBuilder<CameraController?>(
            valueListenable: cameraService.controllerNotifier,
            builder: (context, controller, child) {
              return controller != null && controller.value.isInitialized
                  ? _getPreview(controller, context)
                  : CameraErrorMessageWidget(cameraService: cameraService);
            },
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: IconButton(
            onPressed: () async {
              try {
                await cameraService.toggleCamera();
              } catch (error) {
                talker.error("Error toggling camera: $error");
              }
            },
            icon: const Icon(Icons.change_circle),
          ),
        )
      ],
    );
  }

  Widget _getPreview(CameraController controller, BuildContext context) {
    return ClipRect(
      child: OverflowBox(
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Stack(
            children: [
              SizedBox(
                width: size.width,
                height: size.width * 1.2,
                child: CameraPreview(controller),
              ),
              Positioned.fill(
                child: CustomPaint(
                  painter: ShadowStyle(radius: size.width * 0.48),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
