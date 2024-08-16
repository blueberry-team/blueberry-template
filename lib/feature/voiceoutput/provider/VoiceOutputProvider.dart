import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final voiceOutputProvider = StreamProvider<List<String>>((ref) {
  final firestore = FirebaseFirestore.instance;
  return firestore.collection('textInputs').snapshots().map((snapshot) {
    final textInputs =
    snapshot.docs.map((doc) => doc['textInput'] as String).toList();
    return textInputs;
  });
});
