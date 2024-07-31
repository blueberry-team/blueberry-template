import 'package:blueberry_flutter_template/model/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ChatScreen.dart
  Future<void> addChatMessage(String message) async {
    try {
      await _firestore.collection('chats').add({
        'message': message,
        'timestamp': DateTime.now(),
      });
    } catch (e) {
      print('Error adding message: $e');
      throw Exception('Failed to add message');
    }
  }

  Future<void> upDateUserDB(String email, String name) async {
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
        isMemberShip: false,
        profileImageUrl: '',
        createdAt: DateTime.now(),
        userClass: 'user',
      );

      await _firestore.collection('users').doc(user.uid).set(newUser.toJson());
    } catch (e) {
      print('Error updating user: $e');
      throw Exception('Failed to update user');
    }
  }
  Future<void> updateUserMemberShip() async {
    try {
      var user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw Exception('No current user found');
      }

      await _firestore.collection('users').doc(user.uid).update({
        'isMemberShip': true,
      });
    } catch (e) {
      print('Error updating user membership: $e');
      throw Exception('Failed to update user membership');
    }
  }
}
