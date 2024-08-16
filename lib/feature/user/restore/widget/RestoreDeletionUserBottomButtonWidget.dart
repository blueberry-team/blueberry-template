import 'package:blueberry_flutter_template/services/FirebaseAuthServiceProvider.dart';
import 'package:blueberry_flutter_template/services/FirebaseService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestoreDeletionUserBottomButtonWidget extends ConsumerWidget {
  const RestoreDeletionUserBottomButtonWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: RestoreBtn(),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: cancelBtn(ref),
          ),
        ],
      ),
    );
  }

  ElevatedButton cancelBtn(WidgetRef ref) {
    return ElevatedButton(
      onPressed: () async {
        ref.read(firebaseAuthServiceProvider).signOut();
      },
      child: const Text('나가기'),
    );
  }

  ElevatedButton RestoreBtn() {
    return ElevatedButton(
      onPressed: () async {
        await FirebaseService().cancelAccountDeletion();
      },
      child: const Text('복원 하기'),
    );
  }
}
