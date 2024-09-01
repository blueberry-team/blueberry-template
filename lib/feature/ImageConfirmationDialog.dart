import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'ImageImporter.dart';

class ImageConfirmationDialog extends StatelessWidget {
  final File imageFile;
  final WidgetRef ref;

  const ImageConfirmationDialog({
    Key? key,
    required this.imageFile,
    required this.ref,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.file(
            imageFile,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '이 사진을 사용하시겠습니까?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  ref.read(imageFileProvider.notifier).clearImage();
                },
                child: Text('다시 선택'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  ref.read(imageFileProvider.notifier).state = imageFile;
                },
                child: Text('사용'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}