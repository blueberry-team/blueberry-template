import 'dart:async';
import 'package:blueberry_flutter_template/feature/map/provider/LocationProvider.dart';
import 'package:blueberry_flutter_template/feature/map/provider/PoliceStationProvider.dart';
import 'package:blueberry_flutter_template/feature/map/provider/SeletedPlaceProvider.dart';
import 'package:blueberry_flutter_template/model/GoogleMapPlace.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class GoogleMapWidget extends ConsumerWidget {
  final Completer<GoogleMapController> googleMapControllerCompleter;
  final LatLng locationState;
  final AsyncValue<List<Place>> policeStationsAsyncValue;

  const GoogleMapWidget({
    required this.googleMapControllerCompleter,
    required this.locationState,
    super.key,
    required this.policeStationsAsyncValue,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<Place?>(selectedPlaceProvider, (previous, next) async {
      if (next != null) {
        try {
          final controller = await googleMapControllerCompleter.future;
          await controller.animateCamera(
            CameraUpdate.newLatLng(next.location),
          );
          controller.showMarkerInfoWindow(MarkerId(next.location.toString()));
        } catch (e) {
          //Error animating camera -> talker($e)?
        }
      }
    });

    return GoogleMap(
      onMapCreated: (GoogleMapController controller) {
        if (!googleMapControllerCompleter.isCompleted) {
          googleMapControllerCompleter.complete(controller);
        }
      },
      initialCameraPosition: CameraPosition(
        target: locationState,
        zoom: 14,
      ),
      mapType: MapType.normal,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      markers: _buildMarkers(context, ref),
      circles: {
        Circle(
          center: locationState,
          circleId: CircleId('myLocation'),
          strokeColor: Colors.blue,
          radius: 1000,
          strokeWidth: 2,
          fillColor: Colors.blue.withOpacity(0.3),
        )
      },
    );
  }

  Set<Marker> _buildMarkers(BuildContext context, WidgetRef ref) {
    final policeStationsAsyncValue =
        ref.watch(policeStationsProvider(ref.watch(locationProvider)));
    final selectedPlace = ref.watch(selectedPlaceProvider);

    return policeStationsAsyncValue.maybeWhen(
      data: (policeStations) {
        return policeStations.asMap().entries.map((entry) {
          int index = entry.key;
          var station = entry.value;

          return Marker(
            markerId: MarkerId(station.location.toString()),
            position: station.location,
            infoWindow: InfoWindow(
                title: '${index + 1}. ${station.name}',
                snippet: station.phoneNumber ?? '-',
                onTap: () {
                  if (station.phoneNumber != null) {
                    final Uri phoneLaunchUri = Uri(
                      scheme: 'tel',
                      path: station.phoneNumber,
                    );
                    launchUrl(phoneLaunchUri);
                  }
                }),
            onTap: () {
              ref.read(selectedPlaceProvider.notifier).state = station;
            },
            icon:
            BitmapDescriptor.defaultMarkerWithHue(
              station == selectedPlace
                  ? BitmapDescriptor.hueAzure
                  : BitmapDescriptor.hueRed,
            ),
          );
        }).toSet();
      },
      orElse: () => {},
    );
  }
}
