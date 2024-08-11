import 'dart:async';
import 'package:blueberry_flutter_template/feature/map/provider/LocationProvider.dart';
import 'package:blueberry_flutter_template/feature/map/provider/PermissionProvider.dart';
import 'package:blueberry_flutter_template/feature/map/provider/PoliceStationProvider.dart';
import 'package:blueberry_flutter_template/feature/map/widget/GoogleMapWidget.dart';
import 'package:blueberry_flutter_template/feature/map/widget/PermissionDeniedWidget.dart';
import 'package:blueberry_flutter_template/feature/map/widget/PoliceStationListWidget.dart';
import 'package:blueberry_flutter_template/feature/map/widget/SendMessageWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PoliceMapScreen extends ConsumerStatefulWidget {
  const PoliceMapScreen({super.key});

  @override
  _PoliceMapScreenState createState() => _PoliceMapScreenState();
}

class _PoliceMapScreenState extends ConsumerState<PoliceMapScreen> {
  final Completer<GoogleMapController> _googleMapControllerCompleter =
      Completer<GoogleMapController>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    await ref.read(permissionProvider.notifier).checkPermission();
  }

  @override
  Widget build(BuildContext context) {
    final permissionStatus = ref.watch(permissionProvider);
    final locationState = ref.watch(locationProvider);
    final policeStationsAsyncValue =
        ref.watch(policeStationsProvider(locationState));

    return Scaffold(
      body: () {
        if (permissionStatus == LocationPermissionStatus.initial) {
          return Center(child: CircularProgressIndicator());
        } else if (permissionStatus == LocationPermissionStatus.granted) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: policeStationsAsyncValue.when(
                      data: (policeStations) => GoogleMapWidget(
                        googleMapControllerCompleter:
                            _googleMapControllerCompleter,
                        locationState: locationState,
                        policeStationsAsyncValue: policeStationsAsyncValue,
                      ),
                      loading: () => Center(child: CircularProgressIndicator()),
                      error: (error, stack) =>
                          Center(child: Text('Error: $error')),
                    ),
                  ),
                  SizedBox(height: 8),
                  Expanded(
                    child: PoliceStationListWidget(
                      googleMapControllerCompleter:
                          _googleMapControllerCompleter,
                      locationState: locationState,
                      policeStationsAsyncValue: policeStationsAsyncValue,
                    ),
                  ),
                  SendMessage(locationState: locationState),
                ],
              ),
            ),
          );
        } else {
          return PermissionDeniedWidget(permissionStatus: permissionStatus);
        }
      }(),
    );
  }
}
