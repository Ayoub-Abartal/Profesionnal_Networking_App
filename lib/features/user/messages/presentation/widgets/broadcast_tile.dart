import 'package:flutter/material.dart';
import 'package:metin/core/utils/adaptive_h_w.dart';
import 'package:metin/features/user/messages/presentation/widgets/message_tile.dart';

/// The design of the broadcasts on top of messages section
class BroadcastTile extends StatelessWidget {
  final ContactProfile contactProfile;
  final void Function()? onTap;

  const BroadcastTile({
    Key? key,
    required this.contactProfile,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double radius = aHeight(4.1, context);
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    //height: aHeight(10, context),
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Colors.orange, Colors.pink],
                        ),
                      ),
                      child: CircleAvatar(
                        radius: (radius + 4.0),
                        backgroundColor: Colors.transparent,
                        child: CircleAvatar(
                          radius: (radius + 2.0),
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            backgroundImage: AssetImage(contactProfile.avatar),
                            radius: radius,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    contactProfile.name,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
