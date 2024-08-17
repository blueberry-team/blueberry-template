part of 'CalendarScreen.dart';

class CalendarBodyWidget extends StatefulWidget {
  const CalendarBodyWidget({super.key});

  @override
  State<CalendarBodyWidget> createState() => _CalendarBodyWidgetState();
}

class _CalendarBodyWidgetState extends State<CalendarBodyWidget> {
  List<DateTime> dateTime = [];
  int firstWeekDays = 0;
  int totalCnt = 0;
  int bodyWeekCnt = 0;
  int lastWeekDays = 0;
  int totalWeekCnt = 0;

  //TODO: 해당 로직 provider로 분리 예정

  ///* 해당 월의 날짜를 리스트에 저장하는 로직
  void setDate(int month, int year) {
    final lastDay = DateTime(year, month + 1, 0);
    final firstDay = DateTime(year, month, 1);
    final int totalDate = lastDay.difference(firstDay).inDays;
    dateTime = List.generate(
        totalDate + 1, (index) => firstDay.add(Duration(days: index)));
  }

  ///* 캘린더에서 날짜의 위치를 계산하는 로직
  void getTotalWeeks() {
    firstWeekDays = 7 - dateTime[0].weekday;
    totalCnt = dateTime.length;
    bodyWeekCnt = (totalCnt - firstWeekDays) ~/ 7;
    lastWeekDays = (totalCnt - firstWeekDays) % 7;
    totalWeekCnt = bodyWeekCnt + 1;
    if (lastWeekDays != 0) {
      totalWeekCnt += 1;
    }
  }

  @override
  void initState() {
    super.initState();
    setDate(DateTime.now().month, DateTime.now().year);
    getTotalWeeks();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: List.generate(
            DateTime.daysPerWeek,
            (idx) => _dateItem(AppStrings.date[idx]),
          ),
        ),
        ...List.generate(totalWeekCnt, (week) {
          if (week == 0) {
            return Row( children: [
              ...List.generate(dateTime[0].weekday, (_) => _emptyItem()),
              ...List.generate(firstWeekDays,
                  (idx) => _dateItem(dateTime[idx].day.toString())),
            ]);
          }
          if (week == totalWeekCnt - 1 && lastWeekDays != 0) {
            return Row(mainAxisSize: MainAxisSize.max, children: [
              ...List.generate(
                  lastWeekDays,
                  (idx) =>
                      _dateItem(dateTime[7 * week + idx - 1].day.toString())),
              ...List.generate(dateTime[0].weekday, (_) => _emptyItem()),
            ]);
          }

          return Row(
              children: List.generate(
                7,
                (idx) => _dateItem(
                    dateTime[7 * (week - 1) + idx + firstWeekDays]
                        .day
                        .toString()),
              ));
        }),
      ],
    );
  }

  Widget _dateItem(String item) {
    final color = Color(0xFF5E5E5E);
    final textStyle = TextStyle(
      fontSize: 14.sp,
      height: 16 / 14,
      fontWeight: FontWeight.w500,
      color: color,
      //fontFamily: 'Urbanist',
    );
    return Container(
      alignment: Alignment.center,
      // padding: EdgeInsets.symmetric(vertical: 14.w, horizontal: 5.4.w),
      width: 50.29.w,
      height: 64.w,
      child: Text(
        item,
        style: textStyle,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _emptyItem() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 14.w, horizontal: 5.4.w),
      width: 50.29.w,
      height: 64.w,
      color: Colors.transparent,
    );
  }
}
