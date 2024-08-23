import 'package:flutter/material.dart';
import 'package:metin/core/common/widgets/metin_icon_button.dart';
import 'package:metin/core/utils/adaptive_h_w.dart';

import 'message_tile.dart';

/// This is the widget that appears in the top of the broadcast page, that contains
/// the profile avatar and the profile name with a close icon in the right to close the broadcast.
class ProfileInfo extends StatelessWidget {
  final ContactProfile user;
  const ProfileInfo({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20.0,
          backgroundColor: Colors.grey[300],
          backgroundImage: AssetImage(
            user.avatar,
          ),
        ),
        const SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: Text(
            user.name,
            style: Theme.of(context)
                .textTheme
                .button!
                .copyWith(color: Colors.white),
          ),
        ),
        MetinIconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          backgroundColor: Colors.white.withOpacity(0.1),
          height: 48,
          borderColor: const Color(0xffE8E6EA),
          iconSize: aHeight(2.5, context),
          iconColor: Colors.white,
          icon: Icons.close,
        )
      ],
    );
  }
}
