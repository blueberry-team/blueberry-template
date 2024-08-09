part of 'CalendarScreen.dart';

class CalendarHeaderWidget extends StatelessWidget {
  final int selectYear;
  final int selectMonth;
  final VoidCallback setYear;
  final VoidCallback setMonth;

  const CalendarHeaderWidget(
      {super.key,
      required this.selectYear,
      required this.selectMonth,
      required this.setYear,
      required this.setMonth});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icon/ic_left_arrow.svg',
          ),
          //TODO: 하드코딩 변경
          Expanded(
            child: Row(children: [
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
          SvgPicture.asset(
            'assets/icon/ic_right_arrow.svg',
          ),
        ],
      ),
    );
  }

  Widget _changeDate({required int date, required VoidCallback changeDate}) {
    const color = Color(0xFF000000);
    final textStyle = TextStyle(
      fontSize: 16.sp,
      height: 20 / 16,
      fontWeight: FontWeight.w700,
      color: color,
      //fontFamily: 'Urbanist',
    );
    return Padding(
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
          "assets/icon/ic_down_arrow.svg",
          height: 20.w,
        ),
      ]),
    );
  }
}
