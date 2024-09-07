import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'ImageImporter.dart';
import 'ImageConfirmationDialog.dart';

class ImageGalleryScreen extends StatefulWidget {
  final WidgetRef ref;

  ImageGalleryScreen({required this.ref});

  @override
  _ImageGalleryScreenState createState() => _ImageGalleryScreenState();
}

class _ImageGalleryScreenState extends State<ImageGalleryScreen> {
  List<AssetEntity> images = [];
  ScrollController _scrollController = ScrollController();
  int currentPage = 0;
  bool isLoading = false;
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll); // 스크롤 리스너
    _fetchPhotos(); // 초기 배치 로드
  }

  Future<void> _fetchPhotos({int limit = 50}) async {
    if (isLoading || !hasMore) return;

    setState(() {
      isLoading = true;
    });

    // Photo Manager 사용해서 이미지 불러오기
    List<AssetEntity> newImages = await widget.ref
        .read(imagePickerServiceProvider)
        .fetchImages(page: currentPage, limit: limit);

    setState(() {
      if (newImages.isEmpty) {
        hasMore = false; // 더 이상 불러올 이미지 없음
      } else {
        images.addAll(newImages); // 리스트에 이미지 추가
        currentPage++; // 다음 페이지로 넘어가기
      }
      isLoading = false;
    });
  }

  void _onScroll() {
    if (_scrollController.position.extentAfter < 300 && !isLoading && hasMore) {
      _fetchPhotos(); // 추가 사진 불러오는 트리거
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('프로필 사진을 고르세요'),
      ),
      body: GridView.builder(
        controller: _scrollController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, // 한 줄에 이미지 4개
        ),
        itemCount: images.length + (hasMore ? 1 : 0), // 로딩 아이콘 들어가는 공간 확보
        itemBuilder: (context, index) {
          if (index == images.length) {
            // 로딩 아이콘 보여줌
            return const Center(child: CircularProgressIndicator());
          }

          return FutureBuilder(
            future: images[index].thumbnailDataWithSize(ThumbnailSize(200, 200)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.data != null) {
                return GestureDetector(
                  onTap: () async {
                    File? fullResolutionFile = await images[index].file;
                    if (fullResolutionFile != null) {
                      _showImageConfirmationDialog(context, fullResolutionFile);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('이미지를 불러 올 수 없습니다.')),
                      );
                    }
                  },
                  child: Image.memory(
                    snapshot.data!,
                    fit: BoxFit.cover,
                  ),
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          );
        },
      ),
    );
  }

  void _showImageConfirmationDialog(BuildContext context, File imageFile) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ImageConfirmationDialog(imageFile: imageFile, ref: widget.ref);
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}