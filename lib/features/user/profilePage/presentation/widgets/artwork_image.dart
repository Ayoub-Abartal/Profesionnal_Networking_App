import 'package:flutter/material.dart';

class ArtWorkImage extends StatelessWidget {
  const ArtWorkImage({
    Key? key,
    required this.image,
  }) : super(key: key);

  /// The Image link
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 3.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        // This should be replaced with network image when backend is implemented !!!!!
        child: Image.asset(
          image,
        ),
      ),
    );
  }
}
