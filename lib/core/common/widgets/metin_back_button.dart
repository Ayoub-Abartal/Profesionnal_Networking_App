import 'package:flutter/material.dart';
import 'package:metin/core/common/widgets/metin_icon_button.dart';

/// Creates a button with an arrow looking to the left to use on all pages.
class MetinBackButton extends StatelessWidget {
  const MetinBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MetinIconButton(
      height: 60,
      iconSize: 20,
      icon: Icons.arrow_back_ios_rounded,
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
