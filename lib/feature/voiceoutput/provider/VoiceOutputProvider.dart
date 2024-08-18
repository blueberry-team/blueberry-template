import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final voiceOutputProvider = StreamProvider<List<String>>((ref) {
  final firestore = FirebaseFirestore.instance;

  return firestore.collection('voiceOutputs').snapshots().map((snapshot) {
    final voiceOutputs =
        snapshot.docs.map((doc) => doc['voiceOutput'] as String).toList();
    return voiceOutputs;
  });
});
