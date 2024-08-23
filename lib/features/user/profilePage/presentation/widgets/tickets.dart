import 'package:flutter/material.dart';
import 'package:metin/core/utils/adaptive_h_w.dart';
import 'package:metin/core/utils/adaptive_text.dart';

class Ticket extends StatelessWidget {
  const Ticket({Key? key, required this.text}) : super(key: key);

  /// The String of the ticket
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:
          aHeight(7, context) <= 40 ? aHeight(7, context) : aHeight(5, context),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                width: 1,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
        onPressed: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: AText(
            text: text,
            style: Theme.of(context).textTheme.button!.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
          ),
        ),
      ),
    );
  }
}
