import 'package:blueberry_flutter_template/feature/camera/CameraShadow.dart';
import 'package:blueberry_flutter_template/feature/camera/MyPageProfileImagePreview.dart';
import 'package:blueberry_flutter_template/feature/camera/provider/PageProvider.dart';
import 'package:blueberry_flutter_template/services/camera/CameraService.dart';
import 'package:blueberry_flutter_template/utils/AppStrings.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ProfileCameraPage extends ConsumerStatefulWidget {
  const ProfileCameraPage({super.key});

  @override
  ProfileCameraPageState createState() => ProfileCameraPageState();
}

class ProfileCameraPageState extends ConsumerState<ProfileCameraPage> {
  final CameraService cameraService = CameraService();
  bool _isPressed = false;
  Size size = Size.zero;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  @override
  void dispose() {
    cameraService.dispose();
    super.dispose();
  }

  Future<void> initializeCamera() async {
    await cameraService.initializeCameras();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final pageNotifier = ref.watch(pageProvider.notifier);
    size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.takeProfilePhoto),
        leading: IconButton(
          onPressed: () {
            pageNotifier.moveToPage(0);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: size.width,
                height: size.width * 1.3,
                color: Colors.black,
                child: cameraService.controller != null
                    ? _getPreview(cameraService.controller!, context)
                    : _buildErrorMessage(cameraService.changeCamera),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  onPressed: () async {
                    try {
                      await cameraService.toggleCamera();
                      setState(() {});
                    } catch (error) {
                      print("Error toggling camera: $error");
                    }
                  },
                  icon: const Icon(Icons.change_circle),
                ),
              )
            ],
          ),
          Expanded(
            child: Center(
              child: GestureDetector(
                onTap: () {
                     _attemptTakePhoto(context);
                },
                onTapDown: (_) => setState(() => _isPressed = true),
                onTapUp: (_) => setState(() => _isPressed = false),
                onTapCancel: () => setState(() => _isPressed = false),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: ShapeDecoration(
                      shape: CircleBorder(
                        side: BorderSide(
                          color: _isPressed ? Colors.red : Colors.black12,
                          width: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getPreview(CameraController controller, BuildContext context) {
    return ClipRect(
      child: OverflowBox(
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Stack(children: [
            SizedBox(
              width: size.width,
              height: size.width * 1.2,
              child: CameraPreview(controller),
            ),
            Positioned.fill(
              child: CustomPaint(
                painter: CameraShadow(radius: size.width * 0.48),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _buildErrorMessage(bool changeCamera) {
    return Center(
      child: Text(
        changeCamera ? AppStrings.setFrontCamera : AppStrings.setBackCamera,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  void _attemptTakePhoto( BuildContext context) async {
    // file에 접근할꺼임 사진을 촬영하고 저장하기 위해서
    final String timeInMilli = DateTime.now().millisecondsSinceEpoch.toString();
    // 이미지를 저장할때 시간을 기준으로 이미지명을 만들기 위해서 사용함
    try {
      final path =
      join((await getTemporaryDirectory()).path, '$timeInMilli.png');

      final XFile file = await cameraService.controller!.takePicture();

      await file.saveTo(path);

      final File imageFile = File(path);

      if (context.mounted) {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => SharePostScreen(imageFile)));
      }
    } catch (e) {
      print('Error: $e');
    }
  }


}

