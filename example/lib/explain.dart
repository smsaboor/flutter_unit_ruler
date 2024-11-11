import 'package:flutter/material.dart';
import 'package:flutter_unit_ruler/flutter_unit_ruler.dart';
import 'package:flutter_unit_ruler/unit.dart';
import 'package:flutter_unit_ruler/ruler_controller.dart';
import 'package:flutter_unit_ruler/scale_line.dart';


class RulerExample extends StatefulWidget {
  const RulerExample({super.key});

  @override
  State<RulerExample> createState() => _RulerExampleState();
}

class _RulerExampleState extends State<RulerExample> {
  final darkThemeColor = const Color(0xFF0b1f28);
  late final UnitController _unitController;

  double currentHeight = 180.0;

  @override
  void initState() {
    _unitController = UnitController(value: currentHeight);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: darkThemeColor,
        appBar: AppBar(
          title: const Text('Unit Ruler Demo'),
        ),
        body: Center(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 100.0),
                child: UnitRuler(
                  height: 300,  // ruler height
                  width: MediaQuery.of(context).size.width, // ruler weight
                  // currently there are 4 measurement unit available, 2 for height(centimeter and inches)
                  // and 2 for weight(kg and lbs), if you want to make ruler for centimeter then use
                  // Unit.length.centimeter, Unit.length.inches for feet, use Unit.weight.kg for kilogram, use
                  // Unit.weight.lbs for measuring pounds.
                  // if you will not found your desired unit then give your self designed unit using class
                  // UnitName(
                  //       name: 'inch',
                  //       symbol: 'in',
                  //       unitGroup: 12,
                  //       unitIntervals: List.generate(
                  //           10, (i) => UnitInterval(begin: i * 12, end: (i + 1) * 12, scale: 1)),
                  //     ),
                  unitName: Unit.length.centimeter,
                  controller: _unitController,
                  // use Axis.vertical if want vertical ruler else Axis.horizontal
                  scrollDirection: Axis.vertical,
                  backgroundColor: darkThemeColor,
                  rulerAlignment: Alignment.topRight,
                  rulerPadding: const EdgeInsets.only(
                      left: 0,
                      right: 40,
                      top: 10
                  ),
                  rulerMargin: 120,
                  rulerMarker: Container(height: 1.2, width: 240, color: const Color(0xFF3EB48C)),
                  rulerMarkerPositionTop: 10,
                  rulerMarkerPositionLeft: 20,
                  unitIntervalText: (index, value) => value.toInt().toString(),
                  unitIntervalTextStyle: const TextStyle(
                    color: Color(0xFFBCC2CB),
                    fontSize: 14,
                  ),
                  unitIntervalTextPosition: 80,
                  unitIntervalStyles: const [
                    UnitIntervalStyle(color: Colors.yellow, width: 1, height: 35, scale: -1),
                    UnitIntervalStyle(color: Colors.blue, width: 1.5, height: 50, scale: 0),
                    UnitIntervalStyle(color: Colors.redAccent, width: 1, height: 40, scale: 5),
                  ],
                  onValueChanged: (value) => setState(() => currentHeight = value.toDouble()),
                ),
              ),
              Positioned(
                bottom: 220,
                left: 110,
                child: Text(
                  "${currentHeight.toInt()} Cm",
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}
