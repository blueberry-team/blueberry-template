import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/AppStrings.dart';
import 'widget/MatchProfileListWidget.dart';
import 'widget/MatchFilterWidget.dart';

///  MatchScreen - 프로필 스와이프 매칭 화면
///
///  주요 구성 요소:
///  - SwipeCardWidget: 프로필 카드를 스와이프할 수 있는 위젯
///  - SwipeButtonWidget: 수동으로 좌/우 스와이프를 할 수 있는 버튼

class MatchScreen extends StatelessWidget {
  static const String name = 'MatchScreen';
  const MatchScreen({super.key});

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const MatchFilterWidget();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppStrings.appbar_Text_Logo,
          style: GoogleFonts.lobster(
            textStyle: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              _showFilterBottomSheet(context);
            },
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.only(bottom: 36.0),
        child: Center(
          child: MatchProfileListWidget(),
        ),
      ),
    );
  }
}
