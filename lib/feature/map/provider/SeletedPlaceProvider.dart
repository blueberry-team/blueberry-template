import 'package:blueberry_flutter_template/providers/policeMap/PoliceStationProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedPlaceProvider = StateProvider.autoDispose<Place?>((ref) => null);