import 'package:flutter/material.dart';
import 'package:metin/core/utils/adaptive_h_w.dart';

class MetinPickButton extends StatelessWidget {
  const MetinPickButton({
    Key? key,
    required this.buttonTitle,
    required this.onPressed,
    this.showRightButtonArrow = true,
  }) : super(key: key);

  /// The button title
  final Widget buttonTitle;

  /// What happens when the button is pressed
  final VoidCallback onPressed;

  /// Is the arrow in the right of the button visible.
  final bool showRightButtonArrow;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
      child: SizedBox(
        height: aHeight(9, context),
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all<double>(0),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: const BorderSide(
                  color: Color(0xffeeedef),
                ),
              ),
            ),
          ),
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            onPressed();
          },
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                bottom: 0,
                left: 1,
                child: buttonTitle,
              ),
              if (showRightButtonArrow)
                const Positioned(
                  top: 0,
                  bottom: 0,
                  right: 1,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: Color(0xffadafba),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
