import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/FriendsModel.freezed.dart';
part 'generated/FriendsModel.g.dart';

@freezed
class FriendsModel with _$FriendsModel {
  const factory FriendsModel({
    required String userId,
    required String friendId,
    required String name,
    required String profilePicture,
    required String status,
    required DateTime createdAt,
  }) = _FriendsModel;

  factory FriendsModel.fromJson(Map<String, dynamic> json) => _$FriendsModelFromJson(json);
}
