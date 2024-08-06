import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../model/FriendModel.dart';


class FriendBottomSheet extends StatelessWidget {
  final FriendModel friend;
  final String imageUrl;

  const FriendBottomSheet({super.key, required this.friend, required this.imageUrl});

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 280,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
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
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 54, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  GoRouter.of(context).push('/chat');
                },
                child: const Text('채팅'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 54, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  GoRouter.of(context).push('/userdetail'); //현재 임의 경로 사용중 수정 필요
                },
                child: const Text('프로필'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}