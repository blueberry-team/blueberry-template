import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../model/FriendModel.dart';
import '../provider/FriendsListProvider.dart';
import 'BottomSheetButtonWidget.dart';
import 'PopupMenuItem.dart';
import '../../../utils/AppStrings.dart';

class FriendBottomSheetWidget extends StatelessWidget {
  final FriendModel friend;
  final String imageUrl;

  const FriendBottomSheetWidget(
      {super.key, required this.friend, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(25.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(friend.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                          const SizedBox(height: 8),
                          Text(friend.status,
                              style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                    Consumer(
                      builder: (context, ref, child) {
                        return PopupMenuButton<int>(
                          onSelected: (value) =>
                              handleMenuSelection(context, ref, value, friend),
                          itemBuilder: (context) => [
                            buildPopupMenuItem(
                                icon: Icons.delete,
                                text: AppStrings.deleteButton,
                                value: 1),
                            buildPopupMenuItem(
                                icon: Icons.block,
                                text: AppStrings.blockButton,
                                value: 2),
                            buildPopupMenuItem(
                                icon: Icons.report,
                                text: AppStrings.reportButton,
                                value: 3),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BottomSheetButtonWidget(
                    onPressed: () {
                      Navigator.of(context).pop();
                      GoRouter.of(context).push('/chat');
                    },
                    text: AppStrings.chatButton,
                  ),
                  BottomSheetButtonWidget(
                    onPressed: () {
                      Navigator.of(context).pop();
                      GoRouter.of(context).push('/userdetail');
                    },
                    text: AppStrings.profileButton,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
