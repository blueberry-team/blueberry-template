import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

enum LocationPermissionStatus {
  initial,
  granted,
  denied,
  deniedForever,
  locationDisabled,
}

class PermissionNotifier extends StateNotifier<LocationPermissionStatus> {
  PermissionNotifier() : super(LocationPermissionStatus.initial) {
    checkPermission();
  }

  Future<void> checkPermission() async {
    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isLocationEnabled) {
      state = LocationPermissionStatus.locationDisabled;
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      state = LocationPermissionStatus.deniedForever;
      await openAppSettings();
      return;
    }

    if (permission != LocationPermission.always &&
        permission != LocationPermission.whileInUse) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        state = LocationPermissionStatus.denied;
        return;
      }
      if (permission == LocationPermission.deniedForever) {
        state = LocationPermissionStatus.deniedForever;
        return;
      }
    }

    state = LocationPermissionStatus.granted;
  }
}

final permissionProvider =
    StateNotifierProvider<PermissionNotifier, LocationPermissionStatus>((ref) {
  return PermissionNotifier();
});
