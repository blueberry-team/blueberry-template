import 'package:blueberry_flutter_template/model/PostModel.dart';
import 'package:blueberry_flutter_template/model/PostUserInfoModel.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class PostListViewItemWidget extends StatelessWidget {
  final PostModel post;
  final bool isLiked;
  final bool isDisliked;
  final PostUserInfoModel userInfo;
  final VoidCallback onLikeToggle;
  final VoidCallback onDislikeToggle;

  const PostListViewItemWidget({
    super.key,
    required this.post,
    required this.isLiked,
    required this.isDisliked,
    required this.userInfo,
    required this.onLikeToggle,
    required this.onDislikeToggle,
  });

  @override
  Widget build(BuildContext context) {
    // DateTime을 String으로 변환
    String formattedDate = DateFormat.yMMMd().format(post.createdAt);

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
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(userInfo.profileImageUrl),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    userInfo.name,
                    style: const TextStyle(
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
                    post.imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(formattedDate),
              const SizedBox(height: 10),
              Text(post.content),
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
                        onPressed: onLikeToggle,
                      ),
                      const SizedBox(width: 5),
                      Text('${post.likesCount}'),
                      const SizedBox(width: 20),
                      IconButton(
                        icon: Icon(
                          isDisliked ? Icons.thumb_down : Icons.thumb_down_alt_outlined,
                          color: isDisliked ? Colors.blue : Colors.grey,
                        ),
                        onPressed: onDislikeToggle,
                      ),
                      const SizedBox(width: 5),
                      Text('${post.dislikesCount}'),
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
