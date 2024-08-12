import 'package:blueberry_flutter_template/model/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
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
        mbti: 'NULL',
        socialLogin: false,
        socialCompany: '이메일 로그인을 사용 중 입니다.',
        createdAt: DateTime.timestamp(),
        userClass: 'user',
        likeGivens: [""],
      );
      // 멤버쉽 모델은 추후에 인앱 결제시 유저가 구독하고 있거나 유저 상태에 대한 변경을 주기 위해 추가했음
      await _firestore.collection('users').doc(user.uid).set(newUser.toJson());
    } catch (e) {
      print('Error updating user: $e');
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
      print('Error updating user membership: $e');
      throw Exception('Failed to update user membership');
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
      print('Error creating chat room: $e');
      throw Exception('Failed to create chat room');
    }
  }
}
