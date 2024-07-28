import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/ProfileDetailProvider.dart';
import '../../utils/AppStringEnglish.dart';

class ProfileDetailWidget extends ConsumerWidget {
  const ProfileDetailWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photoUrlList = ref.watch(profileImageUrlsProvider);

    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: (){},
          child: Container(
            width: 300,
            height: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.black),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                photoUrlList.when(
                  data: (photoUrlList) {
                    return Center(
                      child: Image.network(photoUrlList[1], height: 300),
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (error, stackTrace) => Center(child: Text('${AppStringEnglish.errorTitle}: $error')),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Profile Photo',
                  style: TextStyle(fontSize: 24),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
