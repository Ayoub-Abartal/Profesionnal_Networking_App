import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:metin/core/common/widgets/metin_button.dart';
import 'package:metin/core/common/widgets/metin_text_field.dart';
import 'package:metin/core/utils/adaptive_h_w.dart';
import 'package:metin/core/utils/adaptive_text.dart';
import 'package:metin/features/swipe/presentation/widgets/matching_image.dart';

class MatchingScreen extends StatefulWidget {
  const MatchingScreen({Key? key}) : super(key: key);

  @override
  State<MatchingScreen> createState() => _MatchingScreenState();
}

class _MatchingScreenState extends State<MatchingScreen> {
  double leftImageOffset = 400;
  double rightImageOffset = 300;
  double handShakeScale = 10;
  double hanShakeOpacity = 0;

  Future<void> animateTransition() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      leftImageOffset = 130;
    });
    await Future.delayed(const Duration(milliseconds: 1200));
    setState(() {
      rightImageOffset = 0;
    });
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      hanShakeOpacity = 1;
      handShakeScale = 1;
    });
  }

  @override
  void initState() {
    super.initState();
    animateTransition();
  }

  @override
  Widget build(BuildContext context) {
    //180 , 280
    Size imageSize = Size(aWidth(45, context), aHeight(35, context));
    TextTheme textTheme = Theme.of(context).textTheme;
    Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                right: aWidth(4, context),
                left: aWidth(4, context),
                top: aHeight(8, context)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: aWidth(35, context),
                    ),
                    SizedBox(
                      height: aHeight(35, context),
                      width: aWidth(50, context),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          AnimatedPositioned(
                            left: rightImageOffset,
                            curve: Curves.bounceOut,
                            duration: const Duration(milliseconds: 800),
                            child: MatchingImage(
                              angle: pi / 15,
                              imageSize: imageSize,
                              imageLink: "assets/images/onBoarding/3.png",
                            ),
                          ),
                          AnimatedPositioned(
                            curve: Curves.bounceOut,
                            duration: const Duration(milliseconds: 800),
                            top: aHeight(12, context),
                            right: leftImageOffset,
                            child: MatchingImage(
                                angle: -pi / 15,
                                imageSize: imageSize,
                                imageLink: "assets/images/onBoarding/1.png"),
                          ),
                          Positioned(
                            bottom: 0,
                            top: aHeight(14, context),
                            left: aWidth(5, context),
                            child: AnimatedOpacity(
                              opacity: hanShakeOpacity,
                              duration: const Duration(milliseconds: 0),
                              child: AnimatedScale(
                                curve: Curves.bounceOut,
                                scale: handShakeScale,
                                duration: const Duration(milliseconds: 500),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.8),
                                        spreadRadius: 0,
                                        blurRadius: 13,
                                        offset: const Offset(0,
                                            15), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: CircleAvatar(
                                    radius: 35,
                                    backgroundColor: Colors.white,
                                    child: Transform.rotate(
                                      angle: -pi / 10,
                                      child: const Icon(
                                        FontAwesomeIcons.solidHandshake,
                                        size: 35,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: aHeight(15, context),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: aHeight(5, context)),
                  child: Column(
                    children: [
                      AText(
                        textSpaceHeight: aHeight(4, context),
                        text: "It's a match, Let's collaborate",
                        style:
                            textTheme.bodyText1!.copyWith(color: primaryColor),
                      ),
                      AText(
                        textSpaceHeight: aHeight(2.5, context),
                        text: "Start a conversation now with each other",
                        style: textTheme.bodyText2,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: aWidth(1.8, context)),
                  child: SizedBox(
                    height: aHeight(8, context),
                    child: MetinTextField(
                      hintText: "Hi, Mark i'm interested in your project",
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          FontAwesomeIcons.paperPlane,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: aHeight(2, context)),
                  child: MetinButton(
                    horizontalPadding: 0,
                    text: "Keep swiping",
                    isBorder: false,
                    onPressed: () {},
                    color: const Color(0xffeaf4fd),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
