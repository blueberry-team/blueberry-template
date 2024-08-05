import 'dart:async';
import 'package:blueberry_flutter_template/providers/policeMap/SeletedPlaceProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:blueberry_flutter_template/providers/policeMap/PoliceStationProvider.dart';
import 'package:url_launcher/url_launcher.dart';

class PoliceStationListWidget extends ConsumerWidget {
  final LatLng locationState;
  final Completer<GoogleMapController> googleMapControllerCompleter;
  final AsyncValue<List<Place>> policeStationsAsyncValue;

  const PoliceStationListWidget({
    required this.locationState,
    required this.googleMapControllerCompleter,
    required this.policeStationsAsyncValue,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final policeStationsAsyncValue =
        ref.watch(policeStationsProvider(locationState));
    final selectedPlace = ref.watch(selectedPlaceProvider);

    return policeStationsAsyncValue.when(
      data: (policeStations) {
        return ListView.builder(
          itemCount: policeStations.length,
          itemBuilder: (context, index) {
            final policeStation = policeStations[index];
            final isSelected = policeStation == selectedPlace;

            return ListTile(
              tileColor: isSelected ? Colors.blue.withOpacity(0.3) : null,
              title: Text(
                '${index + 1}. ${policeStation.name}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(policeStation.phoneNumber ?? '-'),
              trailing: IconButton(
                icon: Icon(Icons.phone),
                onPressed: () {
                  final Uri phoneLaunchUri = Uri(
                    scheme: 'tel',
                    path: policeStation.phoneNumber ?? '112',
                  );
                  launchUrl(phoneLaunchUri);
                },
              ),
              onTap: () async {
                ref.read(selectedPlaceProvider.notifier).state = policeStation;

                try {
                  final controller = await googleMapControllerCompleter.future;
                  await controller.animateCamera(
                    CameraUpdate.newLatLng(policeStation.location),
                  );
                  await controller.showMarkerInfoWindow(
                    MarkerId(policeStation.location.toString()),
                  );
                } catch (e) {
                  //Error animating camera -> talker($e)?
                }
              },
            );
          },
        );
      },
      loading: () => Container(),
      error: (error, stack) => Center(child: Text('$error')),
    );
  }
}
