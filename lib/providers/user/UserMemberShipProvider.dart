import 'package:blueberry_flutter_template/services/FirebaseService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userMemberShipProvider = StateNotifierProvider<UserMembershipNotifier, UserMemberShipState>(
      (ref) => UserMembershipNotifier(),
);



class UserMembershipNotifier extends StateNotifier<UserMemberShipState> {
  UserMembershipNotifier() : super(UserMemberShipState());


  Future<void> loadMembershipStatus() async {
    if (state.isLoaded) return; // 이미 로드되었다면 다시 로드하지 않습니다.

    try {
      var user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        var doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        if (doc.exists) {
          final isMembership = doc.data()!['isMembership'] as bool;
          state = state.copyWith(isMembership: isMembership, isLoaded: true);
        }
      }
    } catch(e) {
      print('Error checking user membership: $e');
      // 에러 처리를 여기에 추가할 수 있습니다.
    }
  }
  void updateMembership(bool isMembership) {
    state = state.copyWith(isMembership: isMembership);
  }
}

class UserMemberShipState {
  final bool isMembership;
  final bool isLoaded;

  UserMemberShipState({this.isMembership = false, this.isLoaded = false});

  UserMemberShipState copyWith({bool? isMembership, bool? isLoaded}) {
    return UserMemberShipState(
      isMembership: isMembership ?? this.isMembership,
      isLoaded: isLoaded ?? this.isLoaded,
    );
  }
}