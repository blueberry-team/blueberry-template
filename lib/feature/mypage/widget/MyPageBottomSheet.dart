import 'package:blueberry_flutter_template/feature/camera/CameraGalleryScreen.dart';
import 'package:blueberry_flutter_template/feature/camera/CameraScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

class MyPageBottomSheet extends ConsumerStatefulWidget {
  const MyPageBottomSheet({super.key});

  @override
  ConsumerState<MyPageBottomSheet> createState() => _MyPageBottomSheet();
}

class _MyPageBottomSheet extends ConsumerState<MyPageBottomSheet> {
  Future<bool> _requestAlbumPermission() async {
    // 앨범 권한 요청
    PermissionStatus photoStatus = await Permission.photos.request();
    PermissionStatus storageStatus = await Permission.storage.request();

    if (photoStatus.isGranted || storageStatus.isGranted) {
      print("앨범 접근 권한이 허용되었습니다.");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('앨범 접근 권한이 허용되었습니다.')),
      );
      return true;
    } else if (photoStatus.isDenied || storageStatus.isDenied) {
      print("앨범 접근 권한이 거부되었습니다.");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('앨범 접근 권한이 거부되었습니다.')),
      );
      return false;
    } else if (photoStatus.isPermanentlyDenied ||
        storageStatus.isPermanentlyDenied) {
      print("앨범 접근 권한이 영구적으로 거부되었습니다. 설정에서 권한을 허용해주세요.");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('앨범 접근 권한이 영구적으로 거부되었습니다. 설정에서 권한을 허용해주세요.')),
      );
      // 사용자가 권한을 영구적으로 거부한 경우 설정 페이지로 이동
      await openAppSettings();
      return false;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          width: double.infinity,
        ),
        TextButton(
          onPressed: () async {
            Navigator.pop(context);
            context.goNamed(CameraScreen.name);
          },
          child: const Text("직접 촬영 하기"),
        ),
        TextButton(
          onPressed: () async {
            bool hasPermission = await _requestAlbumPermission();
            if (hasPermission) {
              Navigator.pop(context);
              context.goNamed(CameraGalleryScreen.name);
            } else {
              Navigator.pop(context);
            }
          },
          child: const Text("앨범에서 선택 하기"),
        )
      ],
    );
  }
}
