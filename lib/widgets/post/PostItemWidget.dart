import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostItem extends StatelessWidget {
  final String title;
  final DateTime uploadTime;
  final String content;
  final String imageUrl;

  const PostItem({
    super.key,
    required this.title,
    required this.uploadTime,
    required this.content,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 사진 제목
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 5),
            // 업로드 시간 정보
            Text(
              DateFormat('yyyy년 MM월 dd일 HH시 mm분').format(uploadTime),
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 10),
            // 강아지 사진
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0), // 사진 테두리를 둥글게 설정
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            // 본문 내용
            Text(
              content,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            // 자세히 보기 버튼
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  // 버튼 클릭시 동작할 코드 작성
                },
                child: const Text('자세히 보기'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
