import 'package:blueberry_flutter_template/feature/camera/widget/CameraButtonWidget.dart';
import 'package:blueberry_flutter_template/feature/camera/widget/CameraPreviewWidget.dart';
import 'package:blueberry_flutter_template/feature/camera/service/CameraService.dart';
import 'package:blueberry_flutter_template/utils/AppStrings.dart';
import 'package:flutter/material.dart';



class CameraPageWidget extends StatefulWidget {
  const CameraPageWidget({super.key});

  @override
  State<CameraPageWidget> createState() => _ProfileCameraPageState();
}

class _ProfileCameraPageState extends State<CameraPageWidget> {
  final CameraService cameraService = CameraService();

  @override
  void initState() {
    super.initState();
    cameraService.initializeCameras();
  }

  @override
  void dispose() {
    cameraService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.takeProfilePhoto),
      ),
      body: Column(
        children: [
          CameraPreviewWidget(
            cameraService: cameraService,
            size: size,
          ),
          Expanded(
            child: CameraButtonWidget(
              onTap: () => cameraService.attemptTakePhoto(context),
            ),
          ),
        ],
      ),
    );
  }
}

