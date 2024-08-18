import 'package:blueberry_flutter_template/utils/Talker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/PostModel.dart';

class PostingScreen extends StatefulWidget {
  static const name = 'CreatePostPage';

  const PostingScreen({super.key});

  @override
  _PostingScreenState createState() => _PostingScreenState();
}

class _PostingScreenState extends State<PostingScreen> {
  final _formKey = GlobalKey<FormState>();
  String? title;
  String? content;
  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('포스트 생성'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: '제목'),
                onSaved: (value) => title = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '제목을 입력해주세요';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: '내용'),
                onSaved: (value) => content = value,
                validator: (value) {
                  if (value == null) {
                    return '내용을 입력해주세요';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: '이미지 URL'),
                onSaved: (value) => imageUrl = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '이미지 URL을 입력해주세요';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState?.save();
                      final String uploadTime =
                          DateFormat('yyyy-MM-dd HH:mm:ss')
                              .format(DateTime.now());
                      final post = PostModel(
                        title: title!,
                        content: content!,
                        imageUrl: imageUrl!,
                        uploadTime: uploadTime,
                      );
                      // 포스트 생성 후 처리
                      talker.info('포스트 생성: ${post.toJson()}');
                    }
                  },
                  child: const Text('포스트 생성'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
