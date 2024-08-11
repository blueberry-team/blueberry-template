import 'package:blueberry_flutter_template/feature/map/provider/PoliceStationProvider.dart';
import 'package:blueberry_flutter_template/model/GoogleMapPlace.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedPlaceProvider = StateProvider.autoDispose<Place?>((ref) => null);