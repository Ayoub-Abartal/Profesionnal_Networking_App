import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:metin/core/utils/adaptive_h_w.dart';
import 'package:metin/core/utils/adaptive_text.dart';

/// Creates a button with the app design to use on all pages.
class MetinButton extends StatelessWidget {
  const MetinButton({
    Key? key,
    this.color,
    this.icon,
    this.textStyle,
    this.iconColor,
    this.borderRadius,
    this.horizontalPadding,
    this.verticalPadding,
    this.elevation,
    required this.isBorder,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  /// The color of the button
  final Color? color;

  /// The color of the icon
  final Color? iconColor;

  /// The text that will appear in the button
  final String text;

  /// The actual icon
  final IconData? icon;

  /// Is the button will have a border
  final bool isBorder;

  /// The style of the text of the button
  final TextStyle? textStyle;

  /// What will happen when you click the button
  final VoidCallback onPressed;

  final double? horizontalPadding;

  final double? verticalPadding;

  final double? borderRadius;

  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding ?? 1,
        vertical: verticalPadding ?? 1,
      ),
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            borderRadius ?? 12.0,
          ),
        ),
        elevation: elevation ?? 0,
        child: Container(
            width: aWidth(80, context),
            height: aHeight(8, context),
            decoration: BoxDecoration(
              color: color ?? Theme.of(context).primaryColor,
              border: isBorder
                  ? Border.all(color: Theme.of(context).primaryColor, width: 2)
                  : null,
              borderRadius: BorderRadius.circular(borderRadius ?? 12.0),
            ),
            child: icon != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(
                        icon,
                        color: iconColor,
                      ),
                      TextButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(borderRadius ?? 12.0),
                            ),
                          ),
                        ),
                        onPressed: onPressed,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: AText(text: text, style: textStyle),
                        ),
                      )
                    ],
                  )
                : TextButton(
                    onPressed: onPressed,
                    child: AText(
                      text: text,
                      style: textStyle,
                    ),
                  )),
      ),
    );
  }
}
