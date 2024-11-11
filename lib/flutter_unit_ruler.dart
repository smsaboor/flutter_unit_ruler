// Copyright [YEAR] [COPYRIGHT HOLDER]
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'package:flutter_unit_ruler/scale_controller.dart';
import 'package:flutter_unit_ruler/scale_interval.dart';
import 'package:flutter_unit_ruler/scale_line.dart';
import 'package:flutter_unit_ruler/triangle_painter.dart';
import 'package:flutter_unit_ruler/scale_unit.dart';

/// A callback function signature used for notifying when a ruler value has changed.
typedef ValueChangedCallback = void Function(num value);

/// A class representing the UnitRuler, a digital tool for measuring various units like weight and length.
class UnitRuler extends StatefulWidget {
  /// A callback function that is triggered when the value changes.
  final ValueChangedCallback onValueChanged;

  /// A function that provides the text to display for a unit interval.
  ///
  /// The function takes two parameters:
  /// - [index]: the index of the unit interval.
  /// - [rulerScaleValue]: the value of the scale at that interval.
  /// It returns a [String] that will be displayed as the text for that unit interval.
  final String Function(int index, num rulerScaleValue) scaleIntervalText;

  /// The width of the ruler widget.
  ///
  /// This defines how wide the ruler should be, typically used for controlling the overall layout and appearance.
  final double width;

  /// The height of the ruler widget.
  ///
  /// This defines how tall the ruler should be, allowing you to control the ruler's layout along with the width.
  final double height;

  /// The scroll direction of the ruler.
  ///
  /// Specifies whether the ruler scrolls vertically or horizontally. This can be set to either [Axis.horizontal] or [Axis.vertical].

  final Axis scrollDirection;

  /// The text style applied to the unit interval text.
  ///
  /// This defines how the unit interval labels (e.g., "kg", "cm") will appear, including properties like font size, weight, and color.
  final TextStyle scaleIntervalTextStyle;

  /// A list of styles that determine how each unit interval is rendered.
  ///
  /// Each entry in the list represents a different style for a unit interval. This allows customization of appearance, such as color or font size, for each unit.
  final List<ScaleIntervalStyle> scaleIntervalStyles;

  /// A widget that represents the marker displayed on the ruler.
  ///
  /// This widget could be a custom graphic or indicator to mark specific points on the ruler. If `null`, no marker is displayed.
  final Widget? scaleMarker;

  /// The margin around the ruler, providing space between the ruler and its surrounding widgets.
  ///
  /// This allows you to control the distance between the ruler and other elements in the layout.
  final double scaleMargin;

  /// The background color of the UnitRuler widget.
  /// Used to customize the ruler's background.
  final Color backgroundColor;

  /// The controller used to manage the ruler's state and interactions.
  final ScaleController? controller;

  /// The name of the unit being measured.
  ///
  /// This defines the unit of measurement (e.g., "kg", "cm", "pound") that is displayed on the ruler.
  /// The type `UnitName` could be an enum or a class that specifies various unit types.
  final ScaleUnit scaleUnit;

  /// The vertical position of the ruler marker.
  ///
  /// This defines the distance from the top of the ruler to the position of the marker. It is a value that
  /// controls where the marker will be placed vertically along the ruler.
  final double scaleMarkerPositionTop;

  /// The horizontal position of the ruler marker.
  ///
  /// This defines the distance from the left edge of the ruler to the position of the marker. It controls
  /// where the marker will be placed horizontally along the ruler.
  final double scaleMarkerPositionLeft;

  /// The alignment of the ruler.
  ///
  /// This controls how the ruler's content is aligned within the available space. It can be used to control
  /// the alignment of both the ruler and its markers (e.g., [Alignment.center], [Alignment.topLeft]).
  final Alignment scaleAlignment;

  /// The position of the unit interval text.
  ///
  /// This defines the vertical position where the unit interval text (e.g., "kg", "cm") will be placed along
  /// the ruler. It helps position the text relative to the ruler markers or other elements.
  final double scaleIntervalTextPosition;

  /// Padding for the ruler widget.
  ///
  /// This provides padding around the ruler, adding space between the ruler and any other surrounding widgets.
  /// It uses [EdgeInsetsGeometry] to allow for different padding values on each side.
  final EdgeInsetsGeometry? scalePadding;

  /// Creates an instance of the UnitRuler.
  /// This constructor initializes the ruler with default settings.
  const UnitRuler({
    super.key,
    required this.onValueChanged,
    required this.width,
    required this.scaleUnit,
    required this.scalePadding,
    required this.scaleAlignment,
    required this.scrollDirection,
    required this.scaleMarkerPositionTop,
    required this.scaleMarkerPositionLeft,
    required this.height,
    required this.scaleIntervalText,
    required this.scaleIntervalTextPosition,
    this.scaleMargin = 0,
    this.scaleIntervalStyles = const [
      ScaleIntervalStyle(
          scale: 0,
          color: Color.fromARGB(255, 188, 194, 203),
          width: 2,
          height: 32),
      ScaleIntervalStyle(
          color: Color.fromARGB(255, 188, 194, 203), width: 1, height: 20),
    ],
    this.scaleIntervalTextStyle = const TextStyle(
      color: Color.fromARGB(255, 188, 194, 203),
      fontSize: 14,
    ),
    this.scaleMarker,
    this.backgroundColor = Colors.white,
    this.controller,
  });

  @override
  State<StatefulWidget> createState() {
    return UnitRulerState();
  }
}

/// The state class for [UnitRuler], responsible for managing its dynamic behavior and UI.
class UnitRulerState extends State<UnitRuler> {
  /// The last scroll offset position.
  ///
  /// This value stores the previous scroll position of the ruler, which can be used to detect changes in
  /// the scroll state and for smoother transitions when the ruler is scrolled.
  double lastOffset = 0;

  /// Flag indicating whether the position of the ruler is fixed.
  ///
  /// This boolean value tracks whether the ruler's position is fixed (i.e., not scrollable). It can be used
  /// to determine if the ruler should respond to user gestures, such as scrolling or dragging.
  bool isPosFixed = false;

  /// The current value displayed on the ruler.
  ///
  /// This string stores the value shown by the ruler at any given moment. It can represent measurements like
  /// weight, length, or other units and may change dynamically as the user interacts with the ruler.
  String value = '';

  /// The scroll controller for managing scroll events of the ruler.
  ///
  /// [scrollController] is used to control and listen to scroll events for the ruler widget. It can be used
  /// to synchronize the ruler's movement with the scroll view and trigger updates when the user scrolls.
  late ScrollController scrollController;

  /// The number of items (unit intervals) on the ruler.
  ///
  /// This value represents the total number of unit intervals (e.g., "kg", "cm", etc.) displayed on the ruler.
  /// It is useful for determining how many intervals should be drawn and for layout calculations.
  int itemCount = 0;

  final Map<int, ScaleIntervalStyle> _scaleLineStyleMap = {};

  @override
  void initState() {
    super.initState();

    itemCount = _calculateItemCount();

    for (var element in widget.scaleIntervalStyles) {
      _scaleLineStyleMap[element.scale] = element;
    }

    double initValueOffset = getPositionByValue(widget.controller?.value ?? 0);

    scrollController = ScrollController(
        initialScrollOffset: initValueOffset > 0 ? initValueOffset : 0);

    scrollController.addListener(_onValueChanged);

    widget.controller?.addListener(() {
      setPositionByValue(widget.controller?.value ?? 0);
    });
  }

  int _calculateItemCount() {
    int itemCount = 0;
    for (var element in widget.scaleUnit.scaleIntervals) {
      itemCount += ((element.end - element.begin) / element.scale).truncate();
    }
    itemCount += 1;
    return itemCount;
  }

  void _onValueChanged() {
    int currentIndex = scrollController.offset ~/ _ruleScaleInterval.toInt();

    if (currentIndex < 0) currentIndex = 0;
    num currentValue = getRulerScaleValue(currentIndex);

    var lastConfig = widget.scaleUnit.scaleIntervals.last;
    if (currentValue > lastConfig.end) currentValue = lastConfig.end;

    widget.onValueChanged(currentValue);
  }

  /// default mark
  Widget _buildMark() {
    /// default mark arrow
    Widget triangle() {
      return SizedBox(
        width: 15,
        height: 15,
        child: CustomPaint(
          painter: TrianglePainter(),
        ),
      );
    }

    return SizedBox(
      width: _ruleScaleInterval * 2,
      height: 45,
      child: Stack(
        children: <Widget>[
          Align(alignment: Alignment.topCenter, child: triangle()),
          Align(
              child: Container(
            width: 3,
            height: 34,
            color: const Color.fromARGB(255, 118, 165, 248),
          )),
        ],
      ),
    );
  }

  ///绘制刻度线
  Widget _buildRulerScaleLine(int index) {
    double width = 0;
    double height = 0;
    Color color = const Color.fromARGB(255, 188, 194, 203);
    int scale = index %
        widget.scaleUnit
            .subDivisionCount; // give 12 bcz want to give for feet which has 12 inches

    if (_scaleLineStyleMap[scale] != null) {
      width = _scaleLineStyleMap[scale]!.width;
      height = _scaleLineStyleMap[scale]!.height;
      color = _scaleLineStyleMap[scale]!.color;
    } else {
      if (_scaleLineStyleMap[-1] != null) {
        scale = -1;
        width = _scaleLineStyleMap[scale]!.width;
        height = _scaleLineStyleMap[scale]!.height;
        color = _scaleLineStyleMap[scale]!.color;
      } else {
        if (scale == 0) {
          width = widget.scrollDirection == Axis.horizontal
              ? 2
              : 32; // 32 if vertical ruler else 2
          height = widget.scrollDirection == Axis.horizontal
              ? 32
              : 2; // 2 if vertical ruler else 32
        } else {
          width = widget.scrollDirection == Axis.horizontal
              ? 1
              : 20; // 20 if vertical ruler else 1
          height = widget.scrollDirection == Axis.horizontal
              ? 20
              : 1; // 1 if vertical ruler else 20
        }
      }
    }

    return Container(
      width: width,
      height: height,
      color: color,
    );
  }

  Widget _buildRulerScale(BuildContext context, int index) {
    return SizedBox(
      width: _ruleScaleInterval,
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          // Positioned(
          //     top: widget.scrollDirection == Axis.vertical ? widget.rulerMarkerPosition : 0,
          //     left: widget.scrollDirection == Axis.vertical ? 0 : widget.rulerMarkerPosition,
          //     child: _buildRulerScaleLine(index)),
          Align(
              alignment: widget.scaleAlignment,
              // alignment: widget.rulerAlignment ?? (widget.scrollDirection == Axis.horizontal
              //         ? Alignment.topCenter
              //         : Alignment.bottomLeft),
              child: _buildRulerScaleLine(index)),
          Positioned(
            bottom: widget.scrollDirection == Axis.horizontal
                ? widget.scaleIntervalTextPosition
                : 0,
            left: widget.scrollDirection == Axis.horizontal
                ? -50 + _ruleScaleInterval / 2
                : widget.scaleIntervalTextPosition + _ruleScaleInterval / .2,
            width: widget.scrollDirection == Axis.horizontal ? 100 : 40,
            child: index % widget.scaleUnit.subDivisionCount ==
                    0 // give 12 bcz for inches
                ? Container(
                    alignment: Alignment.center,
                    child: Text(
                      widget.scaleIntervalText(index, getRulerScaleValue(index)),
                      style: widget.scaleIntervalTextStyle,
                    ),
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }

  final double _ruleScaleInterval = 10;

  /// Fixes the scroll offset position.
  ///
  /// This method adjusts or fixes the scroll offset of the ruler based on certain conditions. It may be used
  /// when the ruler's position needs to be locked or adjusted to a specific point, for example, when a value
  /// or scale is selected.
  void fixOffset() {
    int tempFixedOffset = (scrollController.offset + 0.5) ~/ 1;

    double fixedOffset = (tempFixedOffset + _ruleScaleInterval / 2) ~/
        _ruleScaleInterval.toInt() *
        _ruleScaleInterval;
    Future.delayed(Duration.zero, () {
      scrollController.animateTo(fixedOffset,
          duration: const Duration(milliseconds: 50),
          curve: Curves.bounceInOut);
    });
  }

  /// Returns the ruler scale value for a given index.
  ///
  /// This method calculates and returns the value of the ruler at a specific index. The index typically
  /// corresponds to the position of the ruler scale, and the value is a numeric representation of the unit
  /// measurement at that index.
  num getRulerScaleValue(int index) {
    num rulerScaleValue = 0;
    ScaleIntervals? currentConfig;
    for (ScaleIntervals config in widget.scaleUnit.scaleIntervals) {
      currentConfig = config;
      if (currentConfig == widget.scaleUnit.scaleIntervals.last) {
        break;
      }
      var totalCount = ((config.end - config.begin) / config.scale).truncate();
      if (index <= totalCount) {
        break;
      } else {
        index -= totalCount;
      }
    }

    rulerScaleValue = index * currentConfig!.scale + currentConfig.begin;

    return rulerScaleValue;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width +
          (widget.scrollDirection == Axis.vertical ? 0 : widget.scaleMargin),
      height: widget.height +
          (widget.scrollDirection == Axis.vertical ? widget.scaleMargin : 0),
      child: Stack(
        children: <Widget>[
          Listener(
            onPointerDown: (event) {
              FocusScope.of(context).requestFocus(FocusNode());
              isPosFixed = false;
            },
            onPointerUp: (event) {},
            child: NotificationListener(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollStartNotification) {
                  } else if (scrollNotification is ScrollUpdateNotification) {
                  } else if (scrollNotification is ScrollEndNotification) {
                    if (!isPosFixed) {
                      isPosFixed = true;
                      fixOffset();
                    }
                  }
                  return true;
                },
                child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: widget.backgroundColor,
                    child: ListView.builder(
                      // padding: EdgeInsets.only(
                      //   left: (widget.width - _ruleScaleInterval) / (widget.scrollDirection == Axis.horizontal ? 2.32 : 3 ),
                      //   right: (widget.width - _ruleScaleInterval) / (widget.scrollDirection == Axis.horizontal ? 2 : 4 ),
                      //   top: widget.scrollDirection == Axis.horizontal ? 0 : (widget.width - _ruleScaleInterval) / 1.85, // comment it if want horizontal ruler
                      // ),
                      padding: widget.scalePadding,
                      itemExtent: _ruleScaleInterval,
                      itemCount: itemCount,
                      controller: scrollController,
                      scrollDirection: widget.scrollDirection,
                      itemBuilder: _buildRulerScale,
                    ))),
          ),
          Positioned(
              top: widget.scaleMarkerPositionTop,
              left: widget.scaleMarkerPositionLeft,
              child: widget.scaleMarker ?? _buildMark())
          // Align(
          //   alignment: widget.scrollDirection == Axis.horizontal ? Alignment.topCenter : Alignment.center,
          //   child: widget.rulerMarker ?? _buildMark(),
          // ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  void didUpdateWidget(UnitRuler oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (mounted) {
      if (isRangesChanged(oldWidget)) {
        Future.delayed(Duration.zero, () {
          setState(() {
            itemCount = _calculateItemCount();
          });
          _onValueChanged();
        });
      }
    }
  }

  /// Checks if the ranges of the UnitRuler have changed compared to the old widget.
  ///
  /// This method compares the current configuration of the ruler with the previous configuration
  /// (provided via `oldWidget`). It returns true if the ranges (e.g., the unit intervals or scale) have
  /// changed, indicating that the widget needs to be rebuilt or updated.
  bool isRangesChanged(UnitRuler oldWidget) {
    if (oldWidget.scaleUnit.scaleIntervals.length !=
        widget.scaleUnit.scaleIntervals.length) {
      return true;
    }

    if (widget.scaleUnit.scaleIntervals.isEmpty) return false;
    for (int i = 0; i < widget.scaleUnit.scaleIntervals.length; i++) {
      ScaleIntervals oldRange = oldWidget.scaleUnit.scaleIntervals[i];
      ScaleIntervals range = widget.scaleUnit.scaleIntervals[i];
      if (oldRange.begin != range.begin ||
          oldRange.end != range.end ||
          oldRange.scale != range.scale) {
        return true;
      }
    }
    return false;
  }

  /// Returns the position on the ruler corresponding to a specific value.
  ///
  /// This method calculates the position (e.g., the offset or pixel position) on the ruler that corresponds
  /// to a given value (e.g., "kg", "cm", etc.). It is used to visually align the ruler based on a specific
  /// measurement value.
  double getPositionByValue(num value) {
    double offsetValue = 0;
    for (ScaleIntervals config in widget.scaleUnit.scaleIntervals) {
      if (config.begin <= value && config.end >= value) {
        offsetValue +=
            ((value - config.begin) / config.scale) * _ruleScaleInterval;
        break;
      } else if (value >= config.begin) {
        var totalCount =
            ((config.end - config.begin) / config.scale).truncate();
        offsetValue += totalCount * _ruleScaleInterval;
      }
    }
    return offsetValue;
  }

  /// Sets the position of the ruler based on the provided value.
  ///
  /// This method adjusts the ruler's position (such as the scroll offset or marker position) based on the
  /// given value (e.g., "kg", "cm", etc.). It is used to align the ruler visually to a specific value,
  /// ensuring that the ruler's display corresponds to the provided measurement.
  ///
  /// Example: If the value is 5.0 and the ruler represents a scale for "kg", this method would adjust
  /// the ruler so that the position corresponding to 5 kg is aligned properly.
  void setPositionByValue(num value) {
    double offsetValue = getPositionByValue(value);
    scrollController.jumpTo(offsetValue);
    fixOffset();
  }
}
