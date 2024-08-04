import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final phoneVerificationProvider =
    NotifierProvider<PhoneVerificationNotifier, PhoneVerificationState>(() {
  return PhoneVerificationNotifier();
});

class PhoneVerificationNotifier extends Notifier<PhoneVerificationState> {
  @override
  PhoneVerificationState build() {
    return Initial();
  }

  void reset() {
    state = Initial();
  }

  Future<void> sendPhoneNumber(
      String phoneNumber, Completer<void> completer) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        timeout: const Duration(seconds: 120),
        phoneNumber: '+82 $phoneNumber',
        verificationCompleted: (PhoneAuthCredential credential) async {
          final auth = FirebaseAuth.instance;
          final authCredential = await auth.signInWithCredential(credential);

          if (authCredential.user != null) {
            auth.currentUser!.delete();
            auth.signOut();
            state = Verified();
            completer.complete();
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          state = Failed(message: e.toString());
          completer.completeError(e.toString());
        },
        codeSent: (String verificationId, int? resendToken) {
          state = CodeSent(verificationId, resendToken: resendToken);
          completer.complete();
          startCodeInputTimeout();
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          if (!completer.isCompleted) {
            state = TimeOut(verificationId: verificationId);
            completer.completeError('Timeout');
          }
        },
      );
    } catch (e) {
      state = Failed(message: e.toString());
      completer.completeError(e.toString());
    }
  }

  void startCodeInputTimeout() {
    Future.delayed(const Duration(seconds: 120), () {
      if (state is CodeSent) {
        state = TimeOut(verificationId: '');
      }
    });
  }

  Future<void> verifyCode(
      String verificationCode, Completer<void> completer) async {
    final verificationId = state.verificationId;

    if (state is CodeSent || state is Failed) {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId!,
        smsCode: verificationCode,
      );

      try {
        final auth = FirebaseAuth.instance;
        final authResult = await auth.signInWithCredential(credential);
        if (authResult.user != null) {
          auth.currentUser!.delete();
          auth.signOut();
          state = Verified();
          completer.complete();
        } else {
          state = Failed(
              message: 'invalid-credential', verificationId: verificationId);
          completer.completeError('invalid-credential');
        }
      } catch (e) {
        state = Failed(message: e.toString(), verificationId: verificationId);
        completer.completeError(e.toString());
      }
    }
  }
}

abstract class PhoneVerificationState {
  final String? verificationId;

  PhoneVerificationState({this.verificationId});
}

class Initial extends PhoneVerificationState {}

class CodeSent extends PhoneVerificationState {
  final int? resendToken;

  CodeSent(String verificationId, {this.resendToken})
      : super(verificationId: verificationId);
}

class TimeOut extends PhoneVerificationState {
  TimeOut({super.verificationId});
}

class Verified extends PhoneVerificationState {}

class Failed extends PhoneVerificationState {
  final String? message;

  Failed({this.message, super.verificationId});
}
