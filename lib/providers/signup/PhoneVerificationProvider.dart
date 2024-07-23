import 'package:flutter_riverpod/flutter_riverpod.dart';

final phoneVerificationProvider =
    NotifierProvider<PhoneVerificationNotifier, PhoneVerificationState>(() {
  return PhoneVerificationNotifier();
});

class PhoneVerificationNotifier extends Notifier<PhoneVerificationState> {
  @override
  PhoneVerificationState build() {
    return _initializeState();
  }

  void initialize() {
    state = _initializeState();
  }

  PhoneVerificationState _initializeState() {
    return VerificationInitialized();
  }

  Future<bool> sendVerificationRequest(String phoneNumber) async {
    try {
      final verificationId = await requestVerificationId(phoneNumber);
      state = VerificationCodeSent(verificationId);
      return true;
    } catch (e) {
      state = VerificationError(e.toString());
      return false;
    }
  }

  Future<bool> checkVerificationCode(String code) async {
    if (state is VerificationCodeSent) {
      final verificationId = (state as VerificationCodeSent).verificationId;
      try {
        await validateVerificationCode(verificationId, code);
        state = VerificationSuccess();
        return true;
      } catch (e) {
        print(e);
        return false;
      }
    } else {
      return false;
    }
  }
}

abstract class PhoneVerificationState {}

class VerificationInitialized extends PhoneVerificationState {}

class VerificationCodeSent extends PhoneVerificationState {
  final String verificationId;

  VerificationCodeSent(this.verificationId);
}

class VerificationSuccess extends PhoneVerificationState {}

class VerificationError extends PhoneVerificationState {
  final String message;

  VerificationError(this.message);
}

// 휴대폰번호 전송 로직 (구현 필요)
Future<String> requestVerificationId(String phoneNumber) async {

  if (phoneNumber.length == 11) {
    return 'verificationId';
  }

  throw Exception("Invalid phone number");
}

// 인증번호 전송 로직 (구현 필요)
Future<bool> validateVerificationCode(
    String verificationId, String code) async {
  if (verificationId == 'verificationId' && code == "123456") {
    return true;
  }

  throw Exception("Invalid verification code");
}
