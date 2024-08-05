import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/FriendModel.freezed.dart';
part 'generated/FriendModel.g.dart';

@freezed
class FriendModel with _$FriendModel {
  const factory FriendModel({
    required String userId,
    required String friendId,
    required String name,
    required String status,
    required String imageName,
    required int likes,
    required DateTime lastConnect,
  }) = _FriendModel;

  factory FriendModel.fromJson(Map<String, dynamic> json) => _$FriendModelFromJson(json);

  // DocumentSnapshot에서 FriendModel 객체로 변환하는 팩토리 메서드
  factory FriendModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    print('프렌드 모델: $data'); // 로깅 추가
    return FriendModel(
      userId: data['userId'] as String,
      friendId: data['friendId'] as String,
      name: data['name'] as String,
      status: data['status'] as String,
      imageName: data['imageName'] as String,
      likes: data['likes'] as int,
      lastConnect: (data['lastConnect'] as Timestamp).toDate(),
    );
  }
}