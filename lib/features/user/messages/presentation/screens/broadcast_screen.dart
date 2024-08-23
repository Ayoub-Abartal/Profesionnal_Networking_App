import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metin/core/constants.dart';
import 'package:metin/features/user/messages/presentation/bloc/broadcast/broadcast_bloc.dart';
import 'package:metin/features/user/messages/presentation/widgets/add_comment.dart';
import 'package:metin/features/user/messages/presentation/widgets/animated_bar.dart';
import 'package:metin/features/user/messages/presentation/widgets/message_tile.dart';
import 'package:metin/features/user/messages/presentation/widgets/profile_info.dart';
import 'package:video_player/video_player.dart';

/// This class returns a screen that handles the broadcast depending on it's type.
class BroadcastScreen extends StatefulWidget {
  final ContactProfile profile;

  const BroadcastScreen({Key? key, required this.profile}) : super(key: key);

  @override
  State<BroadcastScreen> createState() => _BroadcastScreenState();
}

class _BroadcastScreenState extends State<BroadcastScreen>
    with SingleTickerProviderStateMixin {
  /// A focus node to know when the user is typing in the text field
  final FocusNode _focus = FocusNode();

  /// A page controller to manage the switch between to stories.
  late PageController _pageController;

  /// An animation controller to control the flow of the animation.
  late AnimationController _animationController;

  /// A video controller to handle the broadcasts in the type of a video.
  late VideoPlayerController _videoController;

  /// Do something when the user is typing or not
  void _onFocusChange() {
    if (_animationController.isAnimating) {
      _animationController.stop();
      if (widget.profile.broadcasts[_currentIndex].mediaType ==
          MediaType.video) {
        _videoController.pause();
      }
    } else {
      _animationController.forward();
      if (widget.profile.broadcasts[_currentIndex].mediaType ==
          MediaType.video) {
        _videoController.play();
      }
    }
  }

  @override
  void initState() {
    _focus.addListener(_onFocusChange);
    // Initializing an empty video controller in case it will be not used.
    if (widget.profile.broadcasts
        .any((element) => element.mediaType == MediaType.video)) {
      _videoController = VideoPlayerController.asset("");
    }
    _pageController = PageController();
    _animationController = AnimationController(vsync: this);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.stop();
        _animationController.reset();
        setState(() {
          if (_currentIndex + 1 < widget.profile.broadcasts.length) {
            _currentIndex += 1;
            _loadBroadcast(broadcast: widget.profile.broadcasts[_currentIndex]);
          } else {
            // Next broadcast if exist, pop if it doesn't
            final broadcastBloc = context.read<BroadcastBloc>();
            if (broadcastBloc.state.currentBroadcastIndex <
                contacts.length - 1) {
              broadcastBloc.add(NextBroadcastProfile(
                  index: broadcastBloc.state.currentBroadcastIndex + 1));
            } else {
              Navigator.pop(context);
            }
            // out of bounds - loop the story another option instead of popping
            // _currentIndex = 0;
            // _loadBroadcast(broadcast: widget.profile.broadcasts[_currentIndex]);
          }
        });
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Broadcast firstBroadcast = widget.profile.broadcasts.first;
      _loadBroadcast(broadcast: firstBroadcast, animateToPage: false);
    });

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _focus.dispose();
    _pageController.dispose();
    _animationController.dispose();
    if (widget.profile.broadcasts
        .any((element) => element.mediaType == MediaType.video)) {
      _videoController.dispose();
    }
    super.dispose();
  }

  /// The index of the current broadcast
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // This line is to rotate the screen to portrait mode for better view of the broadcast.
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    final Broadcast broadcast = widget.profile.broadcasts[_currentIndex];
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapDown: (details) => _onTapDown(details, broadcast),
        onLongPressStart: (details) => _onLongPress(broadcast),
        onLongPressEnd: (details) => _onLongPress(broadcast),
        child: Stack(
          children: [
            PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              itemCount: widget.profile.broadcasts.length,
              itemBuilder: (context, i) {
                final Broadcast broadcast = widget.profile.broadcasts[i];
                switch (broadcast.mediaType) {
                  case MediaType.image:
                    return Stack(
                      fit: StackFit.expand,
                      clipBehavior: Clip.none,
                      children: [
                        Image.file(
                          File(broadcast.url),
                          fit: BoxFit.cover,
                          // placeholder: (context, url) => const Center(
                          //   child: CircularProgressIndicator(),
                          // ),
                        ),
                        // CachedNetworkImage(
                        //   imageUrl: broadcast.url,
                        //   fit: BoxFit.cover,
                        //   placeholder: (context, url) => const Center(
                        //     child: CircularProgressIndicator(),
                        //   ),
                        // ),
                        // Image.file(
                        //   File(broadcast.url),
                        //   fit: BoxFit.cover,
                        // ),
                        AddCommentSection(focus: _focus),
                      ],
                    );
                  case MediaType.video:
                    if (_videoController.value.isInitialized) {
                      return Stack(
                        fit: StackFit.expand,
                        clipBehavior: Clip.none,
                        children: [
                          FittedBox(
                            fit: BoxFit.cover,
                            child: SizedBox(
                              width: _videoController.value.size.width,
                              height: _videoController.value.size.height,
                              child: VideoPlayer(_videoController),
                            ),
                          ),
                          AddCommentSection(focus: _focus),
                        ],
                      );
                    }
                    break;
                }
                return const SizedBox.shrink();
              },
            ),
            Positioned(
              top: 40.0,
              left: 10.0,
              right: 10.0,
              child: Column(
                children: [
                  Row(
                    children: getBars(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 1.5,
                      vertical: 10.0,
                    ),
                    child: ProfileInfo(
                      user: widget.profile,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// This function handles the user interaction with the broadcast.
  void _onTapDown(TapDownDetails details, Broadcast broadcast) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;
    final broadcastBloc = context.read<BroadcastBloc>();
    // if user taps on the left go back to the previous broadcast.
    if (dx < screenWidth / 3) {
      setState(() {
        if (_currentIndex - 1 >= 0) {
          _currentIndex -= 1;
          _loadBroadcast(broadcast: widget.profile.broadcasts[_currentIndex]);
        } else {
          if (broadcastBloc.state.currentBroadcastIndex == 0) {
            return;
          } else {
            broadcastBloc.add(NextBroadcastProfile(
                index: broadcastBloc.state.currentBroadcastIndex - 1));
          }
        }
      });
      // if user taps on the right go to the next broadcast.
    } else if (dx > 2 * screenWidth / 3) {
      setState(() {
        if (_currentIndex + 1 < widget.profile.broadcasts.length) {
          _currentIndex += 1;
          _loadBroadcast(broadcast: widget.profile.broadcasts[_currentIndex]);
        } else {
          if (broadcastBloc.state.currentBroadcastIndex >=
              contacts.reversed.toList().length - 1) {
            Navigator.pop(context);
          } else {
            broadcastBloc.add(NextBroadcastProfile(
                index: broadcastBloc.state.currentBroadcastIndex + 1));
          }

          // _currentIndex = 0;
          // _loadBroadcast(broadcast: widget.broadcasts[_currentIndex]);
        }
      });
      // if the user taps on the center of the broadcast and it is a video pause it.
    } else {
      if (broadcast.mediaType == MediaType.video) {
        if (_videoController.value.isPlaying) {
          _videoController.pause();
          _animationController.stop();
        } else {
          _videoController.play();
          _animationController.forward();
        }
      }
    }
  }

  /// This function handles pause/play the broadcast in case of an image.
  void _onLongPress(Broadcast broadcast) {
    if (broadcast.mediaType == MediaType.image) {
      if (_animationController.isAnimating) {
        _animationController.stop();
      } else {
        _animationController.forward();
      }
    }
  }

  /// This function handles the loading of the broadcast depending on it's type.
  void _loadBroadcast(
      {required Broadcast broadcast, bool animateToPage = true}) {
    _animationController.stop();
    _animationController.reset();

    switch (broadcast.mediaType) {
      case MediaType.image:
        _animationController.duration = broadcast.duration;
        _animationController.forward();
        break;
      case MediaType.video:
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );
        _videoController = VideoPlayerController.network(broadcast.url)
          ..initialize();
        _videoController.dispose();
        _videoController = VideoPlayerController.network(broadcast.url)
          ..initialize().then((_) {
            setState(() {
              if (_videoController.value.isInitialized) {
                Navigator.pop(context); //pop dialog

                _animationController.duration = _videoController.value.duration;
                _videoController.play();
                _animationController.forward();
              }
            });
          });
        break;
    }

    if (animateToPage) {
      _pageController.animateToPage(_currentIndex,
          duration: const Duration(milliseconds: 1), curve: Curves.easeInOut);
    }
  }

  /// This function handles the generation of the animated bars based on the broadcasts length.
  List<Widget> getBars() {
    List bars = widget.profile.broadcasts
        .asMap()
        .map((i, e) {
          return MapEntry(
            i,
            AnimatedBar(
                animController: _animationController,
                position: i,
                currentIndex: _currentIndex),
          );
        })
        .values
        .toList();
    List<Widget> bars1 = [];
    for (Widget bar in bars) {
      bars1.add(bar);
    }
    return bars1;
  }
}

/// The type of the broadcast
enum MediaType {
  image,
  video,
}

/// The model of the broadcast widget.
class Broadcast {
  final String url;
  final MediaType mediaType;
  final Duration duration;
  //final BroadcastProfile user;

  Broadcast({
    required this.url,
    required this.mediaType,
    required this.duration,
    //required this.user,
  });
}
