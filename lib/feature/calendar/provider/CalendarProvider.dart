import 'package:blueberry_flutter_template/model/CalendarModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final calendarProvider =
    StateNotifierProvider<CalendarBodyNotifier, CalendarModel>(
        (ref) => CalendarBodyNotifier(calendar));

class CalendarBodyNotifier extends StateNotifier<CalendarModel> {
  CalendarBodyNotifier(super.state);

  void setMonth(int month) {
    state = state.copyWith(currentMonth: month);
    setCalendarBody();
  }

  void setYear(int year) {
    state = state.copyWith(currentYear: year);
    setCalendarBody();
  }

  //TODO: 6,9월과 같이 30일 날짜를 가진 월은 range error(34 index 접근) 수정
  void setCalendarBody() {
    setDate(state.currentMonth, state.currentYear);
    getTotalWeeks();
  }

  ///* 해당 월의 날짜를 리스트에 저장하는 로직Ï
  void setDate(int month, int year) {
    final lastDay = DateTime(year, month + 1, 0);
    final firstDay = DateTime(year, month, 1);
    final int totalDate = lastDay.difference(firstDay).inDays;
    final dateTime = List.generate(
        totalDate + 1, (index) => firstDay.add(Duration(days: index)));
    state = state.copyWith(dateTime: dateTime);
  }

  ///* 캘린더에서 날짜의 위치를 계산하는 로직
  void getTotalWeeks() {
    final firstWeekDays = 7 - state.dateTime[0].weekday;
    final totalCnt = state.dateTime.length;
    final bodyWeekCnt = (totalCnt - firstWeekDays) ~/ 7;
    final lastWeekDays = (totalCnt - firstWeekDays) % 7;
    int totalWeekCnt = bodyWeekCnt + 1;
    if (lastWeekDays != 0) {
      totalWeekCnt += 1;
    }
    state = state.copyWith(
      totalCnt: totalCnt,
      bodyWeekCnt: bodyWeekCnt,
      lastWeekDays: lastWeekDays,
      totalWeekCnt: totalWeekCnt,
      firstWeekDays: firstWeekDays,
    );
  }
}
