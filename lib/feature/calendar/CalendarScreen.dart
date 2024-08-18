import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../gen/assets.gen.dart';
import '../../utils/AppStrings.dart';

part 'CalendarHeaderWidget.dart';

part 'CalendarBodyWidget.dart';

class CalendarScreen extends StatefulWidget {
  static const String name = 'CalendarScreen';

  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
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
        ),
      ),
    );
  }
}
