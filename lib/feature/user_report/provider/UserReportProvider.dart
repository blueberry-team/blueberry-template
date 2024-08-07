import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../model/UserReportModel.dart';

final reportProvider = StateNotifierProvider<ReportNotifier, List<UserReportModel>>((ref) {
  return ReportNotifier();
});

class ReportNotifier extends StateNotifier<List<UserReportModel>> {
  ReportNotifier() : super([]);

  Future<void> addReport(UserReportModel report) async {
    await FirebaseFirestore.instance.collection('reports').add(report.toJson());  //임의 컬렉션 변경 필요
    state = [...state, report];
  }
}
