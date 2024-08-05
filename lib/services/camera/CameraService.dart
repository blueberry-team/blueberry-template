import 'package:camera/camera.dart';

class CameraService {
  CameraController? controller;
  List<CameraDescription> cameras = [];
  bool _readyTakePhoto = false;
  bool _changeCamera = false;

  bool get readyTakePhoto => _readyTakePhoto;
  bool get changeCamera => _changeCamera;

  Future<void> initializeCameras() async {
    cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.high);
    await controller!.initialize();
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
      _readyTakePhoto = true;
    } catch (e) {
      print("Error toggling camera: $e");
      _readyTakePhoto = false;
    }
  }

  Future<XFile?> takePhoto() async {
    if (controller != null && controller!.value.isInitialized) {
      try {
        final XFile file = await controller!.takePicture();
        return file;
      } catch (e) {
        print("Error taking photo: $e");
        return null;
      }
    }
    return null;
  }

  void dispose() {
    controller!.dispose();
  }
}
