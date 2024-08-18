part of 'CalendarScreen.dart';

class CalendarHeaderWidget extends StatelessWidget {
  final int selectYear;
  final int selectMonth;
  final Function(int) setYear;
  final Function(int) setMonth;

  const CalendarHeaderWidget(
      {super.key,
      required this.selectYear,
      required this.selectMonth,
      required this.setYear,
      required this.setMonth});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 14.w,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _changeMonth(
            addMonth: false,
            changeMonth: setMonth,
          ),
          //월, 년 상태 및 변경
          Expanded(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              _changeDate(
                date: selectMonth,
                changeDate: setMonth,
              ),
              _changeDate(
                date: selectYear,
                changeDate: setYear,
              ),
            ]),
          ),
          _changeMonth(
            addMonth: true,
            changeMonth: setMonth,
          ),
        ],
      ),
    );
  }

  Widget _changeMonth(
      {required bool addMonth, required Function(int) changeMonth}) {
    return GestureDetector(
        onTap: () {
          addMonth
              ? changeMonth(selectMonth + 1)
              : changeMonth(selectMonth - 1);
        },
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: SvgPicture.asset(
            addMonth ? Assets.icon.icRightArrow : Assets.icon.icLeftArrow,
            height: 20.w,
          ),
        ));
  }

  Widget _changeDate({required int date, required Function(int) changeDate}) {
    const color = Color(0xFF000000);
    final textStyle = TextStyle(
      fontSize: 16.sp,
      height: 20 / 16,
      fontWeight: FontWeight.w700,
      color: color,
      //fontFamily: 'Urbanist',
    );
    return GestureDetector(
      onTap: () => changeDate,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(children: [
          Text(
            '$date',
            style: textStyle,
          ),
          SizedBox(
            width: 8.w,
          ),
          SvgPicture.asset(
            Assets.icon.icDownArrow,
            height: 20.w,
          ),
        ]),
      ),
    );
  }
}
