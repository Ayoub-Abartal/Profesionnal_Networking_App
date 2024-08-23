import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:metin/core/utils/adaptive_h_w.dart';

/// This is a special class that it will be used to add a broadcast. That's why it
/// is a separate component.
class AddBroadcast extends StatelessWidget {
  const AddBroadcast({Key? key, this.onTap}) : super(key: key);

  final void Function()? onTap;

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
                            backgroundColor: Colors.grey.withOpacity(0.8),
                            radius: radius,
                            child: const Icon(
                              FontAwesomeIcons.plus,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "You",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontWeight: FontWeight.bold),
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
