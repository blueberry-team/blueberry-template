import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String formatWonNumber(int number) {
  final formatter = NumberFormat('#,###', 'en_US');
  return formatter.format(number);
}

///마지막 접속 시간을 일, 시, 분 별로 포멧팅해서 제공 해주는 함수입니다.
///
///마지막 접속 시간 = 현재 시간 - 유저의 최종 접속 시간
String timeAgo(DateTime dateTime) {
  final duration = DateTime.now().difference(dateTime);
  if (duration.inDays > 1) {
    return '${duration.inDays} days ago';
  } else if (duration.inHours > 1) {
    return '${duration.inHours} hours ago';
  } else if (duration.inMinutes > 1) {
    return '${duration.inMinutes} minutes ago';
  } else {
    return 'Just now';
  }
}

String formatTimestamp(Timestamp timestamp) {
  final DateTime dateTime = timestamp.toDate();
  return DateFormat('yyyy년 MM시 dd일').format(dateTime);
}
