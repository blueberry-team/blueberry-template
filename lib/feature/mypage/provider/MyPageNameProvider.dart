import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final myPageNicknameProvider = StreamProvider<String>((ref) {
  final firestore = FirebaseFirestore.instance;
  final userId = FirebaseAuth.instance.currentUser!.uid;

  return firestore.collection('users').doc(userId).snapshots().map((snapshot) {
    return snapshot['nickName'] as String;
  });
});
