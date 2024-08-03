import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

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
      getAuthenticateWithFirebase(userCredential);
    }
  }

  ///Apple Sign In
  signInWithApple() async {
    final appleIdCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    final oAuthProvider = OAuthProvider('apple.com');
    final credential = oAuthProvider.credential(
      idToken: appleIdCredential.identityToken,
      accessToken: appleIdCredential.authorizationCode,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    var ref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    var snapshot = await ref.get();
    if (!snapshot.exists) {
      return await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'account_level': 1,
        //account_level이 0이되면 Delete timestamp확인하여 14일 뒤 삭제
        'email': FirebaseAuth.instance.currentUser!.email,
        'name': FirebaseAuth.instance.currentUser!.displayName,
        'age': 0,
        'isMemberShip': false,
        'createdAt': DateTime.timestamp(),
        'profilePicture': "",
      });
    }
  }

  ///Github Sign In
  Future<void> signInWithGithub() async {
    GithubAuthProvider githubAuthProvider = GithubAuthProvider();
    final userCredential =
        await FirebaseAuth.instance.signInWithProvider(githubAuthProvider);

    getAuthenticateWithFirebase(userCredential);
  }

  ///* 인증정보를 바탕으로 firestore에 저장하는 함수
  void getAuthenticateWithFirebase(UserCredential? credential) async {
    if (credential?.user == null) {
      return null;
    }
    var ref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    var snapshot = await ref.get();
    if (!snapshot.exists) {
      return await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'account_level': 1,
        //account_level이 0이되면 Delete timestamp확인하여 14일 뒤 삭제
        'email': FirebaseAuth.instance.currentUser!.email,
        'name': FirebaseAuth.instance.currentUser!.displayName,
        'age': 0,
        'isMemberShip': false,
        'createdAt': DateTime.timestamp(),
        'profilePicture': "",
      });
    }
  }
}
