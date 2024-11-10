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

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 100.0),
          child: UnitRuler(
            unitName: Unit.weight.lbs,
            controller: _unitController,
            height: 80,
            width: MediaQuery.of(context).size.width,
            backgroundColor: rulerBackgroundColor,
            rulerPadding: const EdgeInsets.only(
                left: 0,
                right: 40,
                top: 10
            ),
            scrollDirection: Axis.horizontal,
            rulerMarker: Container(height: 210, width: 1, color: const Color(
                0xFF46E252)),
            rulerMarkerPositionTop: 10,
            rulerMarkerPositionLeft: 20,
            rulerAlignment: Alignment.bottomLeft,
            rulerMargin: -111,
            unitIntervalTextStyle: TextStyle(color: textColor, fontSize: 14),
            unitIntervalText: (index, value) => value.toInt().toString(),
            unitIntervalTextPosition:25,
            unitIntervalStyles: const [
              UnitIntervalStyle(
                  color: Colors.grey, width: 1, height: 30, scale: 0),
              UnitIntervalStyle(
                  color: Colors.grey, width: 1, height: 25, scale: 2),
              UnitIntervalStyle(
                  color: Colors.grey, width: 1, height: 15, scale: -1)
            ],
            onValueChanged: (value) => setState(() => currentWeight = value.toDouble()),
          ),
        ),
        Positioned(
          bottom: 70,
          left: 140,
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
