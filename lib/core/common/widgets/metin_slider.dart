import 'package:flutter/material.dart';
import 'package:metin/core/utils/adaptive_h_w.dart';

/// Creates a Slider with with the app design to use on desired pages.
/// This Slider uses 2 functions getStops() and changeTextColor(), this functions
/// collaborate and allow the text in on top of the slider the change color depending on
/// the slider status, it starts by calculating the stops(the slider values) where the text color will change
/// and pass those stops to the change color function that will handle changing the text color.
class MetinSlider extends StatefulWidget {
  const MetinSlider({
    Key? key,
    required this.leadingText,
    required this.minValue,
    required this.maxValue,
    required this.defaultValue,
    required this.horizontalPaddingOfTrack,
    this.unit = "",
    this.spacingString = "             ",
    this.onChanged,
  }) : super(key: key);

  /// The text on the left of the slider
  final String leadingText;

  /// The unit of the value
  final String unit;

  /// The string which will allow us to calculate the distance from
  /// the start of the slider to the start of the Strings
  final String spacingString;

  /// The slider's min value
  final int minValue;

  /// The slider's max value
  final int maxValue;

  /// The sliders starting value
  final int defaultValue;

  /// The space around the slider horizontally
  final double horizontalPaddingOfTrack;

  /// What happens when the slider value changes
  final void Function(int)? onChanged;

  @override
  State<MetinSlider> createState() => _MetinSliderState();
}

class _MetinSliderState extends State<MetinSlider> {
  Color primaryColor = const Color(0xff2683E0);
  double horizontalPaddingOfTrack = 0;
  String spacingString = "";

  int variable = 0;
  int theTrackValCount = 0;

  /// The left String
  Row variableText = Row();

  /// The right string
  Row variableStatText = Row();

  /// The list of the stops where the color will change in the slider
  /// for the left String
  late final List<double> lStops;

  /// The list of the stops where the color will change in the slider
  /// for the right String
  late List<double> sStops;

  @override
  void initState() {
    horizontalPaddingOfTrack = widget.horizontalPaddingOfTrack;
    theTrackValCount = widget.maxValue - widget.minValue;
    spacingString = widget.spacingString;
    variable = widget.defaultValue;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    lStops = getStops(
      context,
      text: widget.leadingText,
      variable: variable,
      trackValCount: theTrackValCount,
      trackMinValue: widget.minValue,
    );
    sStops = getStops(
      context,
      text: "$variable ${widget.unit}",
      variable: variable,
      trackValCount: theTrackValCount,
      trackMinValue: widget.minValue,
      isLeading: false,
    );
    variableText = changeTextColor(lStops, widget.leadingText);
    variableStatText = changeTextColor(sStops, "$variable ${widget.unit}");
    super.didChangeDependencies();
  }

  /// Returns a list of calculated stops
  List<double> getStops(
    BuildContext context, {
    required String text,
    required int variable,
    required int trackValCount,
    required int trackMinValue,
    String spacingString = "             ",
    bool isLeading = true,
  }) {
    TextStyle? textStyle = Theme.of(context).textTheme.button;
    int textLength = text.length;
    List<double> stops = [];
    double trackSize = aWidth(100, context) - horizontalPaddingOfTrack;
    double step = 0;
    double navStep = (trackSize / trackValCount);

    /// Returns the size of the string in pixels
    Size textSize(String text) {
      // Calculate the text with
      final TextPainter textPainter = TextPainter(
          text: TextSpan(text: text, style: textStyle),
          maxLines: 1,
          textDirection: TextDirection.ltr)
        ..layout(minWidth: 0, maxWidth: double.infinity);

      return textPainter.size;
    }

    /// Calculates the first step of steps depending of the position of the string
    if (isLeading) {
      step = ((((textSize(spacingString).width * 100) / trackSize) *
                  trackValCount) /
              100) +
          trackMinValue +
          1;
    } else {
      step = (trackValCount -
              ((((textSize(spacingString).width * 100) / trackSize) *
                      trackValCount) /
                  100)) +
          trackMinValue;
    }

    if (isLeading) {
      // If the text in the left
      for (int i = 0; i < textLength; i++) {
        stops.add(step);
        step += (textSize(text[i]) / navStep).width.ceilToDouble().toInt();
      }
    } else {
      for (int i = 0; i < textLength; i++) {
        step -= (textSize(text[i]) / navStep).width;
        stops.add(step);
      }
    }
    if (!isLeading) {
      // If the text in the right
      stops = stops.reversed.toList();
    }

    return stops;
  }

  /// Returns the text with the color state based on the stops
  Row changeTextColor(List<double> stops, String text) {
    List<Text> result = [];

    for (var letter in text.split("")) {
      result.add(Text(
        letter,
        style: Theme.of(context).textTheme.button!.copyWith(
              color: variable >= stops[text.indexOf(letter)]
                  ? Colors.white
                  : primaryColor,
            ),
      ));
    }
    return Row(
      children: result,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.grey.shade200,
          ),
        ),
        child: Stack(
          children: [
            SliderTheme(
              data: SliderThemeData(
                overlayShape: SliderComponentShape.noOverlay,
                trackHeight: aHeight(9, context),
                thumbShape:
                    const RoundSliderThumbShape(enabledThumbRadius: 0.0),
                trackShape: const MetinRoundedRectSliderTrackShape(),
                inactiveTrackColor: Colors.white,
              ),
              child: Slider(
                value: variable.toDouble(),
                min: widget.minValue.toDouble(),
                max: widget.maxValue.toDouble(),
                onChanged: (newValue) {
                  setState(() {
                    variable = newValue.ceilToDouble().toInt();
                    //changeDistanceTextColor(newDistance.ceilToDouble());
                    variableText = changeTextColor(lStops, widget.leadingText);
                    sStops = getStops(
                      context,
                      text: "$variable ${widget.unit}",
                      variable: variable,
                      trackValCount: theTrackValCount,
                      trackMinValue: widget.minValue,
                      isLeading: false,
                    );
                    variableStatText =
                        changeTextColor(sStops, "$variable ${widget.unit}");
                  });
                  widget.onChanged!(newValue.toInt());
                },
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              bottom: 0,
              child: IgnorePointer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          spacingString,
                        ),
                        variableText,
                      ],
                    ),
                    Row(
                      children: [
                        variableStatText,
                        Text(
                          spacingString,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The Slider Shape properties
class MetinRoundedRectSliderTrackShape extends SliderTrackShape
    with BaseSliderTrackShape {
  /// Create a slider track that draws two rectangles with rounded outer edges.
  const MetinRoundedRectSliderTrackShape();

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    bool isDiscrete = false,
    bool isEnabled = false,
    double additionalActiveTrackHeight = 2,
  }) {
    assert(sliderTheme.disabledActiveTrackColor != null);
    assert(sliderTheme.disabledInactiveTrackColor != null);
    assert(sliderTheme.activeTrackColor != null);
    assert(sliderTheme.inactiveTrackColor != null);
    assert(sliderTheme.thumbShape != null);
    // If the slider [SliderThemeData.trackHeight] is less than or equal to 0,
    // then it makes no difference whether the track is painted or not,
    // therefore the painting  can be a no-op.
    if (sliderTheme.trackHeight == null || sliderTheme.trackHeight! <= 0) {
      return;
    }

    // Assign the track segment paints, which are leading: active and
    // trailing: inactive.
    final ColorTween activeTrackColorTween = ColorTween(
        begin: sliderTheme.disabledActiveTrackColor,
        end: sliderTheme.activeTrackColor);
    final ColorTween inactiveTrackColorTween = ColorTween(
        begin: sliderTheme.disabledInactiveTrackColor,
        end: sliderTheme.inactiveTrackColor);
    final Paint activePaint = Paint()
      ..color = activeTrackColorTween.evaluate(enableAnimation)!;
    final Paint inactivePaint = Paint()
      ..color = inactiveTrackColorTween.evaluate(enableAnimation)!;
    final Paint leftTrackPaint;
    final Paint rightTrackPaint;
    switch (textDirection) {
      case TextDirection.ltr:
        leftTrackPaint = activePaint;
        rightTrackPaint = inactivePaint;
        break;
      case TextDirection.rtl:
        leftTrackPaint = inactivePaint;
        rightTrackPaint = activePaint;
        break;
    }

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );
    final Radius trackRadius = Radius.circular(trackRect.height / 4);
    final Radius activeTrackRadius =
        Radius.circular((trackRect.height + additionalActiveTrackHeight) / 4);

    context.canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        trackRect.left,
        (textDirection == TextDirection.ltr)
            ? trackRect.top - (additionalActiveTrackHeight / 2)
            : trackRect.top,
        thumbCenter.dx,
        (textDirection == TextDirection.ltr)
            ? trackRect.bottom + (additionalActiveTrackHeight / 2)
            : trackRect.bottom,
        topLeft: (textDirection == TextDirection.ltr)
            ? activeTrackRadius
            : trackRadius,
        bottomLeft: (textDirection == TextDirection.ltr)
            ? activeTrackRadius
            : trackRadius,
        topRight: (textDirection == TextDirection.ltr)
            ? activeTrackRadius
            : trackRadius,
        bottomRight: (textDirection == TextDirection.ltr)
            ? activeTrackRadius
            : trackRadius,
      ),
      leftTrackPaint,
    );
    context.canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        thumbCenter.dx,
        (textDirection == TextDirection.rtl)
            ? trackRect.top - (additionalActiveTrackHeight / 2)
            : trackRect.top,
        trackRect.right,
        (textDirection == TextDirection.rtl)
            ? trackRect.bottom + (additionalActiveTrackHeight / 2)
            : trackRect.bottom,
        topRight: (textDirection == TextDirection.rtl)
            ? activeTrackRadius
            : trackRadius,
        bottomRight: (textDirection == TextDirection.rtl)
            ? activeTrackRadius
            : trackRadius,
      ),
      rightTrackPaint,
    );
  }
}
