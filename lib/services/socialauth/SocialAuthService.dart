import 'dart:convert';
import 'dart:math';

import 'package:blueberry_flutter_template/services/socialauth/RandomUserNickNameGenerator.dart';
import 'package:blueberry_flutter_template/utils/AppStrings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../utils/Talker.dart';

class SocialAuthService {
  get context => null;

  ///Google Sign In
  Future<void> signInWithGoogle() async {
    ///* GoogleSignIn 객체 생성
    final googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? gUser = await googleSignIn.signIn();
    if (gUser != null) {
      final GoogleSignInAuthentication gAuth = await gUser.authentication;
      final gCredential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(gCredential);
      getAuthenticateWithFirebase(userCredential, AppStrings.usingGoogleLogin);
    }
  }

  ///Apple Sign In
  Future<void> signInWithApple() async {
    try {
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);

      final appleIdCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      final credential = OAuthProvider('apple.com').credential(
        idToken: appleIdCredential.identityToken,
        accessToken: appleIdCredential.authorizationCode,
        rawNonce: rawNonce,
      );

      final result =
          await FirebaseAuth.instance.signInWithCredential(credential);
      getAuthenticateWithFirebase(result, AppStrings.usingAppleLogin);
    } on SignInWithAppleAuthorizationException catch (e) {
      // Apple 로그인 관련 오류 처리
      talker.error('Apple 로그인 오류: ${e.code}');
    } catch (e) {
      talker.error('Apple 로그인 중 오류 발생: $e');
      throw Exception('Apple 로그인 중 오류 발생: $e');
    }
  }

  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  ///Github Sign In
  Future<void> signInWithGithub() async {
    GithubAuthProvider githubAuthProvider = GithubAuthProvider();
    final userCredential =
        await FirebaseAuth.instance.signInWithProvider(githubAuthProvider);
    getAuthenticateWithFirebase(userCredential, AppStrings.usingGithubLogin);
  }

  ///* 인증정보를 바탕으로 firestore에 저장하는 함수
  void getAuthenticateWithFirebase(
      UserCredential? credential, String socialCompany) async {
    if (credential?.user == null) {
      return null;
    }
    var ref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    var snapshot = await ref.get();
    if (!snapshot.exists) {
      String randomNickname = RandomUserNickNameGenerator.generate();

      return await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'account_level': 1,
        //account_level이 0이되면 Delete timestamp확인하여 14일 뒤 삭제
        'email': FirebaseAuth.instance.currentUser!.email,
        'name': FirebaseAuth.instance.currentUser!.displayName,
        'nickName': randomNickname,
        'age': 0,
        'socialLogin': true,
        'socialCompany': socialCompany,
        'createdAt': DateTime.timestamp(),
        'profilePicture': "",
      });
    }
  }

  //=========================withdrawl==============================//
  Future<bool> appleWithDrawl() async {
    String keyID = '';
    String teamID = '';
    String pkgName = '';
    await PackageInfo.fromPlatform().then((value) {
      pkgName = value.packageName;
    });
    String privateKey =
        await rootBundle.loadString('assets/certificate/AuthKey_$keyID.p8');

    int iat = DateTime.now().toUtc().millisecondsSinceEpoch ~/
        Duration.millisecondsPerSecond;
    int exp = DateTime.now()
            .add(const Duration(seconds: 15776999)) //30일
            .toUtc()
            .millisecondsSinceEpoch ~/
        Duration.millisecondsPerSecond;

    var jwt = JWT({
      'iss': teamID,
      'iat': iat,
      'exp': exp,
      'aud': 'https://appleid.apple.com', // 기본값
      'sub': pkgName,
    }, header: {
      'alg': 'ES256', // 기본값
      'kid': keyID,
    });

    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    var clientSecret =
        jwt.sign(ECPrivateKey(privateKey), algorithm: JWTAlgorithm.ES256);

    Map<String, dynamic> body = {
      'client_id': pkgName,
      'client_secret': clientSecret,
      'token': credential.identityToken
    };
    final dio = Dio();
    Map<String, String> header = {
      'Content-Type': 'application/x-www-form-url'
          'encoded'
    };
    dio.options.headers = header;
    try {
      final res =
          await dio.post('https://appleid.apple.com/auth/revoke', data: body);
      if (res.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
