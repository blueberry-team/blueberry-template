import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/PostModel.freezed.dart';
part 'generated/PostModel.g.dart';

@freezed
class PostModel with _$PostModel {
  const factory PostModel({
    required String content,
    required String imageUrl,
    required DateTime createdAt,
    required num likesCount,
    required num dislikesCount,
    required num commentsCount,
    required String userID,
    required String postID,
  }) = _PostModel;

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
}
