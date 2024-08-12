import 'package:flutter/material.dart';

class PostListViewItemWidget extends StatefulWidget {
  final String title;
  final String uploadTime;
  final String content;
  final String imageUrl;

  const PostListViewItemWidget({
    super.key,
    required this.title,
    required this.uploadTime,
    required this.content,
    required this.imageUrl,
  });

  @override
  _PostListViewItemWidgetState createState() => _PostListViewItemWidgetState();
}

// 카드 스타일을 위한 변수
final cardDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(15.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      spreadRadius: 3,
      blurRadius: 5,
      offset: const Offset(0, 3), // 그림자 위치
    ),
  ],
);

class _PostListViewItemWidgetState extends State<PostListViewItemWidget> {
  bool isLiked = false; // 좋아요 상태를 저장하는 변수
  bool showComment = false; // 댓글 표시 여부를 저장하는 변수

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: cardDecoration,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: [
                // 이미지
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(
                    widget.imageUrl,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                // 제목과 날짜를 이미지 위에 오버레이
                Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              offset: Offset(0, 1),
                              blurRadius: 3.0,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.uploadTime,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          shadows: [
                            Shadow(
                              offset: Offset(0, 1),
                              blurRadius: 3.0,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // 본문 내용
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                widget.content,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 좋아요 버튼
                  IconButton(
                    icon: Icon(
                      isLiked ? Icons.thumb_up : Icons.thumb_up_off_alt,
                      color: isLiked ? Colors.blue : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        isLiked = !isLiked; // 좋아요 상태 토글
                      });
                    },
                  ),
                  // 댓글 달기 버튼
                  IconButton(
                      onPressed: () => setState(() {
                            showComment = !showComment; // 댓글 표시 여부 토글
                          }),
                      icon: const Icon(Icons.comment))
                ],
              ),
            ),
            // 임시 댓글 표시
            if (showComment)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(), // 구분선 추가
                    Text(
                      '정우님 항상 감사합니다',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
