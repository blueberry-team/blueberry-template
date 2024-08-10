import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/ChatListItemModel.freezed.dart';
part 'generated/ChatListItemModel.g.dart';

@freezed
class ChatListItemModel with _$ChatListItemModel {
  const factory ChatListItemModel({
    required String roomId,
    required String otherUserId,
    required String lastMessage,
    required DateTime lastMessageTime,
  }) = _ChatMessageModel;

  factory ChatListItemModel.fromJson(Map<String, dynamic> json) =>
      _$ChatListItemModelFromJson(json);
}
