import 'package:flutter/material.dart';

import '../../../model/FriendModel.dart';

class FriendListItemWidget extends StatelessWidget {
  final FriendModel friend;

  const FriendListItemWidget({super.key, required this.friend});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1.0,
          ),
        ),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: friend.imageUrl.isNotEmpty
                    ? NetworkImage(friend.imageUrl)
                    : null, //대체 이미지 추가 필요
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(friend.lastConnect.toString()),
                  const SizedBox(height: 5),
                  Text(friend.name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(friend.status),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, left: 16.0),
              // left padding added
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
    );
  }
}
