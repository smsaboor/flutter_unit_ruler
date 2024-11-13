import 'package:flutter/material.dart';
import 'package:flutter_unit_ruler/flutter_unit_ruler.dart';


class RulerExample extends StatefulWidget {
  const RulerExample({super.key});

  @override
  State<RulerExample> createState() => _RulerExampleState();
}

class _RulerExampleState extends State<RulerExample> {
  final darkThemeColor = const Color(0xFF0b1f28);
  late final ScaleController _scaleController;

  double currentHeight = 180.0;

  @override
  void initState() {
    _scaleController = ScaleController(value: currentHeight);
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
                  // if you will not found your desired unit then give your self designed unit using constructor
                  controller: _scaleController,
                  // use Axis.vertical if want vertical ruler else Axis.horizontal
                  scrollDirection: Axis.vertical,
                  backgroundColor: darkThemeColor,
                  scaleUnit:  ScaleUnit(
                    name: 'inch',
                    symbol: 'in',
                    subDivisionCount: 12,
                    scaleIntervals: List.generate(
                        10, (i) => ScaleIntervals(begin: i * 12, end: (i + 1) * 12, scale: 1)),
                  ),
                  scaleAlignment: Alignment.topRight,
                  scalePadding: const EdgeInsets.only(
                      left: 0,
                      right: 40,
                      top: 10
                  ),
                  scaleMargin: 120,
                  scaleMarker: Container(height: 1.2, width: 240, color: const Color(0xFF3EB48C)),
                  scaleMarkerPositionTop: 10,
                  scaleMarkerPositionLeft: 20,
                  scaleIntervalText: (index, value) => value.toInt().toString(),
                  scaleIntervalTextStyle: const TextStyle(
                    color: Color(0xFFBCC2CB),
                    fontSize: 14,
                  ),
                  scaleIntervalTextPosition: 80,
                  scaleIntervalStyles: const [
                    ScaleIntervalStyle(color: Colors.yellow, width: 1, height: 35, scale: -1),
                    ScaleIntervalStyle(color: Colors.blue, width: 1.5, height: 50, scale: 0),
                    ScaleIntervalStyle(color: Colors.redAccent, width: 1, height: 40, scale: 5),
                  ],
                  onValueChanged: (value) => setState(() => currentHeight = value.toDouble()),
                ),
              ),
              Positioned(
                bottom: 220,
                left: 110,
                child: Text(
                  "${currentHeight.toInt()} ${UnitType.length.centimeter.symbol}",
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
