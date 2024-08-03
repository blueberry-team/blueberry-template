import 'package:blueberry_flutter_template/model/UserModel.dart';
import 'package:blueberry_flutter_template/utils/Talker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ProviderContainer container = ProviderContainer();

  // ChatScreen.dart
  Future<void> addChatMessage(String message) async {
    try {
      await _firestore.collection('chats').add({
        'message': message,
        'timestamp': DateTime.now(),
      });
      talker.info('Message added: $message');
    } catch (e, stack) {
      talker.error('Error adding message', e, stack); // 오류 기록
      throw Exception('Failed to add message');
    }
  }

  Future<void> updateUserDB(String email, String name) async {
    try {
      var user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw Exception('No current user found');
      }

      UserModel newUser = UserModel(
        userId: user.uid,
        name: name,
        email: email,
        age: 1,
        profileImageUrl: '',
        createdAt: DateTime.now(),
        userClass: 'user',
      );

      await _firestore.collection('users').doc(user.uid).set(newUser.toJson());
      talker.info('User updated: $newUser');
    } catch (e, stack) {
      talker.error('Error updating user', e, stack);
      throw Exception('Failed to update user');
    }
  }
}
