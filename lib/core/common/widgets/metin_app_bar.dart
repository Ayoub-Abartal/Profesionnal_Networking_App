import 'package:flutter/material.dart';

/// Creates a widget that will be placed in the top of the screen that will have
/// three widgets, it will be used specially for settings and navigation back.
/// The preferred size attribute is set to a starting value and cannot be changed in the application.
class MetinAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(400);

  const MetinAppBar({
    Key? key,
    this.leading = const SizedBox(),
    this.title = const SizedBox(),
    this.actions = const SizedBox(),
  }) : super(key: key);

  /// this is the widget that will appear in the left
  final Widget? leading;

  /// this is the widget that will appear in the center
  final Widget? title;

  /// this is the widget that will appear in the right
  final Widget? actions;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20.0, right: 20.0, top: 30, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            leading!,
            title!,
            actions!,
          ],
        ),
      ),
    );
  }
}
