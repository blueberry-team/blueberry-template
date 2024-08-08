import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../model/UserReportModel.dart';

// 사용자 신고 목록을 제공하는 StateNotifierProvider
final userReportProvider =
    StateNotifierProvider<UserReportNotifier, List<UserReportModel>>((ref) {
  return UserReportNotifier();
});

class UserReportNotifier extends StateNotifier<List<UserReportModel>> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserReportNotifier() : super([]);

  Future<void> addReport(UserReportModel report) async {
    await _firestore.collection('userReports').add(report.toJson());
    state = [...state, report];
  }
}
