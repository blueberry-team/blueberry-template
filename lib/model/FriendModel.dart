import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/FriendModel.freezed.dart';

part 'generated/FriendModel.g.dart';

@freezed
class FriendModel with _$FriendModel {
  const factory FriendModel({
    required String userID,
    required String name,
    required String status,
    required String imageName,
    required int likes,
    @JsonKey(fromJson: fromJsonTimestamp, toJson: toJsonTimestamp)
    required DateTime lastConnect,
  }) = _FriendModel;

  factory FriendModel.fromJson(Map<String, dynamic> json) =>
      _$FriendModelFromJson(json);
}

// Timestamp 변환 함수 서비스에 두고 임포트해서 사용 예정(해당 방식 리뷰 필요)
// 최상위 함수로 Timestamp 변환 함수 정의
DateTime fromJsonTimestamp(Timestamp timestamp) => timestamp.toDate();

Timestamp toJsonTimestamp(DateTime date) => Timestamp.fromDate(date);
