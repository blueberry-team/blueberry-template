import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place {
  final String name;
  final LatLng location;
  final String? phoneNumber;

  Place({required this.name, required this.location, this.phoneNumber});

  factory Place.fromJson(Map<String, dynamic> json, String? phoneNumber) {
    final location = json['geometry']['location'];
    return Place(
      name: json['name'],
      location: LatLng(location['lat'], location['lng']),
      phoneNumber: phoneNumber,
    );
  }
}