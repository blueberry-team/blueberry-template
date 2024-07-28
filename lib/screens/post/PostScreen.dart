// 게시물 화면!
//
import 'package:blueberry_flutter_template/widgets/post/postWidget.dart';
import 'package:flutter/material.dart';
import 'package:blueberry_flutter_template/utils/AppStrings.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white70,
        appBar: AppBar(
          centerTitle: false,
          title: const Text(AppStrings.appbar_Text_Logo),
          actions: const [
            Icon(Icons.camera_alt_rounded),
            SizedBox(
              width: 6,
            )
          ],
        ),
        body: const Postwidget());
  }
}
