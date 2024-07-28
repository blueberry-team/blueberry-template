// 게시물 화면!
//
import 'package:blueberry_flutter_template/widgets/post/PostItemWidget.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Getting'),
        actions: const [
          Icon(Icons.camera_alt_rounded),
          SizedBox(
            width: 6,
          )
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          children: <Widget>[
            PostItem(
              title: 'Sigorrjabjong',
              uploadTime: DateTime(2023, 7, 27, 14, 30),
              content: '귀여웡',
              imageUrl:
                  'https://img.freepik.com/premium-photo/cute-puppy_976589-177.jpg',
            ),
            PostItem(
              title: 'ANGRY!!!!',
              uploadTime: DateTime(2023, 7, 27, 14, 30),
              content: '나 건들지말라햇따',
              imageUrl:
                  'https://image.dongascience.com/Photo/2020/03/5bddba7b6574b95d37b6079c199d7101.jpg',
            ),
            PostItem(
              title: '타이타닉',
              uploadTime: DateTime(2023, 7, 27, 14, 30),
              content: 'I can fly~',
              imageUrl:
                  'https://mblogthumb-phinf.pstatic.net/MjAyMjAyMDdfMjEy/MDAxNjQ0MTk0Mzk2MzY3.WAeeVCu2V3vqEz_98aWMOjK2RUKI_yHYbuZxrokf-0Ug.sV3LNWlROCJTkeS14PMu2UBl5zTkwK70aKX8B1w2oKQg.JPEG.41minit/1643900851960.jpg?type=w800',
            ),
            PostItem(
              title: 'Chit~',
              uploadTime: DateTime(2023, 7, 27, 14, 30),
              content: '칫',
              imageUrl:
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRe6N9qYpuZf8ZCBTHdf5FcZBZNL4HzIiPUHg&s',
            ),
            // 다른 게시물 항목들도 추가할 수 있습니다.
          ],
        ),
      ),
    );
  }
}
