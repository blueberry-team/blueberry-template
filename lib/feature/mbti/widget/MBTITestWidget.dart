import 'package:blueberry_flutter_template/feature/mbti/provider/MBTIProvider.dart';
import 'package:blueberry_flutter_template/feature/mbti/widget/MBTIHomeWidget.dart';
import 'package:blueberry_flutter_template/feature/mbti/widget/MBTIResultWidget.dart';
import 'package:blueberry_flutter_template/model/MBTIQuestionModel.dart';
import 'package:blueberry_flutter_template/utils/AppStringEnglish.dart';
import 'package:blueberry_flutter_template/utils/AppStrings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/AppTextStyle.dart';

class MBTITestWidget extends ConsumerWidget {
  final pageController = PageController();

  final _buttonTexts = [
    AppStrings.stronglyAgree,
    AppStrings.agree,
    AppStrings.neutral,
    AppStrings.disagree,
    AppStrings.stronglyDisagree,
  ];

  MBTITestWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mbtiQuestionList = ref.watch(mbtiQuestionProvider);
    return mbtiQuestionList.when(
        data: (data) => Column(
              children: [
                Expanded(
                    child: _buildMBTITestPageWidgetView(pageController, data)),
                _buildMBTITestWidgetView(
                    pageController, ref, _buttonTexts, data),
              ],
            ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
            child: Text(
                style: black12BoldTextStyle,
                '${AppStringEnglish.errorTitle}: $error')));
  }
}

Widget _buildMBTITestPageWidgetView(
    PageController pageController, List<MBTIQuestionModel> questions) {
  return PageView.builder(
    controller: pageController,
    itemCount: questions.length,
    itemBuilder: (BuildContext context, int index) {
      return Center(
        child: Column(
          children: [
            Text(
              questions[index].question,
              style: black24BoldTextStyle,
              textAlign: TextAlign.center,
            ),
            Image.network(
              questions[index].imageUrl,
              width: double.infinity,
              height: 300,
              fit: BoxFit.fitHeight,
            )
          ],
        ),
      );
    },
  );
}

Widget _buildMBTITestWidgetView(PageController pageController, WidgetRef ref,
    List<String> buttonText, List<MBTIQuestionModel> data) {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: buttonText.length,
    itemBuilder: (BuildContext context, int index) {
      return ListTile(
        title: TextButton(
          onPressed: () {
            // 페이지 전환 중 버튼 입력 차단
            if (pageController.page != pageController.page?.ceilToDouble()) {
              return;
            }
            ref.watch(mbtiTestProvider.notifier).updateScore(
                data[pageController.page!.toInt()].type, 2 - index);
            // 마지막 페이지 일시 결과 호출
            if (pageController.page == data.length - 1) {
              MBTIType result = ref.watch(mbtiTestProvider.notifier).setMBTI();
              Navigator.pop(context);
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return MBTIResultWidget(mbtiResult: result);
                  });
            } else {
              pageController.nextPage(
                duration: const Duration(seconds: 1),
                curve: Curves.decelerate,
              );
            }
          },
          child: Text(style: black24TextStyle, buttonText[index]),
        ),
      );
    },
  );
}
