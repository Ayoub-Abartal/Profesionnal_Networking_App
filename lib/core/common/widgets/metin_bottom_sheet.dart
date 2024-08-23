import 'package:flutter/material.dart';
import 'package:metin/core/utils/adaptive_h_w.dart';

import 'get_child_widget_size.dart';

/// This class creates a smooth, animated, lag free, dynamically resizable bottom sheet
/// depending on it's child size.
class MetinBottomSheetPage extends StatefulWidget {
  const MetinBottomSheetPage({
    Key? key,
    this.height,
    required this.child,
  }) : super(key: key);
  final double? height;
  final Widget child;

  @override
  State<MetinBottomSheetPage> createState() => _MetinBottomSheetPageState();
}

class _MetinBottomSheetPageState extends State<MetinBottomSheetPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final animation = Tween(begin: 0.0, end: 0.8).animate(controller);
  final DraggableScrollableController _draggableScrollableController =
      DraggableScrollableController();

  /// is the user completed working with the bottom sheet
  bool isPopped = false;

  /// The size of the sheet
  Size widSize = Size.zero;

  /// the height that we want to adapt the sheet to
  double desiredHeight = 0;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    super.initState();
    onPageIn();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  /// Start the grey background focus animation on page load
  Future<void> onPageIn() async {
    await Future.delayed(const Duration(milliseconds: 250));
    controller.forward();
  }

  /// Reverse the grey background focus animation on page pop
  Future<void> onPageOut() async {
    controller.duration = const Duration(milliseconds: 70);
    controller.reverse();
  }

  /// This listens to the scrolling changes and dismisses the sheet when dragged down
  _scrollListener() {
    if (_draggableScrollableController.size <= 0.55 && !isPopped) {
      onPageOut();
      Navigator.pop(context);
      setState(() {
        isPopped = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              if (MediaQuery.of(context).viewInsets.bottom == 0) {
                onPageOut();
                Navigator.pop(context);
              }
            },
            child: FadeTransition(
              opacity: animation,
              child: Container(
                height: aHeight(100, context),
                width: aWidth(100, context),
                color: Colors.black.withOpacity(0.8),
              ),
            ),
          ),
          Stack(
            children: [
              DraggableScrollableSheet(
                minChildSize: 0.5,
                maxChildSize:
                    desiredHeight <= 0.5 ? 0.6 : desiredHeight + 0.025,
                initialChildSize:
                    desiredHeight <= 0.5 ? 0.6 : desiredHeight + 0.02,
                controller: _draggableScrollableController,
                builder: (context, scrollController) {
                  return SingleChildScrollView(
                    clipBehavior: Clip.none,
                    controller: scrollController..addListener(_scrollListener),
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 30,
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: ChildWidgetSize(
                                onChange: (e) {
                                  setState(() {
                                    widSize = e;
                                    desiredHeight = (((widSize.height * 100) /
                                            aHeight(100, context)) /
                                        100);
                                  });
                                },
                                child: Container(
                                  // Here is the height of the components in sheet
                                  height: widget.height,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20)),
                                      color: Colors.white),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child: widget.child,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Align(
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: SizedBox(
                                          width: aWidth(100, context),
                                          child: Image.asset(
                                            "assets/images/topDent.png",
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        right: 0,
                                        child: SizedBox(
                                          height: aHeight(2.2, context),
                                          child: Image.asset(
                                              "assets/images/indicator.png"),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}

/// This class handles the routing and creating the page transition to the bottom sheet
class MetinBottomSheet extends PageRouteBuilder {
  final Widget content;
  MetinBottomSheet({
    required this.content,
  }) : super(
          opaque: false,
          pageBuilder: (context, animation, anotherAnimation) =>
              MetinBottomSheetPage(
            child: content,
          ),
          transitionDuration: const Duration(seconds: 1),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                parent: animation,
                curve: Curves.fastLinearToSlowEaseIn,
                reverseCurve: Curves.fastOutSlowIn);
            return ScaleTransition(
              scale: animation,
              alignment: Alignment.bottomCenter,
              child: child,
            );
          },
        );
}
