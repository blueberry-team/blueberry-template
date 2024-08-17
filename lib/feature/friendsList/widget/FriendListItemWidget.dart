import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../model/FriendModel.dart';
import '../../../utils/Formatter.dart';

class FriendListItemWidget extends StatelessWidget {
  final FriendModel friend;
  final String imageUrl;
  final VoidCallback onTap;

  const FriendListItemWidget(
      {super.key,
      required this.friend,
      required this.imageUrl,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    final lastConnect = timeAgo(friend.lastConnect);
    // 친구 모델 데이터 로깅
    print('friend list item widget: $friend');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.grey.shade300,
              width: 1.0,
            ),
          ),
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundImage: CachedNetworkImageProvider(imageUrl),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(lastConnect),
                    const SizedBox(height: 5),
                    Text(friend.name,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(friend.status),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0, left: 20.0),
                child: Row(
                  children: [
                    const Icon(Icons.favorite, color: Colors.red),
                    const SizedBox(width: 5),
                    Text(friend.likes.toString()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
