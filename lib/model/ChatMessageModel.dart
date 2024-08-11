import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/ChatMessageModel.freezed.dart';
part 'generated/ChatMessageModel.g.dart';

@freezed
class ChatMessageModel with _$ChatMessageModel {
  const factory ChatMessageModel({
    required String senderId,
    required String message,
    required DateTime timestamp,
    required bool isRead,
  }) = _ChatMessageModel;

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageModelFromJson(json);
}
