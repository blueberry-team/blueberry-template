import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/CommentModel.freezed.dart';
part 'generated/CommentModel.g.dart';

@freezed
class CommentModel with _$CommentModel {
  const factory CommentModel({
    required String commentID,
    required String postID,
    required String userID,
    required String content,
    required DateTime createdAt,
  }) = _CommentModel;

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);
}
