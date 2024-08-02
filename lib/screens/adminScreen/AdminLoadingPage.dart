import 'package:flutter/material.dart';

class AdminLoadingScreen extends StatelessWidget {
  const AdminLoadingScreen({super.key});

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
