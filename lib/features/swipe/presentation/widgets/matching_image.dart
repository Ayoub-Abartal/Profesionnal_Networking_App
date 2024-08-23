import 'package:flutter/material.dart';

class MatchingImage extends StatelessWidget {
  const MatchingImage(
      {Key? key,
      required this.angle,
      required this.imageSize,
      required this.imageLink})
      : super(key: key);
  final double angle;
  final Size imageSize;
  final String imageLink;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: Container(
        height: imageSize.height,
        width: imageSize.width,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              spreadRadius: 0,
              blurRadius: 15,
              offset: const Offset(0, 15), // changes position of shadow
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image(
            image: AssetImage(imageLink),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
