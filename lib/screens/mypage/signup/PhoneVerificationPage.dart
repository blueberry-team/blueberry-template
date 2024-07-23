import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../widgets/signup/PhoneNumberInputWidget.dart';
import '../../../widgets/signup/VerificationCodeInputWidget.dart';

// A 스크린 ( 휴대폰 입력 )
class PhoneNumberInputPage extends StatefulWidget {
  final VoidCallback onNext;

  const PhoneNumberInputPage({
    super.key,
    required this.onNext,
  });

  @override
  _PhoneNumberInputPageState createState() => _PhoneNumberInputPageState();
}

class _PhoneNumberInputPageState extends State<PhoneNumberInputPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: PhoneNumberInputWidget(onNext: widget.onNext),
    );
  }
}

// B 스크린 ( 휴대폰 인증번호 입력 )
class VerificationCodeInputPage extends StatefulWidget {
  final VoidCallback onNext;

  const VerificationCodeInputPage({
    super.key,
    required this.onNext,
  });

  @override
  _VerificationCodeInputPageState createState() =>
      _VerificationCodeInputPageState();
}

class _VerificationCodeInputPageState extends State<VerificationCodeInputPage> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: VerificationCodeInputWidget(
        focusNode: _focusNode,
        onNext: widget.onNext,
      ),
    );
  }
}

// C 스크린 ( 휴대폰  인증 완료 후 보여줄 화면 )
class PhoneVerificationDonePage extends StatelessWidget {
  final VoidCallback onNext;

  const PhoneVerificationDonePage({
    super.key,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('휴대폰 인증 완료'),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () => onNext(),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }
}
