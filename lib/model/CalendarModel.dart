import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/CalendarModel.freezed.dart';

part 'generated/CalendarModel.g.dart';

@freezed
class CalendarModel with _$CalendarModel {
  const factory CalendarModel({
    required int currentMonth,
    required int currentYear,
    required List<DateTime> dateTime,
    required int totalCnt,
    required int bodyWeekCnt,
    required int lastWeekDays,
    required int totalWeekCnt,
    required int firstWeekDays,
  }) = _CalendarModel;

  factory CalendarModel.fromJson(Map<String, dynamic> json) =>
      _$CalendarModelFromJson(json);
}
var calendar = CalendarModel(
  currentMonth: DateTime.now().month,
  currentYear: DateTime.now().year,
  dateTime: [],
  totalCnt: 0,
  bodyWeekCnt: 0,
  lastWeekDays: 0,
  totalWeekCnt: 0,
  firstWeekDays: 0,
);