import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../widgets/signup/PhoneNumberInputWidget.dart';
import '../../../widgets/signup/VerificationCodeInputWidget.dart';

class PhoneNumberInputPage extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onDone;


  const PhoneNumberInputPage({
    super.key,
    required this.onNext,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: PhoneNumberInputWidget(onNext: onNext, onDone: onDone),
    );
  }
}

class VerificationCodeInputPage extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onPrev;

  const VerificationCodeInputPage({
    super.key,
    required this.onNext,
    required this.onPrev,
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
        onPrev: widget.onPrev,
      ),
    );
  }
}

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
          const Text('인증 완료'),
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
