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
}