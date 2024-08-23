import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../model/FriendModel.dart';
import '../provider/FriendsListProvider.dart';
import 'BottomSheetButtonWidget.dart';
import 'PopupMenuItem.dart'; // PopupMenuItem.dart import

class FriendBottomSheetWidget extends StatelessWidget {
  final FriendModel friend;
  final String imageUrl;

  const FriendBottomSheetWidget({super.key, required this.friend, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
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
                      Text(friend.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                      const SizedBox(height: 8),
                      Text(friend.status, style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
                Consumer(
                  builder: (context, ref, child) {
                    return PopupMenuButton<int>(
                      onSelected: (value) => handleMenuSelection(context, ref, value, friend),
                      itemBuilder: (context) => [
                        buildPopupMenuItem(icon: Icons.report, text: "신고하기", value: 1),
                        buildPopupMenuItem(icon: Icons.delete, text: "삭제하기", value: 2),
                        buildPopupMenuItem(icon: Icons.block, text: "차단하기", value: 3),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BottomSheetButtonWidget(
                onPressed: () {
                  Navigator.of(context).pop();
                  GoRouter.of(context).push('/chat');
                },
                text: '채팅',
              ),
              BottomSheetButtonWidget(
                onPressed: () {
                  Navigator.of(context).pop();
                  GoRouter.of(context).push('/userdetail');
                },
                text: '프로필',
              ),
              BottomSheetButtonWidget(
                onPressed: () {
                  Navigator.of(context).pop();
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
                    ),
                    builder: (context) => const Text('신고하기 위젯 표시'),
                  );
                },
                text: '신고하기',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
