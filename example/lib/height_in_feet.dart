import 'package:flutter_unit_ruler/unit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unit_ruler/flutter_unit_ruler.dart';
import 'package:flutter_unit_ruler/ruler_controller.dart';
import 'package:flutter_unit_ruler/scale_line.dart';

class HeightInFeet extends StatefulWidget {
  final bool isDarkTheme;
  const HeightInFeet({required this.isDarkTheme, Key? key}) : super(key: key);
  @override
  State<HeightInFeet> createState() => _HeightInFeetState();
}

class _HeightInFeetState extends State<HeightInFeet> {
  double currentHeight = 60.0;
  late final UnitController _unitController;
  final darkThemeColor = const Color(0xFF0b1f28);
  final lightThemeColor = const Color(0xffdce2e5);

  @override
  void initState() {
    _unitController = UnitController(value: currentHeight);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final rulerBackgroundColor = widget.isDarkTheme ? darkThemeColor : lightThemeColor;
    final textColor = widget.isDarkTheme ? Colors.grey : Colors.black54;
    final double rulerMarkerPositionTop = 200.0;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0.0, right: 0),
          child: UnitRuler(
            unitName:Unit.length.inches,
            controller: _unitController,
            width: MediaQuery.of(context).size.width,
            height: 300,
            scrollDirection: Axis.vertical,
            backgroundColor: rulerBackgroundColor,
            rulerPadding: EdgeInsets.only(
                left: 240,
                right: 0,
                top: rulerMarkerPositionTop
            ),
            rulerAlignment: Alignment.topLeft,
            rulerMargin: 80,
            rulerMarker: Container(height: 1.2, width: 170, color: const Color(0xFF3EB48C)),
            rulerMarkerPositionTop: rulerMarkerPositionTop,
            rulerMarkerPositionLeft: 140,
            onValueChanged: (value) => setState(() => currentHeight = value.toDouble()),
            // unitIntervals: List.generate(10, (i) => UnitInterval(begin: i * 12, end: (i + 1) * 12, scale: 1)),
            unitIntervalText: (index, value) {
              final feet = value ~/ 12;
              final inches = (value % 12).toInt();
              return inches == 0 ? "$feet.0" : "$feet.$inches";
            },
            unitIntervalTextPosition:10,
            unitIntervalTextStyle: TextStyle(color: textColor, fontSize: 14),
            unitIntervalStyles: const [
              UnitIntervalStyle(color: Colors.green, width: 1, height: 35, scale: -1),
              UnitIntervalStyle(color: Colors.blue, width: 1.5, height: 50, scale: 0),
              UnitIntervalStyle(color: Colors.redAccent, width: 1, height: 40, scale: 5),
            ],
          ),
        ),
        Positioned(
          // bottom: 220,
          left: 150,
          top: 150,
          child: Text(
            "${_formatFeetAndInches(currentHeight)} Ft",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: widget.isDarkTheme ? Colors.white : Colors.black54),
          ),
        ),
      ],
    );
  }

  String _formatFeetAndInches(double inches) {
    final feet = inches ~/ 12;
    final remainingInches = (inches % 12).toInt();
    return remainingInches == 0 ? "$feet" : "$feet.$remainingInches";
  }
}
