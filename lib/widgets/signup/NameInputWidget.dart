import 'package:blueberry_flutter_template/providers/SignUpDataProviders.dart';
import 'package:blueberry_flutter_template/utils/AppStrings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class NameInputWidget extends ConsumerWidget {

  const NameInputWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(nameProvider.notifier);
    final formKey = GlobalKey<FormState>();
    final RegExp nameRegExp = RegExp(r'^[가-힣]{4,}$');

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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppStrings.errorMessage_emptyName;
                } else if (!nameRegExp.hasMatch(value)) {
                  return AppStrings.errorMessage_worngName;
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}