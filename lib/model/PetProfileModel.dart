import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/PetProfileModel.freezed.dart';
part 'generated/PetProfileModel.g.dart';

@freezed
class PetProfileModel with _$PetProfileModel {
  const factory PetProfileModel({
    required String name,
    required String gender,
    required String breed,
    required String bio,
    required String imageUrl,
    required String location,
    required String petID,
    required String userID,
  }) = _PetProfileModel;

  factory PetProfileModel.fromJson(Map<String, dynamic> json) =>
      _$PetProfileModelFromJson(json);
}
