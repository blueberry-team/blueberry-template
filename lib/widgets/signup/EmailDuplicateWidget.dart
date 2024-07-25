import 'package:blueberry_flutter_template/providers/SignUpDataProviders.dart';
import 'package:blueberry_flutter_template/providers/user/SignUpEmailDuplicationProvider.dart';
import 'package:blueberry_flutter_template/screens/mypage/SignUpScreen.dart';
import 'package:blueberry_flutter_template/utils/AppStrings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class EmailDuplicateWidget extends ConsumerStatefulWidget {
  final VoidCallback onNext;

  const EmailDuplicateWidget({super.key, required this.onNext});

  @override
  _EmailDuplicateWidgetState createState() => _EmailDuplicateWidgetState();
}

class _EmailDuplicateWidgetState extends ConsumerState<EmailDuplicateWidget> {
  final TextEditingController _emailController = TextEditingController();
  bool isEmailAvailable = false;

  @override
  Widget build(BuildContext context) {
    final email = ref.read(emailProvider.notifier);
    final emailDuplicate = ref.watch(emailDuplicateProvider.notifier);
    final formKey = GlobalKey<FormState>();
    final RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              onChanged: (value) => email.state = value,
              decoration: const InputDecoration(labelText: AppStrings.emailInputLabel),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppStrings.errorMessage_emptyEmail;
                } else if (!emailRegExp.hasMatch(value)) {
                  return AppStrings.errorMessage_invalidEmail;
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            _duplicationBtn(emailDuplicate, context, formKey),

            const SizedBox(height: 20),

            _nextBtn(formKey, context)
          ],
        ),
      ),
    );
  }

  ElevatedButton _duplicationBtn(EmailDuplicateNotifier emailDuplicate, BuildContext context, GlobalKey<FormState> formKey) {
    return ElevatedButton(
      onPressed: () async {
        if (formKey.currentState?.validate() ?? false) {
          String email = _emailController.text;
          bool isDuplicate = await emailDuplicate.isDuplication(email);
          if (isDuplicate) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text(AppStrings.errorMessage_emailAlreadyInUse)),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text(AppStrings.successMessage_emailValidation)),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(AppStrings.errorMessage_checkEmail)),
          );
        }
      },
      child: const Text('중복 확인'),
    );
  }

  ElevatedButton _nextBtn(GlobalKey<FormState> formKey, BuildContext context) {
    return ElevatedButton(onPressed: (){
      if (formKey.currentState?.validate() ?? false) {
        widget.onNext();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(AppStrings.errorMessage_checkEmail)),
        );
      }
    }, child: const Text('NEXT'));
  }
}



