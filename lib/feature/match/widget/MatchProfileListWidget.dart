import 'package:blueberry_flutter_template/model/DogProfileModel.dart';
import 'package:blueberry_flutter_template/utils/Talker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/MatchScreenProvider.dart';
import '../ProfileScreen.dart';
import 'SwipeButtonWidget.dart';
import 'SwipeCardWidget.dart';

/// MatchProfileListWidget - 메인 위젯으로, SwipeCard, SwipeButton와 CardSwiperController을 통해 매칭 기능을 구현함

class MatchProfileListWidget extends ConsumerWidget {
  const MatchProfileListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(matchScreenProvider);

    return list.when(
      data: (data) => _buildCardView(context, ref, data),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
    );
  }
}

Widget _buildCardView(
    BuildContext context, WidgetRef ref, List<DogProfileModel> data) {
  final cardSwiperController = CardSwiperController();
  int currentIndex = 0; // 현재 화면에 보이는 펫 카드의 인덱스
  final cards = data.map(SwipeCardWidget.new).toList();

  return Column(
    children: [
      Flexible(
        child: CardSwiper(
          controller: cardSwiperController,
          cardsCount: cards.length,
          onSwipe: (previousIndex, newIndex, direction) {
            // 스와이프 할 때마다 인덱스를 업데이트
            currentIndex = newIndex ?? currentIndex;
            talker.info("currentIndex: $currentIndex");

            if (direction == CardSwiperDirection.right) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      ProfileScreen(dogProfile: data[previousIndex]),
                ),
              );
            }
            return true;
          },
          cardBuilder: (
              context,
              index,
              horizontalThresholdPercentage,
              verticalThresholdPercentage,
              ) =>
          cards[index],
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SwipeButtonWidget(
            onPressed: () => cardSwiperController.swipe(CardSwiperDirection.left), // pass
            icon: Icons.close,
            color: Colors.greenAccent,
          ),
          SwipeButtonWidget(
            onPressed: () async {
              const userId = "eztqDqrvEXDc8nqnnrB8"; // userId 임시로 하드 코딩
              final petId = data[currentIndex].petID; // 현재 표시된 pet의 ID를 취득
              talker.info("petId: $petId");

              await addPetToFavorites(userId, petId);
              cardSwiperController.swipe(CardSwiperDirection.right);
            },
            icon: Icons.star,
            color: Colors.blueAccent,
          ),
          SwipeButtonWidget(
            onPressed: () => cardSwiperController.swipe(CardSwiperDirection.right), // 좋아요
            icon: Icons.favorite,
            color: Colors.redAccent,
          ),
        ],
      ),
    ],
  );
}
