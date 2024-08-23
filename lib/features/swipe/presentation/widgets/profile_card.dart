import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:metin/core/utils/adaptive_h_w.dart';
import 'package:metin/core/utils/adaptive_text.dart';
import 'package:metin/features/swipe/presentation/bloc/swipe/swipe_bloc.dart';

enum SwipeStatus { like, dislike, superLike }

class ProfileCard extends StatefulWidget {
  const ProfileCard({Key? key, required this.profile, required this.isFront})
      : super(key: key);
  final Profile profile;
  final bool isFront;

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard>
    with SingleTickerProviderStateMixin {
  int currentImageIndex = 0;
  PageController pageController = PageController();
  late final AnimationController controller;
  late final animation = Tween(begin: 0.0, end: 1.0).animate(controller);
  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;

      final swipeBloc = context.read<SwipeBloc>();
      swipeBloc.add(SwipeCardScreenSize(screenSize: size));
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.isFront ? buildFrontCard() : buildCard();
  }

  Widget buildFrontCard() {
    controller.forward();
    return GestureDetector(
      child: BlocBuilder<SwipeBloc, SwipeState>(
        builder: (context, state) {
          return LayoutBuilder(builder: (context, constraints) {
            final swipeBloc = context.read<SwipeBloc>();
            final position = swipeBloc.position;
            final duration = swipeBloc.isDragging ? 0 : 500;

            final center = constraints.smallest.center(Offset.zero);
            final angle = swipeBloc.angle * pi / 360;
            final rotatedMatrix = Matrix4.identity()
              ..translate(center.dx, center.dy)
              ..rotateZ(angle)
              ..translate(-center.dx, -center.dy);

            return AnimatedContainer(
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: duration),
              transform: rotatedMatrix..translate(position.dx, position.dy),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  buildCard(),
                  buildIcons(),
                  Positioned(
                    bottom: -20,
                    left: 0,
                    right: 0,
                    child: FadeTransition(
                      opacity: animation,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                shadowColor: MaterialStateProperty.all(
                                  Colors.black26.withOpacity(0.7),
                                ),
                                elevation: MaterialStateProperty.all(
                                  10,
                                ),
                                shape: MaterialStateProperty.all(
                                  const CircleBorder(),
                                ),
                                padding: MaterialStateProperty.all(
                                  const EdgeInsets.only(
                                    top: 25,
                                    bottom: 15,
                                    right: 15,
                                    left: 15,
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.5)), // <-- Button color
                                // overlayColor: MaterialStateProperty.all(
                                //     Colors.red.withOpacity(0.3)),
                              ),
                              child: Stack(
                                children: const [
                                  Icon(
                                    Icons.keyboard_arrow_up_outlined,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    left: 0.1,
                                    child: Icon(
                                      Icons.keyboard_arrow_up_outlined,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (widget.profile.imageAsset.length > 1)
                    Positioned(
                      top: 0,
                      bottom: 0,
                      child: SizedBox(
                        width: aWidth(80, context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (currentImageIndex > 0) {
                                    currentImageIndex--;
                                    pageController.animateToPage(
                                        currentImageIndex,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeOut);
                                  }
                                });
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (widget.profile.imageAsset.length - 1 >
                                      currentImageIndex) {
                                    currentImageIndex++;
                                    pageController.animateToPage(
                                        currentImageIndex,
                                        duration:
                                            const Duration(milliseconds: 200),
                                        curve: Curves.easeIn);
                                  }
                                });
                              },
                              icon: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            );
          });
        },
      ),
      onPanStart: (details) {
        final swipeBloc = context.read<SwipeBloc>();

        swipeBloc.add(SwipeStartPosition(startPosition: details));
      },
      onPanUpdate: (details) {
        final swipeBloc = context.read<SwipeBloc>();

        swipeBloc.add(SwipeUpdatePosition(updatePosition: details));
      },
      onPanEnd: (details) {
        final swipeBloc = context.read<SwipeBloc>();

        swipeBloc.add(const SwipeEndPosition());
      },
    );
  }

  Widget buildCard() {
    return Container(
      width: widget.isFront ? aWidth(80, context) : aWidth(70, context),
      height: aHeight(70, context),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Stack(
        children: [
          Positioned.fill(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              children: widget.profile.imageAsset
                  .map(
                    (e) => ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        e,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          if (widget.isFront)
            Positioned(
              bottom: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: FadeTransition(
                    opacity: animation,
                    child: Container(
                      height: aHeight(13, context),
                      width: aWidth(80, context),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        shadows: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: aWidth(5, context)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AText(
                              textSpaceHeight: aHeight(4.5, context),
                              text:
                                  "${widget.profile.name}, ${widget.profile.age}",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(color: Colors.white),
                            ),
                            AText(
                                textSpaceHeight: aHeight(2.5, context),
                                text: widget.profile.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          if (widget.isFront)
            Positioned(
              top: aHeight(4, context),
              left: aWidth(5, context),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: FadeTransition(
                    opacity: animation,
                    child: Container(
                      decoration: ShapeDecoration(
                        color: Colors.grey.shade200.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        shadows: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.locationDot,
                              color: Colors.grey.shade200.withOpacity(0.6),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            AText(
                              textSpaceHeight: aHeight(2.5, context),
                              text: widget.profile.city,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          if (widget.isFront && widget.profile.imageAsset.length > 1)
            Positioned(
              top: 0,
              left: aWidth(32, context),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: FadeTransition(
                    opacity: animation,
                    child: Container(
                      decoration: ShapeDecoration(
                        color: Colors.grey.shade200.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        shadows: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            widget.profile.imageAsset.length,
                            (index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2.0),
                              child: Icon(
                                FontAwesomeIcons.solidCircle,
                                size: 5,
                                color: index == currentImageIndex
                                    ? Colors.white
                                    : Colors.grey.shade200.withOpacity(0.6),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }

  Widget buildIcons() {
    final swipeBloc = context.read<SwipeBloc>();
    final status = swipeBloc.getStatus();
    final opacity = swipeBloc.getStatusOpacity();

    switch (status) {
      case SwipeStatus.like:
        final icon = buildIcon(
          FontAwesomeIcons.solidThumbsUp,
          Theme.of(context).primaryColor,
          angle: -0.2,
          opacity: opacity,
        );
        return Positioned(top: 200, left: 50, child: icon);

      case SwipeStatus.dislike:
        final icon = buildIcon(
          FontAwesomeIcons.solidThumbsDown,
          Colors.red,
          angle: 0.2,
          opacity: opacity,
        );
        return Positioned(top: 200, right: 50, child: icon);

      case SwipeStatus.superLike:
        final icon = buildIcon(
          FontAwesomeIcons.solidStar,
          Colors.yellow,
          opacity: opacity,
        );
        return Positioned(top: 300, right: 0, left: 0, child: icon);

      default:
        return const SizedBox();
    }
  }

  Widget buildIcon(IconData icon, Color color,
      {double angle = 0, required double opacity}) {
    return Opacity(
      opacity: opacity,
      child: Transform.rotate(
        angle: angle,
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 50,
          child: Icon(
            icon,
            size: 50,
            color: color,
          ),
        ),
      ),
    );
  }
}

class Profile {
  const Profile({
    required this.name,
    required this.age,
    required this.title,
    required this.city,
    required this.imageAsset,
  });
  final String name;
  final int age;
  final String city;
  final String title;
  final List<String> imageAsset;
}
