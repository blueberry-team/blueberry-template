import 'package:blueberry_flutter_template/model/PetProfileModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/AppStrings.dart';
import '../ProfileScreen.dart';
import '../provider/MatchScreenProvider.dart';
import 'SwipeButtonWidget.dart';
import 'SwipeCardWidget.dart';

class MatchProfileListWidget extends ConsumerWidget {
  const MatchProfileListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(matchScreenProvider);

    // 스와이퍼 numberOfCardsDisplayed 설정으로 인해 데이터가 1일 때도 에러 메시지 출력
    return list.isEmpty || list.length == 1
        ? const Center(child: Text(AppStrings.noPetsMessage))
        : _buildCardView(context, ref, list);
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
            numberOfCardsDisplayed: 2,
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
              // 즐겨찾기(super like) 버튼
              SwipeButtonWidget(
                onPressed: () async {
                  const userId = "eztqDqrvEXDc8nqnnrB8";
                  final petId = data[currentIndex].petID;
                  await ref
                      .read(matchScreenProvider.notifier)
                      .addPetToSuperLikes(userId, petId);
                  cardSwiperController.swipe(CardSwiperDirection.right);
                },
                icon: Icons.star,
                color: Colors.blueAccent,
              ),
              const SizedBox(width: 30),
              // 좋아요(like) 버튼
              SwipeButtonWidget(
                onPressed: () async {
                  const userId = "eztqDqrvEXDc8nqnnrB8";
                  final petId = data[currentIndex].petID;
                  await ref
                      .read(matchScreenProvider.notifier)
                      .addPetToLikes(userId, petId);
                  cardSwiperController.swipe(CardSwiperDirection.right);
                },
                icon: Icons.favorite,
                color: Colors.redAccent,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
