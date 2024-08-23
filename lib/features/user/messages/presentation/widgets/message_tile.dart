import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metin/core/common/widgets/metin_bottom_sheet.dart';
import 'package:metin/core/utils/adaptive_h_w.dart';
import 'package:metin/features/user/messages/presentation/bloc/messaging/messaging_bloc.dart';
import 'package:metin/features/user/messages/presentation/screens/broadcast_screen.dart';

import 'chat_window.dart';

/// The message box that appears in the messages screen.
class MessageTile extends StatelessWidget {
  const MessageTile({
    Key? key,
    required this.profile,
    required this.onTap,
  }) : super(key: key);

  final ContactProfile profile;
  final void Function() onTap;

  /// this returns the last message date data
  String getDate() {
    if (profile.conversation.messages.isEmpty) {
      return "";
    }
    final DateTime now = DateTime.now();
    Duration diff = now.difference(profile.conversation.messages.last.sendTime);
    if (diff.inDays >= 365) {
      return "${diff.inDays ~/ 365} y";
    } else if (diff.inDays > 0) {
      return "${diff.inDays} d";
    } else if (diff.inHours > 0) {
      return "${diff.inHours % 24} h";
    } else if (diff.inMinutes > 0) {
      return "${diff.inMinutes % 60} min";
    } else {
      return "${diff.inSeconds % 60} sec";
    }
  }

  @override
  Widget build(BuildContext context) {
    final double radius = aHeight(3.7, context);
    final TextTheme textStyle = Theme.of(context).textTheme;
    final messagingBloc = context.read<MessagingBloc>();

    return InkWell(
      onTap: () {
        onTap();
        for (int i = 0; i < profile.conversation.messages.length; i++) {
          if (!profile.conversation.messages[i].isRead) {
            profile.conversation.messages[i].isRead = true;
          }
        }
        Navigator.push(
            context,
            MetinBottomSheet(
              content: BlocProvider.value(
                value: messagingBloc,
                child: const ChatWindow(),
              ),
            ));
      },
      child: Row(
        children: [
          SizedBox(
            height: aHeight(12, context),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [Colors.orange, Colors.pink]),
              ),
              child: CircleAvatar(
                radius: (radius + 4.0),
                backgroundColor: Colors.transparent,
                child: CircleAvatar(
                  radius: (radius + 2.0),
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                      backgroundImage: AssetImage(profile.avatar),
                      radius: radius),
                ),
              ),
            ),
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.withOpacity(0.2)),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: aWidth(61, context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          profile.name,
                          style: textStyle.bodyText2!
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                        Text(
                          getDate(),
                          style: textStyle.headline4!
                              .copyWith(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: aHeight(0.5, context),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: aWidth(56, context),
                        child: Text(
                          profile.conversation.messages.isNotEmpty
                              ? profile.conversation.messages.last.content
                              : "Send a message to start a conversation",
                          style: textStyle.bodyText2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          maxLines: 1,
                        ),
                      ),
                      BlocBuilder<MessagingBloc, MessagingState>(
                          builder: (context, state) {
                        if (profile.conversation.messages
                            .where((element) => element.isRead == false)
                            .isNotEmpty) {
                          return CircleAvatar(
                            radius: 10,
                            backgroundColor: Theme.of(context).primaryColor,
                            child: Text(profile.conversation.unreadMessagesCount
                                .toString()),
                          );
                        } else {
                          return const SizedBox();
                        }
                      }),
                      //Center(child: Text(profile.messages.length.toString()))
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ContactProfile {
  String name;
  String avatar;
  Conversation conversation;
  List<Broadcast> broadcasts;

  ContactProfile({
    required this.name,
    required this.avatar,
    required this.conversation,
    required this.broadcasts,
  });
}

class Conversation {
  List<Message> messages;
  int unreadMessagesCount = 0;

  Conversation({required this.messages}) {
    messages.sort((a, b) => a.sendTime.compareTo(b.sendTime));
    unreadMessagesCount =
        messages.where((element) => element.isRead == false).length;
  }
}

class Message {
  String content;
  DateTime sendTime;
  bool isSender;
  bool isRead;

  Message({
    required this.content,
    required this.sendTime,
    required this.isSender,
    required this.isRead,
  }) {
    if (isSender) {
      isRead = true;
    }
  }
}
