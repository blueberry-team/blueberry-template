import 'package:blueberry_flutter_template/model/UserModel.dart';
import 'package:blueberry_flutter_template/services/FirebaseAuthServiceProvider.dart';
import 'package:blueberry_flutter_template/utils/AppStrings.dart';
import 'package:blueberry_flutter_template/utils/Talker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/ChatMessageModel.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ChatScreen.dart
  Future<void> addChatMessage(String roomId, String message) async {
    final messageRef = FirebaseDatabase.instance.ref("chats/$roomId/messages");
    var user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception('No current user found');
    }

    final snapshot = await messageRef.get();
    final int nextIndex = snapshot.children.length;

    final newMessage = ChatMessageModel(
      senderId: user.uid,
      message: message,
      timestamp: DateTime.now(),
      isRead: false,
    );

    final json = newMessage.toJson();
    json['timestamp'] = newMessage.timestamp.millisecondsSinceEpoch;
    await messageRef.child(nextIndex.toString()).set(json);
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
        createdAt: DateTime.timestamp(),
        mbti: 'NULL',
        socialLogin: false,
        socialCompany: AppStrings.usingEmailLogin,
        userClass: 'user',
        likeGivens: [""],
      );
      // 멤버쉽 모델은 추후에 인앱 결제시 유저가 구독하고 있거나 유저 상태에 대한 변경을 주기 위해 추가했음
      await _firestore.collection('users').doc(user.uid).set(newUser.toJson());
    } catch (e) {
      talker.error('Error updating user: $e');
      throw Exception('Failed to update user');
    }
  }

  Future<void> updateUserMemberShip() async {
    // 인앱 멤버쉽 결제시 호출해서 업데이트 함
    try {
      var user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw Exception('No current user found');
      }

      await _firestore.collection('users').doc(user.uid).update({
        'isMemberShip': true,
      });
    } catch (e) {
      talker.error('Error updating user membership: $e');
      throw Exception('Failed to update user membership');
    }
  }

  Future<void> requestAccountDeletion(
      BuildContext context, WidgetRef ref) async {
    try {
      var user = FirebaseAuth.instance.currentUser!.uid;
      final callable =
          FirebaseFunctions.instance.httpsCallable('requestAccountDeletion');
      talker.log('Calling Firebase Function: requestAccountDeletion');
      final result = await callable.call();

      talker.log('Firebase Function response: ${result.data}');

      if (result.data['success'] == true) {
        talker.log('탈퇴 요청을 성공적으로 보냈습니다');
        await ref.read(firebaseAuthServiceProvider).signOut();
      } else {
        talker.error('탈퇴 요청 실패: ${result.data['message']}');
        throw Exception('탈퇴 요청 실패: ${result.data['message']}');
      }
    } on FirebaseFunctionsException catch (e) {
      talker.error('Firebase Function 오류: ${e.code} - ${e.message}');
      throw Exception('Firebase Function 오류: ${e.message}');
    } catch (e) {
      talker.error('계정 삭제 요청 중 오류 발생: $e');
      throw Exception('계정 삭제 요청 중 오류 발생: $e');
    }
  }

  Future<void> cancelAccountDeletion() async {
    try {
      var user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw Exception('No current user found');
      }

      await _firestore.collection('users').doc(user.uid).update({
        'deletionRequestedAt': FieldValue.delete(),
        'status': FieldValue.delete(),
        'scheduledDeletionTime': FieldValue.delete(),
      });
    } catch (e) {
      talker.error('Error canceling account deletion: $e');
      throw Exception('Failed to cancel account deletion');
    }
  }

  // 채팅방 생성 함수
  Future<void> createChatRoom(String roomName) async {
    try {
      await _firestore.collection('chatRoomList').add({
        'roomName': roomName,
        'timestamp': DateTime.now(),
      });
    } catch (e) {
      talker.error('Error creating chat room: $e');
      throw Exception('Failed to create chat room');
    }
  }

  Future<bool> checkDeletionRequest(String uid) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(uid).get();

      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        return userData['deletionRequestedAt'] != null;
      }

      return false; // 문서가 존재하지 않으면 삭제 요청이 없는 것으로 간주
    } catch (e) {
      talker.error('삭제 요청 확인 중 오류 발생: $e');
      throw Exception('사용자 상태 확인 실패: $e');
    }
  }
}
