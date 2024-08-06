import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/AppStringEnglish.dart';
import '../provider/UserSelectProfileProvider.dart';

class UserSelectProfileWidget extends ConsumerWidget {
  const UserSelectProfileWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userSelectProfiles = ref.watch(userSelectProfileProvider);
    final userSelectProfileIndex = ref.watch(userSelectProfileIndexProvider);
    final userSelectProfileNotifier = ref.watch(userSelectProfileIndexProvider.notifier);

    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: (){
            userSelectProfileNotifier.updateUserSelectProfile(userSelectProfiles.maybeWhen(
              data: (userSelectProfiles) => userSelectProfiles.length,
              orElse: () => 0,
            ));
          },
          child: userSelectProfiles.when(
            data: (profileImages) {
              return Center(
                child: Container(
                    width: 300,
                    height: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black),
                    ),
                    child: userSelectProfileIndex == -1
                        ? const Text('해당 유저의 프로필 사진이 존재하지 않습니다')
                        : profileImages[userSelectProfileIndex]
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(child: Text('${AppStringEnglish.errorTitle}: $error')),
          ),
        ),
      ),
    );
  }
}
