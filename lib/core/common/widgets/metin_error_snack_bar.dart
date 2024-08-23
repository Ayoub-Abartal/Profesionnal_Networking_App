import 'package:flutter/material.dart';

import '../../utils/adaptive_text.dart';

void showErrorMessage(context, msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    content: Container(
        height: 90,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            AText(
              text: "Oh snap!",
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: Colors.white),
            ),
            AText(
              text: msg,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.white),
            ),
          ],
        )),
    behavior: SnackBarBehavior.floating,
  ));
}
