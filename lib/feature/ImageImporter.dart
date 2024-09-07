import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_manager/photo_manager.dart';
import 'dart:io';

final imagePickerServiceProvider = Provider((ref) => ImagePickerService());

final imageFileProvider = StateNotifierProvider<ImageFileNotifier, File?>((ref) {
  final imagePickerService = ref.watch(imagePickerServiceProvider);
  return ImageFileNotifier(imagePickerService);
});

class ImagePickerService {
  Future<List<AssetEntity>> fetchImages({int page = 0, int limit = 50}) async {
    final PermissionState permission = await PhotoManager.requestPermissionExtend();
    if (permission.isAuth) {
      List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(type: RequestType.image);
      if (albums.isNotEmpty) {
        final AssetPathEntity album = albums.first;
        return await album.getAssetListPaged(page: page, size: limit);
      }
    }
    return [];
  }
}

class ImageFileNotifier extends StateNotifier<File?> {
  final ImagePickerService _imagePickerService;

  ImageFileNotifier(this._imagePickerService) : super(null);

  void clearImage() {
    state = null;
  }
}