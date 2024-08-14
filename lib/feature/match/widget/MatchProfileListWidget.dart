import 'package:blueberry_flutter_template/model/PetProfileModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/MatchScreenProvider.dart';
import '../ProfileScreen.dart';
import 'SwipeButtonWidget.dart';
import 'SwipeCardWidget.dart';

class MatchProfileListWidget extends ConsumerWidget {
  const MatchProfileListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(matchScreenProvider);

    return list.when(
      data: (List<PetProfileModel> data) => _buildCardView(context, ref, data),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
    );
  }
}

Widget _buildCardView(
    BuildContext context, WidgetRef ref, List<PetProfileModel> data) {
  final cardSwiperController = CardSwiperController();
  int currentIndex = 0;

  // 카드 리스트를 생성
  final cards = data.map(SwipeCardWidget.new).toList();

  // 카드가 존재하는지 확인
  if (cards.isEmpty) {
    return const Center(
      child: Text('추천할 펫이 없습니다.'),
    );
  }

  return Column(
    children: [
      Flexible(
        child: CardSwiper(
          controller: cardSwiperController,
          cardsCount: cards.length,
          numberOfCardsDisplayed: 1, // 한 번에 보여지는 카드 수
          onSwipe: (previousIndex, newIndex, direction) {
            currentIndex = newIndex ?? currentIndex;

            if (direction == CardSwiperDirection.right) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      ProfileScreen(petProfile: data[previousIndex]),
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
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SwipeButtonWidget(
              onPressed: () =>
                  cardSwiperController.swipe(CardSwiperDirection.left),
              icon: Icons.close,
              color: Colors.greenAccent,
            ),
            const SizedBox(width: 30),
            SwipeButtonWidget(
              onPressed: () async {
                const userId = "eztqDqrvEXDc8nqnnrB8";
                final petId = data[currentIndex].petID;
                await addPetToFavorites(userId, petId);
                cardSwiperController.swipe(CardSwiperDirection.right);
              },
              icon: Icons.star,
              color: Colors.blueAccent,
            ),
            const SizedBox(width: 30),
            SwipeButtonWidget(
              onPressed: () =>
                  cardSwiperController.swipe(CardSwiperDirection.right),
              icon: Icons.favorite,
              color: Colors.redAccent,
            ),
          ],
        ),
      ),
    ],
  );
}

