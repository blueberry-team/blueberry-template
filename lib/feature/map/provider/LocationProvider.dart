import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationNotifier extends StateNotifier<LatLng> {
  StreamSubscription<Position>? _positionStreamSubscription;

  LocationNotifier() : super(LatLng(37.5665, 126.9780)) {
    _startLocationStream();
  }

  Future<void> _startLocationStream() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    state = LatLng(position.latitude, position.longitude);

    _positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((Position position) {
      state = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  void dispose() {
    _positionStreamSubscription?.cancel();
    super.dispose();
  }
}

final locationProvider = StateNotifierProvider<LocationNotifier, LatLng>((ref) {
  return LocationNotifier();
});
