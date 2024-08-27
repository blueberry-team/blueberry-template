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

class _PostListViewItemWidgetState extends State<PostListViewItemWidget> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 3,
        color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      'https://via.placeholder.com/150', // 프로필 이미지 URL
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Jennifer_Cole', // 사용자 이름
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.more_horiz),
                    onPressed: () {
                      // 추가 옵션 클릭 시 동작
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: AspectRatio(
                  aspectRatio: 1.0, // 이미지 1:1 비율 설정
                  child: Image.network(
                    widget.imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: isLiked ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            isLiked = !isLiked;
                          });
                        },
                      ),
                      const SizedBox(width: 5),
                      const Text('1,242'),
                      const SizedBox(width: 20),
                      const Icon(Icons.chat_bubble_outline),
                      const SizedBox(width: 5),
                      const Text('24'),
                    ],
                  ),
                  const Icon(Icons.bookmark_border),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
