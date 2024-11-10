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
import 'package:flutter_unit_ruler/ruler_controller.dart';
import 'package:flutter_unit_ruler/ruler_range.dart';
import 'package:flutter_unit_ruler/scale_line.dart';
import 'package:flutter_unit_ruler/triangle_painter.dart';
import 'package:flutter_unit_ruler/unit.dart';

typedef ValueChangedCallback = void Function(num value);

class UnitRuler extends StatefulWidget {
  final ValueChangedCallback onValueChanged;
  final String Function(int index, num rulerScaleValue) unitIntervalText;
  final double width;
  final double height;
  final Axis scrollDirection;
  final TextStyle unitIntervalTextStyle;
  final List<UnitIntervalStyle> unitIntervalStyles;
  final Widget? rulerMarker;
  final double rulerMargin;
  final Color backgroundColor;
  final UnitController? controller;
  final UnitName unitName;
  final double rulerMarkerPositionTop;
  final double rulerMarkerPositionLeft;
  final Alignment rulerAlignment;
  final double unitIntervalTextPosition;
  final EdgeInsetsGeometry? rulerPadding;

  const UnitRuler({super.key,
    required this.onValueChanged,
    required this.width,
    required this.unitName,
    required this.rulerPadding,
    required this.rulerAlignment,
    required this.scrollDirection,
    required this.rulerMarkerPositionTop,
    required this.rulerMarkerPositionLeft,
    required this.height,
    required this.unitIntervalText,
    required this.unitIntervalTextPosition,
    this.rulerMargin = 0,
    this.unitIntervalStyles = const [
      UnitIntervalStyle(
          scale: 0,
          color: Color.fromARGB(255, 188, 194, 203),
          width: 2,
          height: 32),
      UnitIntervalStyle(
          color: Color.fromARGB(255, 188, 194, 203), width: 1, height: 20),
    ],
    this.unitIntervalTextStyle = const TextStyle(
      color: Color.fromARGB(255, 188, 194, 203),
      fontSize: 14,
    ),
    this.rulerMarker,
    this.backgroundColor = Colors.white,
    this.controller,
  });

  @override
  State<StatefulWidget> createState() {
    return UnitRulerState();
  }
}

class UnitRulerState extends State<UnitRuler> {
  double lastOffset = 0;
  bool isPosFixed = false;
  String value = '';
  late ScrollController scrollController;
  final Map<int, UnitIntervalStyle> _scaleLineStyleMap = {};
  int itemCount = 0;

  @override
  void initState() {
    super.initState();

    itemCount = _calculateItemCount();

    for (var element in widget.unitIntervalStyles) {
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
    for (var element in widget.unitName.unitIntervals) {
      itemCount += ((element.end - element.begin) / element.scale).truncate();
    }
    itemCount += 1;
    return itemCount;
  }

  void _onValueChanged() {
    int currentIndex = scrollController.offset ~/ _ruleScaleInterval.toInt();

    if (currentIndex < 0) currentIndex = 0;
    num currentValue = getRulerScaleValue(currentIndex);

    var lastConfig = widget.unitName.unitIntervals.last;
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
        widget.unitName
            .unitGroup; // give 12 bcz want to give for feet which has 12 inches

    if (_scaleLineStyleMap[scale] != null) {
      width = widget.scrollDirection == Axis.horizontal
          ? _scaleLineStyleMap[scale]!.width
          : _scaleLineStyleMap[scale]!
              .height; // Swap width with height for vertical ruler else horizonatal
      height = widget.scrollDirection == Axis.horizontal
          ? _scaleLineStyleMap[scale]!.height
          : _scaleLineStyleMap[scale]!.width; // Swap height with width
      color = _scaleLineStyleMap[scale]!.color;
    } else {
      if (_scaleLineStyleMap[-1] != null) {
        scale = -1;
        width = widget.scrollDirection == Axis.horizontal
            ? _scaleLineStyleMap[scale]!.width
            : _scaleLineStyleMap[scale]!
                .height; // Swap width with height for vertical ruler else horizonatal
        height = widget.scrollDirection == Axis.horizontal
            ? _scaleLineStyleMap[scale]!.height
            : _scaleLineStyleMap[scale]!.width; // Swap height with width
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
              alignment: widget.rulerAlignment,
              // alignment: widget.rulerAlignment ?? (widget.scrollDirection == Axis.horizontal
              //         ? Alignment.topCenter
              //         : Alignment.bottomLeft),
              child: _buildRulerScaleLine(index)),
          Positioned(
            bottom: widget.scrollDirection == Axis.horizontal
                ? widget.unitIntervalTextPosition
                : 0,
            left: widget.scrollDirection == Axis.horizontal
                ? -50 + _ruleScaleInterval / 2
                : widget.unitIntervalTextPosition + _ruleScaleInterval / .2,
            width: widget.scrollDirection == Axis.horizontal ? 100 : 40,
            child: index % widget.unitName.unitGroup ==
                    0 // give 12 bcz for inches
                ? Container(
                    alignment: Alignment.center,
                    child: Text(
                      widget.unitIntervalText(index, getRulerScaleValue(index)),
                      style: widget.unitIntervalTextStyle,
                    ),
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }

  final double _ruleScaleInterval = 10;

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

  num getRulerScaleValue(int index) {
    num rulerScaleValue = 0;
    UnitInterval? currentConfig;
    for (UnitInterval config in widget.unitName.unitIntervals) {
      currentConfig = config;
      if (currentConfig == widget.unitName.unitIntervals.last) {
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
          (widget.scrollDirection == Axis.vertical ? 0 : widget.rulerMargin),
      height: widget.height +
          (widget.scrollDirection == Axis.vertical ? widget.rulerMargin : 0),
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
                      padding: widget.rulerPadding,
                      itemExtent: _ruleScaleInterval,
                      itemCount: itemCount,
                      controller: scrollController,
                      scrollDirection: widget.scrollDirection,
                      itemBuilder: _buildRulerScale,
                    ))),
          ),
          Positioned(
              top: widget.rulerMarkerPositionTop,
              left:widget.rulerMarkerPositionLeft,
              child: widget.rulerMarker ?? _buildMark())
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

  bool isRangesChanged(UnitRuler oldWidget) {
    if (oldWidget.unitName.unitIntervals.length !=
        widget.unitName.unitIntervals.length) {
      return true;
    }

    if (widget.unitName.unitIntervals.isEmpty) return false;
    for (int i = 0; i < widget.unitName.unitIntervals.length; i++) {
      UnitInterval oldRange = oldWidget.unitName.unitIntervals[i];
      UnitInterval range = widget.unitName.unitIntervals[i];
      if (oldRange.begin != range.begin ||
          oldRange.end != range.end ||
          oldRange.scale != range.scale) {
        return true;
      }
    }
    return false;
  }

  double getPositionByValue(num value) {
    double offsetValue = 0;
    for (UnitInterval config in widget.unitName.unitIntervals) {
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

  void setPositionByValue(num value) {
    double offsetValue = getPositionByValue(value);
    scrollController.jumpTo(offsetValue);
    fixOffset();
  }
}
