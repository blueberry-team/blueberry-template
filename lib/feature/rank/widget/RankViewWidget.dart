import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:blueberry_flutter_template/utils/AppTextStyle.dart';
import 'package:blueberry_flutter_template/model/UserModel.dart';
import 'package:blueberry_flutter_template/feature/rank/provider/UserRankProvider.dart';
import 'package:blueberry_flutter_template/utils/AppStrings.dart';

class RankViewWidget extends ConsumerWidget {
  const RankViewWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userRankings = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.rankViewTitle),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(userProvider); // 강제로 프로바이더를 무효화하여 데이터 불러옴
          // ignore: unused_result
          await ref.refresh(userProvider.future);
        },
        child: buildBody(userRankings),
      ),
    );
  }

  Widget buildBody(AsyncValue<List<UserModel>> userRankings) {
    return userRankings.when(
      data: (users) => buildUserList(users),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }

  Widget buildUserList(List<UserModel> users) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final user = users[index];
              return userRankingList(
                rank: index + 1,
                userName: user.name,
              );
            },
            childCount: users.length,
          ),
        ),
      ],
    );
  }

  Widget userRankingList({
    required int rank,
    required String userName,
  }) {
    return ListTile(
      leading: Text(
        '$rank',
        style: black16TextStyle,
      ),
      title: Text(
        userName,
        style: black16TextStyle,
      ),
    );
  }
}
