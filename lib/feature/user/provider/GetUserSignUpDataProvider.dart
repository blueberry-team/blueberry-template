import 'package:blueberry_flutter_template/utils/AppStrings.dart';
import 'package:blueberry_flutter_template/utils/Formatter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getUserSignUpProvider = StreamProvider<String>((ref) {
  final firestore = FirebaseFirestore.instance;
  final userId = FirebaseAuth.instance.currentUser!.uid;

  return firestore.collection('users').doc(userId).snapshots().map((snapshot) {
    final createdAt = snapshot.get('createdAt');
    if (createdAt is Timestamp) {
      return formatTimestamp(createdAt);
    } else {
      return AppStrings.dateTextWidgetError;
    }
  });
});
