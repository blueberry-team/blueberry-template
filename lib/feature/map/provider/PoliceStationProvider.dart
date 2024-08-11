import 'dart:convert';
import 'package:blueberry_flutter_template/model/GoogleMapPlace.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

//Google Map API key 등록 필요
const String apiKey = '';
// Android : AndroidManifest.xml 에 API Key와 권한 추가 필요
// iOS : AppDelegate.swift, Info.plist 에 API Key와 권한 추가 필요

Future<String?> _getPlacePhoneNumber(String placeId, String apiKey) async {
  final url = 'https://maps.googleapis.com/maps/api/place/details/json'
      '?place_id=$placeId'
      '&fields=formatted_phone_number'
      '&language=ko'
      '&key=$apiKey';

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final result = json.decode(response.body)['result'];
    return result['formatted_phone_number'];
  } else {
    return null;
  }
}

final policeStationsProvider =
    FutureProvider.family<List<Place>, LatLng>((ref, location) async {
  final url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json'
      '?location=${location.latitude},${location.longitude}'
      '&radius=1000'
      '&type=police'
      '&language=ko'
      '&key=$apiKey';

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final results = json.decode(response.body)['results'] as List;
    final places = await Future.wait(results.map((placeJson) async {
      final placeId = placeJson['place_id'];
      final phoneNumber = await _getPlacePhoneNumber(placeId, apiKey);
      return Place.fromJson(placeJson, phoneNumber);
    }).toList());
    return places;
  } else {
    throw Exception('Failed to load nearby police stations');
  }
});
