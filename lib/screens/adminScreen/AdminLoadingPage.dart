import 'package:flutter/material.dart';

class AdminLoadingPage extends StatelessWidget {
  static const String name = 'AdminLoadingPage';
  const AdminLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Admin Page",
          style: TextStyle(
            fontSize: 50,
          ),
        ),
      ),
    );
  }
}
