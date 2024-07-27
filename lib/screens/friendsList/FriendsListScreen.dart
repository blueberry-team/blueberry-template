import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../model/FriendsModel.dart';
import '../../providers/FriendsListProvider.dart';


class FriendsListScreen extends ConsumerWidget {
  const FriendsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final friendsAsyncValue = ref.watch(friendsListProvider);

    return Scaffold(
      body: friendsAsyncValue.when(
        data: (friends) {
          return ListView.builder(
            itemCount: friends.length,
            itemBuilder: (context, index) {
              return FriendTile(friend: friends[index]);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

class FriendTile extends StatelessWidget {
  final FriendsModel friend;

  const FriendTile({super.key, required this.friend});

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
                backgroundImage: friend.profilePicture.startsWith('http')
                    ? NetworkImage(friend.profilePicture)
                    : AssetImage(friend.profilePicture) as ImageProvider,
                onBackgroundImageError: (_, __) {
                  // 기본 이미지로 설정
                },
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(friend.createdAt.toString()),
                  const SizedBox(height: 5),
                  Text(friend.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(friend.status ?? ''),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0, left: 16.0), // left padding added
              child: Row(
                children: [
                  Icon(Icons.favorite, color: Colors.red),
                  SizedBox(width: 5),
                  Text('17'), // 임시 데이터
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
