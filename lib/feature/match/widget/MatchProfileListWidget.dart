import 'package:blueberry_flutter_template/model/PetProfileModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/AppStrings.dart';
import '../ProfileScreen.dart';
import '../provider/MatchProvider.dart';
import 'SwipeButtonWidget.dart';
import 'SwipeCardWidget.dart';

class MatchProfileListWidget extends ConsumerWidget {
  const MatchProfileListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listState = ref.watch(matchScreenProvider);
    final isLoading = ref.watch(matchScreenProvider.notifier).isLoading;

    if (isLoading) {
      return _buildLoadingView(); // 로딩 중일 때 Shimmer UI를 표시
    } else if (listState.isEmpty) {
      return const Center(child: Text(AppStrings.noPetsMessage)); // 데이터가 비었을 때 표시
    } else {
      return _buildCardView(context, ref, listState); // 데이터가 있을 때 카드 뷰 표시
    }
  }

  Widget _buildLoadingView() {
    return ListView.builder(
      itemCount: 1, // 표시할 카드 수
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 470,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCardView(
      BuildContext context, WidgetRef ref, List<PetProfileModel> data) {
    final cardSwiperController = CardSwiperController();
    int currentIndex = 0;
    final cards = data.map((petProfile) {
      return GestureDetector(
        onTap: () {
          cardSwiperController.swipe(CardSwiperDirection.right);
        },
        child: SwipeCardWidget(petProfile),
      );
    }).toList();

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
                      .addPetToSuperLikes(context, userId, petId);
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
                      .addPetToLikes(context, userId, petId);
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
