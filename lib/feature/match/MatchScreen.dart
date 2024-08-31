import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widget/MatchProfileListWidget.dart';
import 'widget/MatchFilterWidget.dart';

///  MatchScreen - 프로필 스와이프 매칭 화면
///  완성 8월 18일 상현

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
        title: Text(
          'Petting',
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
