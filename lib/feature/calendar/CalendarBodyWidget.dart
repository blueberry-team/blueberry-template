part of 'CalendarScreen.dart';

class CalendarBodyWidget extends StatelessWidget {
  final CalendarModel data;

  const CalendarBodyWidget({
    super.key,
    required this.data,
  });

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
        ...List.generate(data.totalWeekCnt, (week) {
          if (week == 0) {
            return Row(children: [
              ...List.generate(data.dateTime[0].weekday, (_) => _emptyItem()),
              ...List.generate(data.firstWeekDays,
                  (idx) => _dateItem(data.dateTime[idx].day.toString())),
            ]);
          }
          if (week == data.totalWeekCnt - 1 && data.lastWeekDays != 0) {
            return Row(mainAxisSize: MainAxisSize.max, children: [
              ...List.generate(
                  data.lastWeekDays,
                  (idx) =>
                      _dateItem(data.dateTime[7 * week + idx - 1].day.toString())),
              ...List.generate(data.dateTime[0].weekday, (_) => _emptyItem()),
            ]);
          }

          return Row(
              children: List.generate(
            7,
            (idx) => _dateItem(
                data.dateTime[7 * (week - 1) + idx + data.firstWeekDays].day.toString()),
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
