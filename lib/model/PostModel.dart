import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/PostModel.freezed.dart';
part 'generated/PostModel.g.dart';

@freezed
class PostModel with _$PostModel {
  const factory PostModel({
    required String title,
    required String content,
    required String imageUrl,
    required String uploadTime,
  }) = _PostModel;

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
}
