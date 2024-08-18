import 'package:blueberry_flutter_template/feature/camera/ProfilePreviewScreen.dart';
import 'package:blueberry_flutter_template/utils/Talker.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class CameraService {
  CameraController? controller;
  List<CameraDescription> cameras = [];
  bool readyTakePhoto = false;
  final ValueNotifier<CameraController?> controllerNotifier =
      ValueNotifier(null);
  final ValueNotifier<bool> readyTakePhotoNotifier = ValueNotifier(false);
  final ValueNotifier<CameraLensDirection> cameraDirectionNotifier =
      ValueNotifier(CameraLensDirection.back);

  Future<void> initializeCameras() async {
    cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.high);
    await controller!.initialize();
    readyTakePhoto = true;
    controllerNotifier.value = controller;
    readyTakePhotoNotifier.value = readyTakePhoto;
  }

  Future<void> toggleCamera() async {
    if (cameras.length < 2) return;

    final lensDirection = controller!.description.lensDirection;
    CameraDescription newCamera;
    if (lensDirection == CameraLensDirection.back) {
      newCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
      );
    } else {
      newCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
      );
    }

    await controller?.dispose();
    controller = CameraController(newCamera, ResolutionPreset.high);
    try {
      await controller!.initialize();
      readyTakePhoto = true;
    } catch (e) {
      print("Error toggling camera: $e");
      readyTakePhoto = false;
    }
    controllerNotifier.value = controller;
    readyTakePhotoNotifier.value = readyTakePhoto;
  }

  Future<XFile?> takePhoto() async {
    if (controller != null && controller!.value.isInitialized) {
      try {
        final XFile file = await controller!.takePicture();
        return file;
      } catch (e) {
        talker.error("Error taking photo: $e");
        return null;
      }
    }
    return null;
  }

  void attemptTakePhoto(BuildContext context) async {
    final String timeInMilli = DateTime.now().millisecondsSinceEpoch.toString();
    try {
      final path =
          join((await getTemporaryDirectory()).path, '$timeInMilli.png');
      final XFile file = await controller!.takePicture();
      await file.saveTo(path);
      final File imageFile = File(path);

      if (context.mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => ProfilePreviewScreen(imageFile)),
        );
      }
    } catch (e) {
      talker.error('Error: $e');
    }
  }

  void dispose() {
    controller?.dispose();
    controllerNotifier.dispose();
    readyTakePhotoNotifier.dispose();
  }
}
