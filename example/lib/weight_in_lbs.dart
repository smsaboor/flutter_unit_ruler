import 'package:flutter_unit_ruler/unit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unit_ruler/flutter_unit_ruler.dart';
import 'package:flutter_unit_ruler/ruler_controller.dart';
import 'package:flutter_unit_ruler/ruler_range.dart';
import 'package:flutter_unit_ruler/scale_line.dart';

class WeightInLbs extends StatefulWidget {
  final bool isDarkTheme;
  const WeightInLbs({required this.isDarkTheme, super.key});
  @override
  State<WeightInLbs> createState() => _WeightInLbsState();
}

class _WeightInLbsState extends State<WeightInLbs> {
  double currentWeight = 60.0;
  late final UnitController _unitController;
  final darkThemeColor = const Color(0xFF0b1f28);
  final lightThemeColor = const Color(0xffdce2e5);

  @override
  void initState() {
    _unitController = UnitController(value: currentWeight);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final rulerBackgroundColor = widget.isDarkTheme ? darkThemeColor : lightThemeColor;
    final textColor = widget.isDarkTheme ? Colors.grey : Colors.black54;
    const double rulerMarkerPositionLeft = 180;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 40),
          child: UnitRuler(
            unitName: Unit.weight.lbs,
            controller: _unitController,
            height: 100,
            width: MediaQuery.of(context).size.width,
            backgroundColor: rulerBackgroundColor,
            rulerPadding: const EdgeInsets.only(
                left: rulerMarkerPositionLeft,
                right: 0,
                top: 0,
              bottom: 0
            ),
            scrollDirection: Axis.horizontal,
            rulerMarker: Container(height: 210, width: 1, color: const Color(
                0xFF46E252)),
            rulerMarkerPositionTop: 10,
            rulerMarkerPositionLeft: rulerMarkerPositionLeft+5,
            rulerAlignment: Alignment.bottomCenter,
            rulerMargin: 9,
            unitIntervalTextStyle: TextStyle(color: textColor, fontSize: 14),
            unitIntervalText: (index, value) => value.toInt().toString(),
            unitIntervalTextPosition:30,
            unitIntervalStyles: const [
              UnitIntervalStyle(
                  color: Colors.grey, width: 1, height: 20, scale: -1),
              UnitIntervalStyle(
                  color: Colors.grey, width: 1, height: 20, scale: 5),
              UnitIntervalStyle(
                  color: Colors.grey, width: 1, height: 30, scale: 0)
            ],
            onValueChanged: (value) => setState(() => currentWeight = value.toDouble()),
          ),
        ),
        Positioned(
          bottom: 90,
          left: 170,
          child: Text(
            "${currentWeight.toInt()} lbs",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: widget.isDarkTheme ? Colors.white : Colors.black54,
            ),
          ),
        ),
      ],
    );
  }
}
