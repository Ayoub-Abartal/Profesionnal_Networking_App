import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metin/core/utils/adaptive_h_w.dart';
import 'package:metin/features/user/messages/presentation/bloc/broadcast/broadcast_bloc.dart';
import 'package:metin/features/user/messages/presentation/screens/broadcast_screen.dart';
import 'package:video_player/video_player.dart';

import '../../../../../core/utils/adaptive_text.dart';

class MediaPreview extends StatefulWidget {
  const MediaPreview({
    Key? key,
    // required this.media,
    // required this.mediaType,
  }) : super(key: key);

  // final XFile media;
  // final MediaType mediaType;

  @override
  State<MediaPreview> createState() => _MediaPreviewState();
}

class _MediaPreviewState extends State<MediaPreview> {
  late VideoPlayerController _controller;
  late MediaType mediaType;

  @override
  void initState() {
    var broadcastBloc = context.read<BroadcastBloc>();
    if (broadcastBloc.state.newBroadcastMediaType == MediaType.video) {
      _controller = VideoPlayerController.file(
          File(broadcastBloc.state.newBroadcastMedia!.path))
        ..initialize().then((value) => setState(() {}))
        ..setLooping(true)
        ..play();
    }
    // if (widget.mediaType == MediaType.video) {
    //   _controller = VideoPlayerController.file(File(widget.media.path))
    //     ..initialize().then((value) => setState(() {}))
    //     ..setLooping(true)
    //     ..play();
    // }
    super.initState();
  }

  @override
  void dispose() {
    if (mediaType == MediaType.video) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final broadcastBloc = context.read<BroadcastBloc>();
    mediaType = context.read<BroadcastBloc>().state.newBroadcastMediaType!;
    return Scaffold(
      backgroundColor: Colors.black,
      body: broadcastBloc.state.newBroadcastMediaType == MediaType.video
          ? Center(
              child: _controller.value.isInitialized
                  ? Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 8.0),
                            child: Container(
                              height: aHeight(8, context),
                              decoration: BoxDecoration(
                                color: Colors.black45,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      style: ButtonStyle(
                                          overlayColor:
                                              MaterialStateProperty.all(
                                        Colors.black54,
                                      )),
                                      onPressed: () {
                                        setState(() {
                                          _controller.value.isPlaying
                                              ? _controller.pause()
                                              : _controller.play();
                                        });
                                      },
                                      child: AText(
                                        textSpaceHeight: aHeight(3.5, context),
                                        text: _controller.value.isPlaying
                                            ? "Pause"
                                            : "Play",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4!
                                            .copyWith(color: Colors.white),
                                      ),
                                    ),
                                    TextButton(
                                      style: ButtonStyle(
                                          overlayColor:
                                              MaterialStateProperty.all(
                                        Colors.black54,
                                      )),
                                      onPressed: () {
                                        broadcastBloc.add(
                                          AddABroadcast(
                                            broadcast: Broadcast(
                                              url: broadcastBloc.state
                                                  .newBroadcastMedia!.path,
                                              mediaType: MediaType.video,
                                              duration:
                                                  const Duration(seconds: 5),
                                            ),
                                          ),
                                        );
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            '/home-screen',
                                            ModalRoute.withName('/'));
                                      },
                                      child: AText(
                                        textSpaceHeight: aHeight(3.5, context),
                                        text: "Confirm",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4!
                                            .copyWith(color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 20,
                          right: 10,
                          child: IconButton(
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 33,
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ),
                      ],
                    )
                  : const Center(child: CircularProgressIndicator()),
            )
          : Stack(
              children: [
                SizedBox(
                  height: aHeight(100, context),
                  width: aWidth(100, context),
                  child: Image(
                    fit: BoxFit.cover,
                    image: FileImage(
                        File(broadcastBloc.state.newBroadcastMedia!.path)),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 8.0),
                    child: Container(
                      height: aHeight(8, context),
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(
                                Colors.black54,
                              )),
                              onPressed: () {
                                broadcastBloc.add(
                                  ChooseMediaBroadcast(
                                    media:
                                        broadcastBloc.state.newBroadcastMedia!,
                                    mediaType: broadcastBloc
                                        .state.newBroadcastMediaType!,
                                  ),
                                );
                                Navigator.pushNamed(context, '/image-editor');
                              },
                              child: AText(
                                textSpaceHeight: aHeight(3.5, context),
                                text: "Edit image",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            TextButton(
                              style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(
                                Colors.black54,
                              )),
                              onPressed: () {
                                broadcastBloc.add(
                                  AddABroadcast(
                                    broadcast: Broadcast(
                                      url: broadcastBloc
                                          .state.newBroadcastMedia!.path,
                                      mediaType: MediaType.image,
                                      duration: const Duration(seconds: 5),
                                    ),
                                  ),
                                );
                                Navigator.pushNamedAndRemoveUntil(context,
                                    '/home-screen', ModalRoute.withName('/'));
                              },
                              child: AText(
                                textSpaceHeight: aHeight(3.5, context),
                                text: "Confirm",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 10,
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 33,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
            ),
    );
  }
}
