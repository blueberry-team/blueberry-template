import 'package:blueberry_flutter_template/services/FirebaseService.dart';
import 'package:blueberry_flutter_template/services/FirebaseStoreServiceProvider.dart';
import 'package:blueberry_flutter_template/utils/Talker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// FirebaseAuthServiceProvider.dart
///
/// Firebase Auth Service Provider
/// - FirebaseAuthService를 제공하는 Provider
/// - FirebaseAuthService: Firebase Auth 인증 서비스
/// - user: 사용자 상태 스트림
/// - signUpWithEmailPassword(): 이메일/비밀번호 회원가입
/// - signInWithEmailPassword(): 이메일/비밀번호 로그인
/// - signOut(): 로그아웃
/// - getCurrentUser(): 현재 로그인한 사용자 가져오기
/// - sendPasswordResetEmail(): 비밀번호 재설정 이메일 보내기
///
///  @jwson-automation

final firebaseAuthServiceProvider = Provider<FirebaseAuthService>((ref) {
  return FirebaseAuthService(FirebaseAuth.instance);
});

class FirebaseAuthService {
  final FirebaseAuth _auth;

  FirebaseAuthService(this._auth);

  // 사용자 상태 스트림
  Stream<User?> get user => _auth.authStateChanges();

  // 회원가입
  Future<User?> signUpWithEmailPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      throw Exception('회원가입 실패: $e');
    }
  }



  Future<User?> signInWithEmailPassword(BuildContext context, String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      if (user != null) {
        bool hasDeletionRequest = await FirebaseService().checkDeletionRequest(user.uid);
        if (hasDeletionRequest) {
          talker.log("계정 삭제 진행중 입니다.");
          if (context.mounted) {
            context.goNamed('/RestoreDeletedUserScreen');
          }
          throw Exception('계정 삭제가 진행 중입니다. 고객 센터에 문의하세요.');
        }
      }

      return user;
    } catch (e) {
      throw Exception('로그인 실패: $e');
    }
  }

  // 로그아웃
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception('로그아웃 실패: $e');
    }
  }

  // 현재 로그인한 사용자 가져오기
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // 비밀번호 재설정 이메일 보내기
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception('비밀번호 재설정 이메일 전송 실패: $e');
    }
  }
}
