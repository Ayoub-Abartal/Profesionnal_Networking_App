import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:metin/core/common/widgets/metin_icon_button.dart';
import 'package:metin/core/common/widgets/metin_text_field.dart';
import 'package:metin/core/utils/adaptive_h_w.dart';
import 'package:metin/core/utils/adaptive_text.dart';
import 'package:metin/features/user/messages/presentation/bloc/messaging/messaging_bloc.dart';

import 'message.dart';
import 'message_tile.dart';

class ChatWindow extends StatefulWidget {
  const ChatWindow({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatWindow> createState() => _ChatWindowState();
}

class _ChatWindowState extends State<ChatWindow> with WidgetsBindingObserver {
  /// A focus node to know when the user is typing in the text field
  final FocusNode _focus = FocusNode();

  final TextEditingController _controller = TextEditingController();

  final _messagesListKey = GlobalKey<AnimatedListState>();

  /// The height of the chat window
  double chatWindowHeight = 0;

  /// A boolean specifies if the user is typing or not
  bool isWriting = false;

  /// Do something when the user is typing or not
  void _onFocusChange() {
    isWriting = !isWriting;
    if (isWriting) {
      setState(() {
        chatWindowHeight = aHeight(30, context);
      });
    } else {
      setState(() {
        chatWindowHeight = aHeight(50, context);
      });
    }
  }

  @override
  void initState() {
    _focus.addListener(_onFocusChange);
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final value = WidgetsBinding.instance.window.viewInsets.bottom;
    if (MediaQuery.of(context).viewInsets.bottom != 0) {
      if (value == 0) {
        _focus.unfocus();
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messagingBloc = context.read<MessagingBloc>();
    //List<Message> messages = _messagingBloc.state.currentConversation;
    final double radius = aHeight(3, context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Padding(
        padding: EdgeInsets.only(
          top: aHeight(5, context),
          bottom: aHeight(4, context),
          left: aWidth(6, context),
          right: aWidth(6, context),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: aHeight(4, context)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
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
                                backgroundImage: AssetImage(messagingBloc
                                    .state.currentContactProfile.avatar),
                                radius: radius,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AText(
                              text: messagingBloc
                                  .state.currentContactProfile.name,
                              style: Theme.of(context).textTheme.headline3,
                              textSpaceHeight: aHeight(5, context),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 4.0),
                                  child: CircleAvatar(
                                    radius: 3.5,
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                  ),
                                ),
                                Text(
                                  "Online",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(fontSize: 12),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  MetinIconButton(
                    icon: FontAwesomeIcons.ellipsisVertical,
                    iconColor: Colors.black,
                    height: aHeight(3, context),
                    iconSize: aHeight(7, context),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: aWidth(30, context),
                    child: const Divider(
                      thickness: 1.5,
                      color: Color(0xffE8E6EA),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Today",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  SizedBox(
                    width: aWidth(30, context),
                    child: const Divider(
                      thickness: 1.5,
                      color: Color(0xffE8E6EA),
                    ),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              width: aWidth(100, context),
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              height: chatWindowHeight == 0
                  ? aHeight(50, context)
                  : chatWindowHeight,
              child: BlocBuilder<MessagingBloc, MessagingState>(
                builder: (context, state) {
                  List<Message> messages =
                      messagingBloc.state.currentConversation.reversed.toList();
                  return AnimatedList(
                      shrinkWrap: true,
                      reverse: true,
                      physics: const BouncingScrollPhysics(),
                      key: _messagesListKey,
                      initialItemCount: state.currentConversation.length,
                      itemBuilder: (context, index, animation) {
                        return SlideTransition(
                          position: Tween(
                                  begin: const Offset(0.5, 0.0),
                                  end: const Offset(0.0, 0.0))
                              .animate(animation),
                          child: Align(
                            alignment: messages[index].isSender
                                ? Alignment.topRight
                                : Alignment.topLeft,
                            child: MessageContainer(
                              message: messages[index],
                            ),
                          ),
                        );
                      });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: aWidth(65, context),
                    child: MetinTextField(
                      focusNode: _focus,
                      hintText: "Your message",
                      controller: _controller,
                    ),
                  ),
                  MetinIconButton(
                      horizontalPadding: 10,
                      height: aHeight(7.5, context),
                      onPressed: () {
                        if (_controller.text.isEmpty) {
                          return;
                        }
                        messagingBloc.add(SendMessageToContact(
                            message: Message(
                          isSender: true,
                          sendTime: DateTime.now(),
                          content: _controller.text,
                          isRead: true,
                        )));
                        _messagesListKey.currentState?.insertItem(0);
                        _controller.clear();
                      },
                      icon: FontAwesomeIcons.paperPlane,
                      iconSize: aHeight(3, context),
                      iconColor: Theme.of(context).primaryColor),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
