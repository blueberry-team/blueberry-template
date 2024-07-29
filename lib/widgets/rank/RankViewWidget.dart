import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:blueberry_flutter_template/model/UserModel.dart';
import 'package:blueberry_flutter_template/providers/rank/UserRankProvider.dart';
import 'package:blueberry_flutter_template/utils/AppStrings.dart';
import 'package:blueberry_flutter_template/widgets/rank/UserRankingTile.dart';

class RankViewWidget extends ConsumerWidget {
  const RankViewWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsyncValue = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.rankViewTitle),
      ),
      body: _buildBody(userAsyncValue),
    );
  }

  Widget _buildBody(AsyncValue<List<UserModel>> userAsyncValue) {
    return userAsyncValue.when(
      data: (users) => _buildUserList(users),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }

  Widget _buildUserList(List<UserModel> users) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final user = users[index];
              return UserRankingTile(
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
}
