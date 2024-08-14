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
      data: (data) => _buildCardView(context, ref, data),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
    );
  }
}

Widget _buildCardView(
    BuildContext context, WidgetRef ref, List<PetProfileModel> data) {
  final cardSwiperController = CardSwiperController();
  int currentIndex = 0;
  final cards = data.map(SwipeCardWidget.new).toList();

  return Column(
    children: [
      Flexible(
        child: CardSwiper(
          controller: cardSwiperController,
          cardsCount: cards.length,
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
            // 패스 버튼
            SwipeButtonWidget(
              onPressed: () =>
                  cardSwiperController.swipe(CardSwiperDirection.left),
              icon: Icons.close,
              color: Colors.greenAccent,
            ),
            const SizedBox(width: 30),
            // 좋아요 버튼
            SwipeButtonWidget(
              onPressed: () async {
                const userId = "eztqDqrvEXDc8nqnnrB8"; // 유저 ID 임시 데이터(로그인 상황 가정)
                final petId = data[currentIndex].petID;
                await addPetToFavorites(userId, petId);
                cardSwiperController.swipe(CardSwiperDirection.right);
              },
              icon: Icons.star,
              color: Colors.blueAccent,
            ),
            const SizedBox(width: 30),
            // 좋아요 버튼
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
