import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/UserReportModel.freezed.dart';
part 'generated/UserReportModel.g.dart';

@freezed
class UserReportModel with _$UserReportModel {
  const factory UserReportModel({
    required String reportedUserId,
    required String reporterUserId,
    required String reason,
    required DateTime timestamp,
  }) = _UserReportModel;

  factory UserReportModel.fromJson(Map<String, dynamic> json) =>
      _$UserReportModelFromJson(json);
}
