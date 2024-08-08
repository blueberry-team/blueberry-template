import 'dart:ui';

import 'package:cloud_functions/cloud_functions.dart';

class EmailVerificationService {
  Future<void> sendVerificationEmail(String email) async {
    try {
      final callable = FirebaseFunctions.instance
          .httpsCallable('emailVerification-sendVerificationEmail');
      final result = await callable.call({'email': email});
      print('Raw result: $result');
      print('Result data: ${result.data}');

      if (result.data != null && result.data is Map) {
        if (result.data['success'] == true) {
          print('이메일이 성공적으로 전송되었습니다: ${result.data['message']}');
        } else {
          throw Exception(result.data['message'] ?? '이메일 전송 실패');
        }
      } else {
        throw Exception('예상치 못한 응답 구조');
      }
    } on FirebaseFunctionsException catch (e) {
      print('Firebase Functions Exception:');
      print('Code: ${e.code}');
      print('Message: ${e.message}');
      print('Details: ${e.details}');
      rethrow;
    } catch (e) {
      print('Unexpected error: $e');
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
        print('이메일이 성공적으로 인증되었습니다.');
        onNext();
        // 인증 성공 처리 (예: 다음 화면으로 이동)
      } else {
        print('인증 실패: ${result.data['message']}');
        // 인증 실패 메시지 표시
      }
    } on FirebaseFunctionsException catch (e) {
      print('Error: ${e.code} - ${e.message}');
      // 에러 메시지 표시
    }
  }
}
