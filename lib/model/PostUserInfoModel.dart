import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/PostUserInfoModel.freezed.dart';
part 'generated/PostUserInfoModel.g.dart';

@freezed
class PostUserInfoModel with _$PostUserInfoModel {
  const factory PostUserInfoModel({
    required String name,
    required String profileImageUrl,
  }) = _PostUserInfoModel;

  factory PostUserInfoModel.fromJson(Map<String, dynamic> json) =>
      _$PostUserInfoModelFromJson(json);
}
