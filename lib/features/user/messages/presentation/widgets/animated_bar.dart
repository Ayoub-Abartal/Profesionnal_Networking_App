import 'package:flutter/material.dart';

/// This class creates the white bar on top of the broadcast. It's animation is
/// the fill animation depending on the story duration.
class AnimatedBar extends StatelessWidget {
  /// The animation controller.
  final AnimationController animController;

  /// The position of the bar in the other bars.
  final int position;

  /// The current animated bar.
  final int currentIndex;

  const AnimatedBar({
    Key? key,
    required this.animController,
    required this.position,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1.5),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              _buildContainer(
                double.infinity,
                position < currentIndex
                    ? Theme.of(context).primaryColor
                    : Colors.white,
              ),
              position == currentIndex
                  ? AnimatedBuilder(
                      animation: animController,
                      builder: (context, child) {
                        return _buildContainer(
                          constraints.maxWidth * animController.value,
                          Theme.of(context).primaryColor,
                        );
                      },
                    )
                  : const SizedBox.shrink()
            ],
          );
        },
      ),
    ));
  }

  /// Returns a container with the shape of the desired slim bar.
  Container _buildContainer(double width, Color color) {
    return Container(
      height: 2.0,
      width: width,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.black26, width: 0.8),
        borderRadius: BorderRadius.circular(2.0),
      ),
    );
  }
}
