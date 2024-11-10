import 'package:flutter_unit_ruler/unit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unit_ruler/flutter_unit_ruler.dart';
import 'package:flutter_unit_ruler/ruler_controller.dart';
import 'package:flutter_unit_ruler/scale_line.dart';

class WeightInKg extends StatefulWidget {
  final bool isDarkTheme;

  const WeightInKg({required this.isDarkTheme, super.key});

  @override
  State<WeightInKg> createState() => _WeightInKgState();
}

class _WeightInKgState extends State<WeightInKg> {
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
    final rulerBackgroundColor =
        widget.isDarkTheme ? darkThemeColor : lightThemeColor;
    final textColor = widget.isDarkTheme ? Colors.grey : Colors.black54;
    final double rulerMarkerPositionLeft = 180;
    return Stack(
      children: [
        SizedBox(
          height: 200,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 100.0),
            child: UnitRuler(
              controller: _unitController,
              unitName: Unit.weight.kg,
              scrollDirection: Axis.horizontal,
              backgroundColor: rulerBackgroundColor,
              rulerPadding: EdgeInsets.only(left: rulerMarkerPositionLeft, right: 0, top: 0, bottom: 40),
              rulerMarker: Container(
                  height: 130, width: 1, color: const Color(0xFF3EB48C)),
              rulerMarkerPositionTop: 0,
              rulerMarkerPositionLeft: rulerMarkerPositionLeft+5,
              rulerAlignment: Alignment.bottomCenter,
              unitIntervalText: (index, value) => value.toInt().toString(),
              unitIntervalTextStyle: TextStyle(color: textColor, fontSize: 14),
              unitIntervalTextPosition: 30,
              unitIntervalStyles: const [
                UnitIntervalStyle(
                    color: Colors.blue, width: 1, height: 20, scale: -1),
                UnitIntervalStyle(
                    color: Colors.red, width: 1, height: 25, scale: 5),
                UnitIntervalStyle(
                    color: Colors.yellow, width: 1, height: 30, scale: 0),
              ],
              onValueChanged: (value) =>
                  setState(() => currentWeight = value.toDouble()),
              width: MediaQuery.of(context).size.width,
              height: 90,
              rulerMargin: 9,
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 140,
          child: Text(
            "${currentWeight.toInt()} kg",
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w600,
              color: widget.isDarkTheme ? Colors.white : Colors.black54,
            ),
          ),
        ),
      ],
    );
  }
}
