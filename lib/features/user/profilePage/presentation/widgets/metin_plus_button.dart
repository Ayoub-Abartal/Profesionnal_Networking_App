import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:metin/core/utils/adaptive_h_w.dart';

class MetinPlusButton extends StatelessWidget {
  const MetinPlusButton({
    Key? key,
    this.color,
    this.onPressed,
    this.isTicket = false,
    this.icon = FontAwesomeIcons.plus,
  }) : super(key: key);

  /// The color of the icon
  final Color? color;

  /// Is the button a rectangle or a square
  final bool isTicket;

  /// What happens when the button is pressed
  final void Function()? onPressed;

  /// The actual icon
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: aHeight(8, context),
        height: isTicket ? aHeight(5, context) : aHeight(8, context),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: TextButton(
          onPressed: onPressed,
          child: Icon(icon,
              size: isTicket ? aHeight(3, context) : aHeight(4, context),
              color: Theme.of(context).primaryColor),
        ));
  }
}
