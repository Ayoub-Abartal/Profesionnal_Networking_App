import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:metin/core/common/widgets/metin_text_field.dart';
import 'package:metin/core/constants.dart';
import 'package:metin/core/utils/adaptive_h_w.dart';
import 'package:metin/core/utils/adaptive_text.dart';
import 'package:metin/features/user/messages/presentation/bloc/broadcast/broadcast_bloc.dart';
import 'package:metin/features/user/messages/presentation/bloc/messaging/messaging_bloc.dart';
import 'package:metin/features/user/messages/presentation/screens/broadcasts_controller.dart';
import 'package:metin/features/user/messages/presentation/widgets/add_broadcast.dart';
import 'package:metin/features/user/messages/presentation/widgets/broadcast_tile.dart';
import 'package:metin/features/user/messages/presentation/widgets/message_tile.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    final TextTheme textStyle = Theme.of(context).textTheme;
    final broadcastBloc = context.read<BroadcastBloc>();
    final messagingBloc = context.read<MessagingBloc>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0, top: 10.0),
                      child: AText(
                        textSpaceHeight: aHeight(6.5, context),
                        text: "Messages",
                        style: textStyle.headline4!.copyWith(fontSize: 28),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: MetinTextField(
                        prefixIcon: Icon(FontAwesomeIcons.magnifyingGlass),
                        hintText: "Search",
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 30),
                child: Row(
                  children: [
                    Text(
                      "Broadcast",
                      style: textStyle.button,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: Icon(
                        FontAwesomeIcons.volumeHigh,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
              BlocBuilder<BroadcastBloc, BroadcastState>(
                builder: (context, state) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        SizedBox(
                          width: aWidth(5, context),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: Row(
                            children: [
                              AddBroadcast(
                                onTap: () async {
                                  await availableCameras().then(
                                    (value) {
                                      broadcastBloc.add(
                                          InitializeCamera(cameras: value));
                                      Navigator.pushNamed(
                                          context, "/add-broadcast-screen");
                                    },
                                  );
                                },
                              ),
                              if (broadcastBloc
                                  .state.broadcasts[0].broadcasts.isNotEmpty)
                                BroadcastTile(
                                  contactProfile: userProfile,
                                  onTap: () {
                                    broadcastBloc.add(LoadBroadcast(
                                        index: contacts.reversed.length - 1));
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BlocProvider.value(
                                          value: broadcastBloc,
                                          child: BroadcastController(
                                            selectedBroadIndex:
                                                state.currentBroadcastIndex,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              Row(
                                children:
                                    broadcastBloc.state.broadcasts.reversed.map(
                                  (e) {
                                    if (e.broadcasts.isNotEmpty) {
                                      return BroadcastTile(
                                        contactProfile: e,
                                        onTap: () {
                                          broadcastBloc.add(LoadBroadcast(
                                              index: contacts.reversed
                                                  .toList()
                                                  .indexOf(e)));
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  BlocProvider.value(
                                                value: broadcastBloc,
                                                child: BroadcastController(
                                                  selectedBroadIndex: state
                                                      .currentBroadcastIndex,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    } else {
                                      return const SizedBox();
                                    }
                                  },
                                ).toList(),
                              )
                              // for (var e
                              //     in _broadcastBloc.state.broadcasts.reversed)
                              //   BroadcastTile(
                              //     contactProfile: e,
                              //     onTap: () {
                              //       _broadcastBloc.add(LoadBroadcast(
                              //           index: contacts.reversed
                              //               .toList()
                              //               .indexOf(e)));
                              //       Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //           builder: (context) =>
                              //               BlocProvider.value(
                              //             value: _broadcastBloc,
                              //             child: BroadcastController(
                              //               selectedBroadIndex:
                              //                   state.currentBroadcastIndex,
                              //             ),
                              //           ),
                              //         ),
                              //       );
                              //     },
                              //   ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Messages",
                      style: textStyle.headline4!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Column(
                      children: List.generate(
                        contacts.length,
                        (index) => MessageTile(
                          profile: contacts[contacts.length - 1 - index],
                          onTap: () {
                            messagingBloc.add(LoadContactConversation(
                                profile:
                                    contacts[contacts.length - 1 - index]));
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IconTextButton extends StatelessWidget {
  const IconTextButton(
      {Key? key, required this.text, required this.icon, this.onTap})
      : super(key: key);
  final String text;
  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(
            width: 8,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}
