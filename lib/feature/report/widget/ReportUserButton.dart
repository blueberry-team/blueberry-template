import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReportUserButton extends StatelessWidget {
  final String reportedUserId;

  const ReportUserButton({super.key, required this.reportedUserId});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.report),
      onPressed: () => _showReportDialog(context),
    );
  }

  void _showReportDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Report User"),
          content: TextField(
            controller: controller,
            decoration:
                const InputDecoration(hintText: "Enter your report reason"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _reportUser(controller.text);
                Navigator.of(context).pop();
              },
              child: const Text("Report"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _reportUser(String reason) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      await FirebaseFirestore.instance.collection('reports').add({
        'reportedUserId': reportedUserId,
        'reporterUserId': currentUser.uid,
        'reason': reason,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
  }
}
