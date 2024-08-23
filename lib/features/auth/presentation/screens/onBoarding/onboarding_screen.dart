import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:metin/core/common/widgets/metin_button.dart';
import 'package:metin/core/constants.dart';
import 'package:metin/core/utils/adaptive_h_w.dart';
import 'package:metin/core/utils/adaptive_text.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  /// What page the user is seeing
  int activePage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CarouselSlider(
              items: onBoardingPages.map(
                (e) {
                  return Builder(
                    builder: (BuildContext context) {
                      return SingleChildScrollView(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: Image(
                            image: AssetImage(e[0]),
                            fit: BoxFit.fitHeight,
                            // lerping the double to add the effect of growing down/up
                            height: activePage == onBoardingPages.indexOf(e)
                                ? lerpDouble(aHeight(55, context),
                                    aHeight(50, context), 0.65)
                                : lerpDouble(aHeight(45, context),
                                    aHeight(55, context), 0.65),
                          ),
                        ),
                      );
                    },
                  );
                },
              ).toList(),
              options: CarouselOptions(
                  enlargeStrategy: CenterPageEnlargeStrategy.scale,
                  viewportFraction: 0.7,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 5),
                  onPageChanged: (index, reason) {
                    setState(() {
                      activePage = index;
                    });
                  },
                  height: aHeight(60, context)),
            ),
            AText(
              textSpaceHeight: aHeight(4.5, context),
              text: onBoardingPages[activePage][1],
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: Colors.blue, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: AText(
                text: onBoardingPages[activePage][2],
                style: Theme.of(context).textTheme.bodyText2,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: aHeight(0.15, context)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: indicators(onBoardingPages.length, activePage),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: MetinButton(
                color: Theme.of(context).primaryColor,
                text: "Get Started !",
                textStyle: Theme.of(context)
                    .textTheme
                    .button!
                    .copyWith(color: Colors.white),
                isBorder: false,
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: const EdgeInsets.all(3),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: currentIndex == index
                ? Theme.of(context).primaryColor
                : const Color(0xffe5e5e6),
            shape: BoxShape.circle),
      );
    });
  }
}
