import 'package:blueberry_flutter_template/feature/map/provider/PermissionProvider.dart';
import 'package:blueberry_flutter_template/utils/AppStrings.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionDeniedWidget extends StatelessWidget {
  final LocationPermissionStatus permissionStatus;

  const PermissionDeniedWidget({
    required this.permissionStatus,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String message;
    bool showSettingsButton = false;
    VoidCallback? onOpenSettings;

    switch (permissionStatus) {
      case LocationPermissionStatus.denied:
        message = AppStrings.errorMessage_locationPermissionDenied;
        showSettingsButton = true;
        onOpenSettings = () async {
          await Geolocator.requestPermission();
        };
        break;
      case LocationPermissionStatus.deniedForever:
        message = AppStrings.errorMessage_locationPermissionForeverDenied;
        showSettingsButton = true;
        break;
      case LocationPermissionStatus.locationDisabled:
        message = AppStrings.errorMessage_locationPermissionDisabled;
        showSettingsButton = true;
        onOpenSettings = () async {
          await Geolocator.openLocationSettings();
        };
        break;
      default:
        message = AppStrings.errorMessage_unknownError;
        break;
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message),
            if (showSettingsButton)
              ElevatedButton(
                onPressed: onOpenSettings ?? () async {
                  await openAppSettings();
                },
                child: Text(AppStrings.button_openConfigMenu),
              ),
          ],
        ),
      ),
    );
  }
}
