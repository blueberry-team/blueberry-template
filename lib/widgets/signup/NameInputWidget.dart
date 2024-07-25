import 'package:blueberry_flutter_template/providers/SignUpDataProviders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class NameInputWidget extends ConsumerWidget {

  const NameInputWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(nameProvider.notifier);
    final formKey = GlobalKey<FormState>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              onChanged: (value) => name.state = value,
              decoration: const InputDecoration(labelText: '이름 입력'),
              // 특문 막는 정규식 써야함
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}