import 'package:flutter/material.dart';
import 'package:metin/core/utils/adaptive_h_w.dart';

/// Creates a button with an icon to use on all pages.
class MetinIconButton extends StatelessWidget {
  const MetinIconButton({
    Key? key,
    this.iconColor,
    required this.icon,
    this.horizontalPadding,
    this.onPressed,
    this.iconSize,
    this.width,
    this.height,
    this.backgroundColor,
    this.borderColor,
    this.color,
    this.size,
  }) : super(key: key);

  final Color? iconColor;
  final Color? backgroundColor;
  final Color? borderColor;

  /// The color of the icon
  final Color? color;

  /// The actual icon
  final IconData? icon;

  /// The space between the buttons horizontally
  final double? horizontalPadding;

  /// What happens when the button pressed
  final void Function()? onPressed;

  final double? height;

  final double? width;

  /// The size of the Icon
  final double? size;

  /// the size of the button
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding ?? 1.0,
        vertical: 2.0,
      ),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          border: Border.all(color: borderColor ?? const Color(0xffE8E6EA)),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: TextButton(
          onPressed: onPressed,
          child: Icon(icon,
              size: iconSize ?? aHeight(4, context), color: iconColor),
        ),
      ),
    );
  }
}
