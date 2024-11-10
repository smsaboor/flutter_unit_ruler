import 'package:flutter/material.dart';
import 'package:flutter_unit_ruler/flutter_unit_ruler.dart';
import 'package:flutter_unit_ruler/ruler_controller.dart';
import 'package:flutter_unit_ruler/scale_line.dart';
import 'package:flutter_unit_ruler/unit.dart';

class HeightInCm extends StatefulWidget {
  final bool isDarkTheme;
  const HeightInCm({required this.isDarkTheme, super.key});

  @override
  _HeightInCmState createState() => _HeightInCmState();
}

class _HeightInCmState extends State<HeightInCm> {
  double currentHeight = 152.0;
  late UnitController _unitController;

  @override
  void initState() {
    _unitController = UnitController(value: currentHeight);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = widget.isDarkTheme ? const Color(0xFF0b1f28) : const Color(0xffdce2e5);
    final scaleColor = widget.isDarkTheme ? Colors.grey : Colors.black54;

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 100.0),
          child: UnitRuler(
            unitName: Unit.length.centimeter,
            controller: _unitController,
            backgroundColor: themeColor,
            scrollDirection: Axis.vertical,
            width: MediaQuery.of(context).size.width,
            height: 300,
            rulerPadding: const EdgeInsets.only(
                left: 0,
                right: 40,
                top: 10
            ),
            rulerMarker: Container(height: 1.2, width: 240, color: const Color(0xFF3EB48C)),
            rulerMarkerPositionTop: 10,
            rulerMarkerPositionLeft: 20,
            rulerAlignment: Alignment.topRight,
            unitIntervalText: (index, value) => value.toInt().toString(),
            unitIntervalTextStyle: TextStyle(
              color: widget.isDarkTheme ? const Color(0xFFBCC2CB) : const Color(0xFF191A1C),
              fontSize: 14,
            ),
            onValueChanged: (value) => setState(() => currentHeight = value.toDouble()),
            unitIntervalTextPosition: 80,
            // unitIntervals: List.generate(15, (i) => UnitInterval(begin: i * 20, end: (i + 1) * 20, scale: 1)),
            unitIntervalStyles: const [
              UnitIntervalStyle(color: Colors.yellow, width: 1, height: 35, scale: -1),
              UnitIntervalStyle(color: Colors.blue, width: 1.5, height: 50, scale: 0),
              UnitIntervalStyle(color: Colors.redAccent, width: 1, height: 40, scale: 5),
            ],
            rulerMargin: 120,
          ),
        ),
        Positioned(
          bottom: 220,
          left: 110,
          child: Text(
            "${currentHeight.toInt()} Cm",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: widget.isDarkTheme ? Colors.white : Colors.black54,
            ),
          ),
        ),
      ],
    );
  }
}
