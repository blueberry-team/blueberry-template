part of 'CalendarScreen.dart';

class CalendarBodyWidget extends StatefulWidget {
  CalendarBodyWidget({super.key});

  @override
  State<CalendarBodyWidget> createState() => _CalendarBodyWidgetState();
}

class _CalendarBodyWidgetState extends State<CalendarBodyWidget> {
  List<DateTime> dateTime = [];
  final List<String> date = ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"];

  //TODO: 해당 로직 provider로 분리 예정
  void setDate(int month, int year) {
    final lastDay = DateTime(year, month + 1, 0);
    final firstDay = DateTime(year, month, 1);
    final int totalDate = lastDay.difference(firstDay).inDays;
    dateTime = List.generate(
        totalDate, (index) => firstDay.add(Duration(days: index)));
  }

  @override
  void initState() {
    super.initState();
    setDate(DateTime.now().month, DateTime.now().year);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: List.generate(
            DateTime.daysPerWeek,
            (idx) => _dateItem(date[idx]),
          ),
        ),
        Wrap(
          children: [
            ...List.generate(
              //TODO: 1일의 요일에 따른 배치 변경
              dateTime.length,
              (idx) => _dateItem(dateTime[idx].day.toString()),
            ),
          ],
        )
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
      padding: EdgeInsets.symmetric(vertical: 14.w, horizontal: 5.4.w),
      width: 50.29.w,
      child: Text(
        item,
        style: textStyle,
      ),
    );
  }
}
