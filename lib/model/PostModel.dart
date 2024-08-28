import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'generated/PostModel.freezed.dart';
part 'generated/PostModel.g.dart';

@freezed
class PostModel with _$PostModel {
  const factory PostModel({
    required String content,
    required String imageUrl,
    @JsonKey(fromJson: _fromJsonTimestamp, toJson: _toJsonTimestamp) required DateTime createdAt,
    required num likesCount,
    required num commentsCount,
    required String userID,
    required String postID,
  }) = _PostModel;

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
}

// Firestore Timestamp -> DateTime 변환 함수
DateTime _fromJsonTimestamp(Timestamp timestamp) => timestamp.toDate();

// DateTime -> Firestore Timestamp 변환 함수
Timestamp _toJsonTimestamp(DateTime date) => Timestamp.fromDate(date);

