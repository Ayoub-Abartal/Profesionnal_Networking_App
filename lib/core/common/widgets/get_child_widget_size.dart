import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// This widget has a callback that returns the child widget's size even
/// if it is changing ex: animation
class ChildWidgetSize extends StatefulWidget {
  final Widget child;
  final Function onChange;

  const ChildWidgetSize({
    Key? key,
    required this.child,
    required this.onChange,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ChildWidgetSizeState();
  }
}

class _ChildWidgetSizeState extends State<ChildWidgetSize> {
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);
    return Container(
      key: widgetKey,
      child: widget.child,
    );
  }

  GlobalKey widgetKey = GlobalKey();
  Size? oldSize;

  void postFrameCallback(_) {
    var context = widgetKey.currentContext;
    if (context == null) return;

    var newSize = context.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    widget.onChange(newSize);
  }
}
