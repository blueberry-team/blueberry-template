import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../gen/assets.gen.dart';
import '../../utils/AppStrings.dart';

part 'CalendarHeaderWidget.dart';

part 'CalendarBodyWidget.dart';

class CalendarScreen extends ConsumerWidget {
  static const String name = 'CalendarScreen';

  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back)),
          title: Text(
            AppStrings.calendarScreenTitle,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 11.5.w),
          child: Column(
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
      ),
    );
  }
}
