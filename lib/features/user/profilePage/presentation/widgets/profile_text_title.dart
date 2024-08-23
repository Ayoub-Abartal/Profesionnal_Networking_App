import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:metin/core/utils/adaptive_h_w.dart';
import 'package:metin/core/utils/adaptive_text.dart';

import 'metin_plus_button.dart';

/// The title in the profile page which will contain
/// the String and an edit button and a see all button
class TitleText extends StatelessWidget {
  const TitleText({
    Key? key,
    required this.text,
    this.onSeeAllPressed,
    this.onEditPressed,
    this.isPlusIcon = false,
    this.showEditButton = false,
    this.seeAll = false,
  }) : super(key: key);

  /// The title String
  final String text;

  /// Will it show the see all button
  final bool seeAll;

  /// Will it shows the edit button
  final bool showEditButton;

  /// Will it shows the plus or edit icon
  final bool isPlusIcon;

  /// What happens when the see all button is pressed
  final void Function()? onSeeAllPressed;

  /// What happens when the edit button is pressed
  final void Function()? onEditPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: aHeight(4.5, context),
            child: AText(
              text: text,
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          Row(
            children: [
              if (showEditButton)
                Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: MetinPlusButton(
                    isTicket: true,
                    icon: isPlusIcon ? FontAwesomeIcons.plus : Icons.edit,
                    onPressed: onEditPressed,
                  ),
                ),
              if (seeAll)
                TextButton(
                  onPressed: onSeeAllPressed,
                  child: Text(
                    "See All",
                    style: Theme.of(context).textTheme.button!.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}
