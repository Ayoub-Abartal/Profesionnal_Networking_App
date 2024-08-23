import 'package:flutter/material.dart';

/// If the parent height is small the text will resize it font size.
/// If the parent height if enough the text will have it's specified font size.
///
/// This Must have a parent with specified height!!!!!!!!!!!!!!!!!!!!
/// a SizedBox will get the job done.
class AText extends StatelessWidget {
  /// The actual text
  final String text;

  /// The style of the text
  final TextStyle? style;

  /// The alignment of the text
  final TextAlign? textAlign;
  final double? textSpaceHeight;

  const AText({
    Key? key,
    required this.text,
    this.style,
    this.textAlign,
    this.textSpaceHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: textSpaceHeight,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          text,
          style: style,
          textAlign: textAlign,
          softWrap: true,
        ),
      ),
    );
  }
}
