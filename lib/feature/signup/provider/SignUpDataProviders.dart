// 이메일 인증 ( 아이디 )
import 'package:flutter_riverpod/flutter_riverpod.dart';

final emailProvider = StateProvider.autoDispose<String>((ref) => '');
final emailVerificationCodeProvider = StateProvider<String>((ref) => '');

// 이름, 닉네임 생성
final nameProvider = StateProvider.autoDispose<String>((ref) => '');
final nicknameProvider = StateProvider.autoDispose<String>((ref) => '');

// 비밀번호 생성
final passwordProvider = StateProvider.autoDispose<String>((ref) => '');
final passwordConfirmProvider = StateProvider.autoDispose<String>((ref) => '');

// 휴대폰 번호 인증 ( 구매할 때 휴대폰 인증 ) ( 따로 만들기 )
final residentRegistrationNumberProvider =
    StateProvider.autoDispose<String>((ref) => '');
final phoneNumberProvider = StateProvider.autoDispose<String>((ref) => '');
final verificationNumberProvider =
    StateProvider.autoDispose<String>((ref) => '');
