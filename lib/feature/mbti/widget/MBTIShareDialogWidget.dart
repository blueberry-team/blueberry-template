import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk_share/kakao_flutter_sdk_share.dart';

import '../../../utils/AppTextStyle.dart';

class MBTIShareDialogWidget extends ConsumerWidget {
  const MBTIShareDialogWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      child: Container(
          width: MediaQuery.of(context).size.width * 0.3,
          height: 200,
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      shareOnKakao();
                    },
                    child: const Text(style: black16BoldTextStyle, 'KakaoTalk'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(style: black16BoldTextStyle, 'Link'),
                  )
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(style: black16BoldTextStyle, 'close'),
              ),
            ],
          )),
    );
  }

  Future<void> shareOnKakao() async {
    // bool isKakaoTalkSharingAvailable = await ShareClient.instance
    //     .isKakaoTalkSharingAvailable();
    // final kakaoShareTemplateId = kakaoShareTemplate;

    // if (isKakaoTalkSharingAvailable) {
    //   // 카카오톡 공유
    //   try {
    //     Uri uri =
    //     await ShareClient.instance.shareCustom(
    //         templateId: kakaoShareTemplateId);
    //     await ShareClient.instance.launchKakaoTalk(uri);
    //     print('카카오톡 공유 완료');
    //   } catch (error) {
    //     print('카카오톡 공유 실패 $error');
    //   }
    // } else {
    //   try {
    //     Uri shareUrl = await WebSharerClient.instance.makeCustomUrl(
    //         templateId: kakaoShareTemplateId, templateArgs: {'key1': 'value1'});
    //     await launchBrowserTab(shareUrl, popupOpen: true);
    //   } catch (error) {
    //     print('카카오톡 공유 실패 $error');
    //   }
    // }
    // else {
    // 카카오톡 미설치 웹으로 공유
    //
    // }
  }
}

// kakao Share Template
final FeedTemplate kakaoShareTemplate = FeedTemplate(
  content: Content(
    title: '펫팅 MBTI 공유하기!',
    description: '#펫 #반려동물 #MBTI #동물 #강아지 #고양이 #소개팅',
    imageUrl: Uri.parse('https://DefaultImage.png'),
    link: Link(
        webUrl: Uri.parse('https://DEFAULT_URL'),
        mobileWebUrl: Uri.parse('https://DEFAULT_MOBILE_URL')),
  ),
  itemContent: ItemContent(
    profileText: 'PETTING',
    profileImageUrl: Uri.parse('https://PETTING_IMAGE2.png'),
    titleImageUrl: Uri.parse('https://PETTING_IMAGE3.png'),
    titleImageText: 'Pet cake',
    titleImageCategory: 'petCake',
    items: [
      ItemInfo(item: 'pet_dog', itemOp: '1등'),
      ItemInfo(item: 'pet_cat', itemOp: '2등'),
      ItemInfo(item: 'pet_lizard', itemOp: '3등'),
      ItemInfo(item: 'pet_fish', itemOp: '4등'),
      ItemInfo(item: 'pet_hamster', itemOp: '5등')
    ],
    sum: 'total',
    sumOp: '15000원',
  ),
  social: Social(likeCount: 286, commentCount: 45, sharedCount: 845),
  buttons: [
    Button(
      title: '웹으로 보기',
      link: Link(
        webUrl: Uri.parse('https: //developers.kakao.com'),
        mobileWebUrl: Uri.parse('https: //developers.kakao.com'),
      ),
    ),
    Button(
      title: '앱으로보기',
      link: Link(
        androidExecutionParams: {'key1': 'value1', 'key2': 'value2'},
        iosExecutionParams: {'key1': 'value1', 'key2': 'value2'},
      ),
    ),
  ],
);
