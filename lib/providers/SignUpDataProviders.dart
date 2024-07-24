// 이메일 인증 ( 아이디 )
import 'package:flutter_riverpod/flutter_riverpod.dart';

final emailProvider = StateProvider<String>((ref) => '');
final emailVerificationCodeProvider = StateProvider<String>((ref) => '');

// 이름, 닉네임 생성
final nameProvider = StateProvider<String>((ref) => '');
final nicknameProvider = StateProvider<String>((ref) => '');

// 비밀번호 생성
final passwordProvider = StateProvider<String>((ref) => '');
final passwordConfirmProvider = StateProvider<String>((ref) => '');

// 휴대폰 번호 인증 ( 구매할 때 휴대폰 인증 ) ( 따로 만들기 )
final residentRegistrationNumberProvider = StateProvider<String>((ref) => '');
final phoneNumberProvider = StateProvider<String>((ref) => '');
final verificationNumberProvider = StateProvider<String>((ref) => '');