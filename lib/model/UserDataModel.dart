import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/UserDataModel.freezed.dart';
part 'generated/UserDataModel.g.dart';

@freezed
class UserDataModel with _$UserDataModel {
  factory UserDataModel({
    @Default('Unknown') String name,
    @Default('No email') String email,
    @Default('NULL') String mbti
  }) = _UserDataModel;

  factory UserDataModel.fromJson(Map<String, dynamic> json) =>
      _$UserDataModelFromJson(json);
}
