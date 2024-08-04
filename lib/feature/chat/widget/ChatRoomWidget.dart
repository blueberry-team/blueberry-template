import 'package:blueberry_flutter_template/feature/chat/provider/ChatListProvider.dart';
import 'package:blueberry_flutter_template/feature/chat/ChatScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ChatRoomWidget extends ConsumerWidget {
  const ChatRoomWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(chatRoomListProvider);
    return list.when(
        data: (data) => _buildRoomListView(data),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')));
  }
}

Widget _buildRoomListView(List<String> data) {
  return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key(index.toString()),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            color: const Color(0xff910c1b),
            child: const Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Icon(
                CupertinoIcons.delete_simple,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
          onDismissed: (direction) {
            data.removeAt(index);
          },
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => context.goNamed(ChatScreen.name),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start, // 이 부분을 추가
                children: [
                  _buildProfileImage(null),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(data[index],
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 15)),
                            Text(
                                DateFormat('a h:mm', 'ko_KR')
                                    .format(DateTime.now()),
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 10)),
                          ],
                        ),
                        const Text('recentMesssage',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                            overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}

Widget _buildProfileImage(String? path) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: path != null && path.isNotEmpty
        ? Image.asset(
            path,
            fit: BoxFit.cover,
            width: 45,
            height: 45,
          )
        : Container(
            width: 45,
            height: 45,
            color: Colors.grey,
          ),
  );
}
