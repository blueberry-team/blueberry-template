import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../model/FriendModel.dart';
import '../../../utils/AppStrings.dart';
import '../../user_report/provider/ReportModalSheet.dart';
import 'BottomSheetButtonWidget.dart';

class FriendBottomSheet extends StatelessWidget {
  final FriendModel friend;
  final String imageUrl;

  const FriendBottomSheet(
      {super.key, required this.friend, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260, // 바텀 시트 높이 수정 부분
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
                      Text(friend.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
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
                  GoRouter.of(context)
                      .push('/userdetail'); // 현재 임의 경로 사용 중 수정 필요
                },
                text: AppStrings.profileButton,
              ),
              BottomSheetButtonWidget(
                onPressed: () {
                  Navigator.of(context).pop();
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(25.0)),
                    ),
                    builder: (context) => ReportModalSheet(friend: friend),
                  );
                },
                text: AppStrings.reportButton,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
