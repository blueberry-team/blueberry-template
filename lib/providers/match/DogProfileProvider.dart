import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../model/DogProfileModel.dart';

final dogProfilesProvider = FutureProvider((ref) async {
  final firestore = FirebaseFirestore.instance;
  final snapshot = await firestore.collection('dogProfiles').get();
  return snapshot.docs.map((doc) => DogProfileModel.fromJson(doc.data())).toList();
});