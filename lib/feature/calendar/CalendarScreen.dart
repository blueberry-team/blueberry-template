import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/AppStrings.dart';

part 'CalendarHeaderWidget.dart';

part 'CalendarBodyWidget.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //TODO: 하드 코딩 변경
        CalendarHeaderWidget(
          selectYear: DateTime.now().year,
          selectMonth: DateTime.now().month,
          setYear: () {},
          setMonth: () {},
        ),
        CalendarBodyWidget(),
      ],
    );
  }
}
