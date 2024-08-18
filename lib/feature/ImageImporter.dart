import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

final imagePickerServiceProvider = Provider((ref) => ImagePickerService());

final imageFileProvider =
StateNotifierProvider<ImageFileNotifier, File?>((ref) {
  final imagePickerService = ref.watch(imagePickerServiceProvider);
  return ImageFileNotifier(imagePickerService);
});

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImageFromGallery(BuildContext context) async {
    try {
      final XFile? pickedFile =
      await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        return File(pickedFile.path);
      } else {
        _showErrorSnackbar(context, '선택된 사진이 없습니다.');
        return null;
      }
    } catch (e) {
      _showErrorSnackbar(context, '사진 불러오기에 실패했습니다: $e');
      return null;
    }
  }

  Future<File?> pickImageFromCamera(BuildContext context) async {
    try {
      final XFile? pickedFile =
      await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        return File(pickedFile.path);
      } else {
        _showErrorSnackbar(context, '찍은 사진이 없습니다.');
        return null;
      }
    } catch (e) {
      _showErrorSnackbar(context, '사진 찍기에 실패했습니다: $e');
      return null;
    }
  }

  void _showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

class ImageFileNotifier extends StateNotifier<File?> {
  final ImagePickerService _imagePickerService;

  ImageFileNotifier(this._imagePickerService) : super(null);

  Future<void> pickImageFromGallery(BuildContext context) async {
    state = await _imagePickerService.pickImageFromGallery(context);
  }

  Future<void> pickImageFromCamera(BuildContext context) async {
    state = await _imagePickerService.pickImageFromCamera(context);
  }

  void clearImage() {
    state = null;
  }
}
