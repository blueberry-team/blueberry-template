import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/ChatListItemModel.dart';
import '../../../model/ChatMessageModel.dart';

final roomIdProvider = StateProvider<String>((ref) {
  return '';
});

final loadRoomListProvider =
    FutureProvider<List<ChatListItemModel>>((ref) async {
  final firestore = FirebaseFirestore.instance;
  var user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    throw Exception('No current user found');
  }

  final docSnapshot =
      await firestore.collection('chatRooms').doc(user.uid).get();

  if (docSnapshot.exists) {
    final data = docSnapshot.data();
    final List<dynamic> rooms = data?['rooms'] ?? [];
    final List<ChatListItemModel> roomList = [];

    for (var roomId in rooms) {
      final roomSnapshot = await FirebaseDatabase.instance
          .ref("chats/$roomId")
          .orderByKey()
          .get();

      if (roomSnapshot.value != null) {
        final roomData = roomSnapshot.value as Map<dynamic, dynamic>;
        final value = ChatListItemModel(
          roomId: roomId,
          otherUserId: roomData['senderId'] == user.uid
              ? roomData['receiverId']
              : roomData['senderId'],
          lastMessage: roomData['lastMessage'],
          lastMessageTime:
              DateTime.fromMillisecondsSinceEpoch(roomData['lastMessageTime']),
        );
        roomList.add(value);
      }
    }
    return roomList;
  } else {
    return [];
  }
});

final chatMessageListProvider =
    StreamProvider.family<List<ChatMessageModel>, String>((ref, roomId) async* {
  final roomSnapshot =
      await FirebaseDatabase.instance.ref("chats/$roomId").get();

  if (roomSnapshot.exists) {
    final roomData = roomSnapshot.value as Map<dynamic, dynamic>;
    final messageData = roomData['messages'] as List<dynamic>;
    List<ChatMessageModel> messages = [];

    for (var message in messageData) {
      messages.add(ChatMessageModel(
        senderId: message['senderId'],
        message: message['message'],
        timestamp: DateTime.fromMillisecondsSinceEpoch(message['timestamp']),
        isRead: message['isRead'],
      ));
    }
    messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    yield messages;
  } else {
    yield [];
  }
});
