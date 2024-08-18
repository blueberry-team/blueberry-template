import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/UserModel.freezed.dart';

part 'generated/UserModel.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel(
      {required String userClass,
      required String userId,
      required String name,
      required String email,
      required int age,
      required bool isMemberShip,
      required String mbti,
      required DateTime createdAt,
      required List<String> likeGivens,
      String? profileImageUrl,
      String? fcmToken,
      required bool socialLogin,
      required String socialCompany}) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
