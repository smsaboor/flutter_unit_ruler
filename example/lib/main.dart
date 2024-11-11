import 'package:flutter/material.dart';
import 'package:flutter_unit_ruler/flutter_unit_ruler.dart';
import 'package:flutter_unit_ruler/scale_interval.dart';
import 'package:flutter_unit_ruler/scale_unit.dart';
import 'package:flutter_unit_ruler/scale_controller.dart';
import 'package:flutter_unit_ruler/scale_line.dart';

const darkThemeColor = Color(0xff310ecb);
const lightThemeColor = Color(0xffdce2e5);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String heightUnit = 'Ft';
  String weightUnit = 'Kg';
  bool isDarkTheme = true;


  void setRange(String? value) => setState(() => heightUnit = value!);

  void setWeightUnit(String? value) => setState(() => weightUnit = value!);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: isDarkTheme ? darkThemeColor : lightThemeColor,
          appBar: AppBar(
            title: const Text('Ruler Demo'),
            actions: [
              Switch(
                value: isDarkTheme,
                onChanged: (value) => setState(() => isDarkTheme = value),
              ),
            ],
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Vertical Ruler'),
                Tab(text: 'Horizontal Ruler'),
              ],
            ),
          ),
          body: TabBarView(children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: [
                  Text(
                    "Height in",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: isDarkTheme ? Colors.white : Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: ['Ft', 'Cm'].map((unit) {
                      return Row(
                        children: [
                          Transform.scale(
                            scale: 1.1,
                            child: Radio<String>(
                              value: unit,
                              activeColor: Colors.white70,
                              groupValue: heightUnit,
                              onChanged: setRange,
                            ),
                          ),
                          Text(
                            unit,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isDarkTheme ? Colors.white : Colors.black54,
                            ),
                          ),
                          const SizedBox(width: 50),
                        ],
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: heightUnit == "Ft"
                        ? HeightInInches(isDarkTheme: isDarkTheme)
                        : HeightInCm(isDarkTheme: isDarkTheme),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: [
                  Text(
                    "Weight in?",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: isDarkTheme ? Colors.white : Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: ['Kg', 'Lbs'].map((unit) {
                      return Row(
                        children: [
                          Transform.scale(
                            scale: 1.1,
                            child: Radio<String>(
                              value: unit,
                              activeColor: Colors.white70,
                              groupValue: weightUnit,
                              onChanged: setWeightUnit,
                            ),
                          ),
                          Text(
                            unit,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isDarkTheme ? Colors.white : Colors.black54,
                            ),
                          ),
                          const SizedBox(width: 50),
                        ],
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: weightUnit == "Kg"
                        ? WeightInKg(isDarkTheme: isDarkTheme)
                        : WeightInLbs(isDarkTheme: isDarkTheme),
                  ),
                ],
              ),
            ),
          ])),
    );
  }
}

class HeightInInches extends StatefulWidget {
  final bool isDarkTheme;

  const HeightInInches({required this.isDarkTheme, super.key});

  @override
  State<HeightInInches> createState() => _HeightInInchesState();
}

class _HeightInInchesState extends State<HeightInInches> {
  double currentHeightInInches = 68.0;
  late final ScaleController _unitController;
  late final ScaleUnit _scaleUnit;

  @override
  void initState() {
    _scaleUnit = UnitType.length.inch;
    _unitController = ScaleController(value: currentHeightInInches);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final rulerBackgroundColor = widget.isDarkTheme ? darkThemeColor : lightThemeColor;
    final textColor = widget.isDarkTheme ? Colors.grey : Colors.black54;
    const double rulerMarkerPositionTop = 170.0;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0.0, right: 30),
          child: UnitRuler(
            height: 400,
            width: MediaQuery.of(context).size.width,
            scaleUnit: _scaleUnit,
            controller: _unitController,
            scrollDirection: Axis.vertical,
            backgroundColor: rulerBackgroundColor,
            scalePadding: const EdgeInsets.only(
                left: 190, right: 0, top: rulerMarkerPositionTop),
            scaleAlignment: Alignment.topRight,
            scaleMargin: 80,
            scaleMarker: Container(
                height: 2, width: 200, color: const Color(0xFF3EB48C)),
            scaleMarkerPositionTop: rulerMarkerPositionTop,
            scaleMarkerPositionLeft: 160,
            scaleIntervalText: (index, value) {
              final feet = value ~/ 12;
              final inches = (value % 12).toInt();
              return inches == 0 ? "$feet.0" : "$feet.$inches";
            },
            scaleIntervalTextStyle: TextStyle(color: textColor, fontSize: 14),
            scaleIntervalTextPosition: 0,
            scaleIntervalStyles: const [
              ScaleIntervalStyle(
                  color: Colors.white70, width: 35, height: 2, scale: -1),
              ScaleIntervalStyle(
                  color: Colors.yellow, width: 55, height: 2.5, scale: 0),
              ScaleIntervalStyle(
                  color: Colors.redAccent, width: 40, height: 2, scale: 6),
            ],
            onValueChanged: (value) =>
                setState(() => currentHeightInInches = value.toDouble()),
          ),
        ),
        Positioned(
          // bottom: 220,
          left: 150,
          top: 130,
          child: Text(
            "${_formatFeetAndInches(currentHeightInInches)} Ft",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
                color: widget.isDarkTheme ? Colors.white : Colors.black54),
          ),
        ),
        Positioned(
            bottom: 0,
            left: 125,
            child: Image.asset(
              'assets/girl.png',
              height: 300,
            )),
      ],
    );
  }

  String _formatFeetAndInches(double inches) {
    final feet = inches ~/ 12;
    final remainingInches = (inches % 12).toInt();
    return remainingInches == 0 ? "$feet" : "$feet.$remainingInches";
  }
}

class HeightInCm extends StatefulWidget {
  final bool isDarkTheme;

  const HeightInCm({required this.isDarkTheme, super.key});

  @override
  HeightInCmState createState() => HeightInCmState();
}

class HeightInCmState extends State<HeightInCm> {
  double currentHeightInCentimeter = 152.0;
  late ScaleController _unitController;
  late final ScaleUnit _scaleUnit;

  @override
  void initState() {
    _scaleUnit = UnitType.length.centimeter;
    _unitController = ScaleController(value: currentHeightInCentimeter);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor =
        widget.isDarkTheme ? const Color(0xFF0b1f28) : const Color(0xffdce2e5);
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 80.0),
          child: UnitRuler(
            height: 300,
            width: MediaQuery.of(context).size.width,
            scaleUnit: _scaleUnit,
            controller: _unitController,
            scrollDirection: Axis.vertical,
            backgroundColor: darkThemeColor,
            scaleAlignment: Alignment.topLeft,
            scalePadding: const EdgeInsets.only(left: 0, right: 10, top: 110),
            scaleMargin: 120,
            scaleMarker: Container(
                height: 2, width: 240, color: const Color(0xFF3EB48C)),
            scaleMarkerPositionTop: 110,
            scaleMarkerPositionLeft: 0,
            scaleIntervalText: (index, value) => value.toInt().toString(),
            scaleIntervalTextStyle: TextStyle(
              color: widget.isDarkTheme
                  ? const Color(0xFFBCC2CB)
                  : const Color(0xFF191A1C),
              fontSize: 14,
            ),
            scaleIntervalTextPosition: 0,
            scaleIntervalStyles: const [
              ScaleIntervalStyle(
                  color: const Color(0xFFBCC2CB), width: 35, height: 2, scale: -1),
              ScaleIntervalStyle(
                  color: Colors.limeAccent, width: 50, height: 2.5, scale: 0),
              ScaleIntervalStyle(
                  color: const Color(0xFFBCC2CB), width: 40, height: 2, scale: 5),
            ],
            onValueChanged: (value) =>
                setState(() => currentHeightInCentimeter = value.toDouble()),
          ),
        ),
        Positioned(
          bottom: 310,
          left: 190,
          child: Text(
            "${currentHeightInCentimeter.toInt()} ${_scaleUnit.symbol}",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: widget.isDarkTheme ? Colors.white : Colors.black54,
            ),
          ),
        ),
        Positioned(
            bottom: 0,
            left: 200,
            child: Image.asset(
              'assets/girl.png',
              height: 300,
            )),
      ],
    );
  }
}

class WeightInKg extends StatefulWidget {
  final bool isDarkTheme;

  const WeightInKg({required this.isDarkTheme, super.key});

  @override
  State<WeightInKg> createState() => _WeightInKgState();
}

class _WeightInKgState extends State<WeightInKg> {
  double currentWeightInKilogram = 63.0;
  late final ScaleController _unitController;
  late final ScaleUnit _scaleUnit;

  @override
  void initState() {
    _scaleUnit = UnitType.weight.kilogram;
    _unitController = ScaleController(value: currentWeightInKilogram);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final rulerBackgroundColor =
        widget.isDarkTheme ? darkThemeColor : lightThemeColor;
    final textColor = widget.isDarkTheme ? Colors.grey : Colors.black54;
    const double rulerMarkerPositionLeft = 180;
    return Stack(
      children: [
        SizedBox(
          height: 200,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 85.0),
            child: UnitRuler(
              controller: _unitController,
              scaleUnit: _scaleUnit,
              scrollDirection: Axis.horizontal,
              backgroundColor: rulerBackgroundColor,
              scalePadding: const EdgeInsets.only(
                  left: rulerMarkerPositionLeft, right: 0, top: 0, bottom: 40),
              scaleMarker: Container(
                  height: 130, width: 2.5, color: const Color(0xFF3EB48C)),
              scaleMarkerPositionTop: 0,
              scaleMarkerPositionLeft: rulerMarkerPositionLeft + 4,
              scaleAlignment: Alignment.topCenter,
              scaleIntervalText: (index, value) => value.toInt().toString(),
              scaleIntervalTextStyle: TextStyle(color: textColor, fontSize: 14),
              scaleIntervalTextPosition: 5,
              scaleIntervalStyles: const [
                ScaleIntervalStyle(
                    color: Colors.white, width: 2, height: 30, scale: -1),
                ScaleIntervalStyle(
                    color: Colors.red, width: 2, height: 35, scale: 5),
                ScaleIntervalStyle(
                    color: Colors.yellow, width: 2, height: 45, scale: 0),
              ],
              onValueChanged: (value) =>
                  setState(() => currentWeightInKilogram = value.toDouble()),
              width: MediaQuery.of(context).size.width,
              height: 90,
              scaleMargin: 9,
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 140,
          child: Text(
            "${currentWeightInKilogram.toInt()} ${_scaleUnit.symbol}",
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

class WeightInLbs extends StatefulWidget {
  final bool isDarkTheme;

  const WeightInLbs({required this.isDarkTheme, super.key});

  @override
  State<WeightInLbs> createState() => _WeightInLbsState();
}

class _WeightInLbsState extends State<WeightInLbs> {
  double currentWeightInPound = 56.0;
  late final ScaleController _unitController;

  @override
  void initState() {
    _unitController = ScaleController(value: currentWeightInPound);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final rulerBackgroundColor =
        widget.isDarkTheme ? darkThemeColor : lightThemeColor;
    final textColor = widget.isDarkTheme ? Colors.grey : Colors.black54;
    const double rulerMarkerPositionLeft = 180;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 40),
          child: UnitRuler(
          // scaleUnit: UnitType.weight.pound, or
          scaleUnit: ScaleUnit(
              name: 'pound',
              symbol: 'lb',
              subDivisionCount: 10,
              scaleIntervals: List.generate(
                  15,
                  (i) => ScaleIntervals(
                      begin: i * 10, end: (i + 1) * 10, scale: 1)),
            ),
            controller: _unitController,
            height: 100,
            width: MediaQuery.of(context).size.width,
            backgroundColor: rulerBackgroundColor,
            scalePadding: const EdgeInsets.only(
                left: rulerMarkerPositionLeft, right: 0, top: 0, bottom: 0),
            scrollDirection: Axis.horizontal,
            scaleMarker: Container(
                height: 210, width: 2, color: const Color(0xFF46E252)),
            scaleMarkerPositionTop: 10,
            scaleMarkerPositionLeft: rulerMarkerPositionLeft + 5,
            scaleAlignment: Alignment.bottomCenter,
            scaleMargin: 9,
            scaleIntervalTextStyle: TextStyle(color: textColor, fontSize: 14),
            scaleIntervalText: (index, value) => value.toInt().toString(),
            scaleIntervalTextPosition: 50,
            scaleIntervalStyles: const [
              ScaleIntervalStyle(
                  color: Colors.yellow, width: 2, height: 35, scale: -1),
              ScaleIntervalStyle(
                  color: Colors.yellow, width: 2, height: 35, scale: 5),
              ScaleIntervalStyle(
                  color: Colors.red, width: 2, height: 45, scale: 0)
            ],
            onValueChanged: (value) =>
                setState(() => currentWeightInPound = value.toDouble()),
          ),
        ),
        Positioned(
          bottom: 90,
          left: 170,
          child: Text(
            "${currentWeightInPound.toInt()} lbs",
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
