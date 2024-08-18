/*
 구현중입니다.
 기능: 제철 음식 - 캘린더 기능 구현
 24.08.18 김민서 @kimwest00
 * Provider 관련 버그 수정(init)
 * 월별 예외 버그 수정(30일인 날짜의 경우 로직상 버그 발생)
*/
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../gen/assets.gen.dart';
import '../../model/CalendarModel.dart';
import '../../utils/AppStrings.dart';
import 'provider/CalendarProvider.dart';

part 'CalendarHeaderWidget.dart';

part 'CalendarBodyWidget.dart';

class CalendarScreen extends ConsumerWidget {
  static const String name = 'CalendarScreen';

  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(calendarProvider.notifier);
    final calenderStatus = ref.watch(calendarProvider);
    //TODO: init data 로직을 여기서 수행하면 에러 발생
     //At least listener of the StateNotifier Instance of 'CalendarBodyNotifier' threw an exception when the notifier tried to update its state.//
    // provider.setCalendarBody();
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
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            children: [
              //TODO: 하드 코딩 변경
              CalendarHeaderWidget(
                selectYear: calenderStatus.currentYear,
                selectMonth: calenderStatus.currentMonth,
                setYear: provider.setYear,
                setMonth: provider.setMonth,
              ),
              CalendarBodyWidget(
                data: calenderStatus,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
