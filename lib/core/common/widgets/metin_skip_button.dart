import 'package:flutter/material.dart';

/// Creates a button with "Skip" string on it to use on all pages.
class MetinSkipButton extends StatelessWidget {
  const MetinSkipButton({Key? key, this.onPressed}) : super(key: key);

  /// What happens when the button pressed
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          "Skip",
          style: Theme.of(context)
              .textTheme
              .button!
              .copyWith(color: Theme.of(context).primaryColor),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
