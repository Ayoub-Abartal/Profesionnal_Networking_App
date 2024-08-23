import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:metin/core/utils/adaptive_h_w.dart';

import 'message_tile.dart';

/// Returns a message container shaped based on the sender.
class MessageContainer extends StatelessWidget {
  const MessageContainer({
    Key? key,
    required this.message,
  }) : super(key: key);

  ///The message with the content and the send date
  final Message message;

  /// The radius of the profile avatar.
  final Radius radius = const Radius.circular(15.0);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: SizedBox(
        width: aWidth(70, context),
        child: Column(
          crossAxisAlignment: message.isSender
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: message.isSender
                    ? const Color(0xffF3F2EF)
                    : const Color(0xfff0f7fe),
                borderRadius: BorderRadius.only(
                    topLeft: radius,
                    topRight: radius,
                    bottomLeft:
                        message.isSender ? radius : const Radius.circular(0),
                    bottomRight:
                        message.isSender ? const Radius.circular(0) : radius),
              ),
              child: Text(
                message.content,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Text(
                DateFormat('hh:mm a').format(DateTime.now()),
                style: Theme.of(context).textTheme.subtitle1,
              ),
            )
          ],
        ),
      ),
    );
  }
}
