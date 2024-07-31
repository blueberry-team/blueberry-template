import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker/talker.dart';

final talkerProvider = Provider<Talker>((ref) {
  return Talker();
});
