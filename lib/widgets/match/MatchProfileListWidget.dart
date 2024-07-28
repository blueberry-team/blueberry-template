import 'package:blueberry_flutter_template/model/DogProfileModel.dart';
import 'package:blueberry_flutter_template/widgets/match/SwipeButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/match/DogProfileProvider.dart';
import '../../screens/match/ProfileScreen.dart';
import 'SwipeCardWidget.dart';

/// MatchProfileListWidget - 메인 위젯으로, SwipeCard, SwipeButton와 CardSwiperController을 통해 매칭 기능을 구현함

class MatchProfileListWidget extends ConsumerWidget {
  const MatchProfileListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(dogProfilesProvider);

    return list.when(
      data: (data) => _buildCardView(context, ref, data),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
    );
  }
}

Widget _buildCardView(BuildContext context, WidgetRef ref, List<DogProfileModel> data) {
  final cardSwiperController = CardSwiperController();
  final cards = data.map(SwipeCardWidget.new).toList();

  return Column(
    children: [
      Flexible(
        child: CardSwiper(
          controller: cardSwiperController,
          cardsCount: cards.length,
          onSwipe: (previousIndex, currentIndex, direction) {
            if (direction == CardSwiperDirection.right) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(dogProfile: data[previousIndex]),
                ),
              );
            }
            return true;
          },
          cardBuilder: (context, index, horizontalThresholdPercentage, verticalThresholdPercentage,) => cards[index],
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SwipeButtonWidget(onPressed: () => cardSwiperController.swipe(CardSwiperDirection.left), icon: Icons.close),
          SwipeButtonWidget(onPressed: () => cardSwiperController.swipe(CardSwiperDirection.right), icon: Icons.check),
        ],
      ),
    ],
  );
}