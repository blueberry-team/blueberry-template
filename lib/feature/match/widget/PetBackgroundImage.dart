import 'package:flutter/cupertino.dart';

class PetBackgroundImage extends StatelessWidget {
  final String imageUrl;
  final String petId;

  const PetBackgroundImage({
    super.key,
    required this.imageUrl,
    required this.petId,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'pet_image_$petId',
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
