import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../model/FriendModel.dart';
import '../provider/FriendsListProvider.dart';
import 'BottomSheetButtonWidget.dart';

class FriendBottomSheetLauncher {
  static void show({
    required BuildContext context,
    required FriendModel friend,
    required String imageUrl,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) => FriendBottomSheetWidget(
        friend: friend,
        imageUrl: imageUrl,
      ),
    );
  }
}

class FriendBottomSheetWidget extends ConsumerWidget {
  final FriendModel friend;
  final String imageUrl;

  const FriendBottomSheetWidget({super.key, required this.friend, required this.imageUrl});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () => _showSettingsMenu(context, ref),
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

  void _showSettingsMenu(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) => _SettingsMenu(friend: friend, ref: ref),
    );
  }
}

class _SettingsMenu extends StatelessWidget {
  final FriendModel friend;
  final WidgetRef ref;

  const _SettingsMenu({required this.friend, required this.ref});

  @override
  Widget build(BuildContext context) {
    final deleteFriend = ref.read(deleteFriendProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: const Icon(Icons.report),
          title: const Text('신고하기'),
          onTap: () {
            Navigator.of(context).pop();
            // 신고하기 처리 로직
          },
        ),
        ListTile(
          leading: const Icon(Icons.delete),
          title: const Text('삭제하기'),
          onTap: () async {
            Navigator.of(context).pop();
            await deleteFriend(context, friend);
          },
        ),
        ListTile(
          leading: const Icon(Icons.block),
          title: const Text('차단하기'),
          onTap: () {
            Navigator.of(context).pop();
            // 차단하기 처리 로직
          },
        ),
      ],
    );
  }
}