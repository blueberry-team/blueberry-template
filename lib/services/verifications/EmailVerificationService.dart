import 'dart:ui';

import 'package:blueberry_flutter_template/utils/Talker.dart';
import 'package:cloud_functions/cloud_functions.dart';

class EmailVerificationService {
  Future<void> sendVerificationEmail(String email) async {
    try {
      final callable = FirebaseFunctions.instance
          .httpsCallable('emailVerification-sendVerificationEmail');
      final result = await callable.call({'email': email});
      talker.log('이메일 전송 결과: $result');
      talker.log('Result data: ${result.data}');

      if (result.data != null && result.data is Map) {
        if (result.data['success'] == true) {
          talker.log('이메일이 성공적으로 전송되었습니다: ${result.data['message']}');
        } else {
          talker.error('이메일 전송 실패: ${result.data['message']}');
        }
      } else {
        talker.error('예상치 못한 응답 구조');
      }
    } on FirebaseFunctionsException catch (e) {
      talker.error(
          'Firebase Functions Exception: ${e.code} - ${e.message}, ${e.details}');
      rethrow;
    } catch (e) {
      talker.error('Unexpected error: $e');
      rethrow;
    }
  }

  Future<void> verifyCode(
      String email, String code, VoidCallback onNext) async {
    try {
      final HttpsCallable callable = FirebaseFunctions.instance
          .httpsCallable('emailVerification-verifyCode');
      final result = await callable.call({'email': email, 'code': code});
      if (result.data['success']) {
        talker.log("이메일이 성공적으로 인증되었습니다.");
        onNext();
        // 인증 성공 처리 (예: 다음 화면으로 이동)
      } else {
        talker.log('인증 실패: ${result.data['message']}');
        // 인증 실패 메시지 표시
      }
    } on FirebaseFunctionsException catch (e) {
      talker.error('Firebase Functions Exception: ${e.code} - ${e.message}');
      // 에러 메시지 표시
    }
  }
}
