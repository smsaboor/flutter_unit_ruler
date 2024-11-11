import 'package:flutter/material.dart';
import 'package:flutter_unit_ruler/flutter_unit_ruler.dart';
import 'package:flutter_unit_ruler/unit.dart';
import 'package:flutter_unit_ruler/ruler_controller.dart';
import 'package:flutter_unit_ruler/scale_line.dart';

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
  final darkThemeColor = const Color(0xFF0b1f28);
  final lightThemeColor = const Color(0xffdce2e5);

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
                              activeColor: const Color(0xFF3EB48C),
                              groupValue: heightUnit,
                              onChanged: setRange,
                            ),
                          ),
                          Text(
                            unit,
                            style: TextStyle(
                              fontSize: 18,
                              color: isDarkTheme ? Colors.grey : Colors.black54,
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
                        ? HeightInFeet(isDarkTheme: isDarkTheme)
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
                              activeColor: const Color(0xFF3EB48C),
                              groupValue: weightUnit,
                              onChanged: setWeightUnit,
                            ),
                          ),
                          Text(
                            unit,
                            style: TextStyle(
                              fontSize: 18,
                              color: isDarkTheme ? Colors.grey : Colors.black54,
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
          ])
      ),
    );
  }
}

class HeightInFeet extends StatefulWidget {
  final bool isDarkTheme;
  const HeightInFeet({required this.isDarkTheme, super.key});
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
    const double rulerMarkerPositionTop = 200.0;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0.0, right: 0),
          child: UnitRuler(
            unitName:Unit.length.inch,
            controller: _unitController,
            width: MediaQuery.of(context).size.width,
            height: 300,
            scrollDirection: Axis.vertical,
            backgroundColor: rulerBackgroundColor,
            rulerPadding: const EdgeInsets.only(
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
              UnitIntervalStyle(color: Colors.redAccent, width: 1, height: 40, scale: 6),
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

class HeightInCm extends StatefulWidget {
  final bool isDarkTheme;
  const HeightInCm({required this.isDarkTheme, super.key});

  @override
  HeightInCmState createState() => HeightInCmState();
}

class HeightInCmState extends State<HeightInCm> {
  double currentHeight = 152.0;
  late UnitController _unitController;
  UnitName unit = Unit.length.mile;

  @override
  void initState() {
    _unitController = UnitController(value: currentHeight);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = widget.isDarkTheme ? const Color(0xFF0b1f28) : const Color(0xffdce2e5);
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 100.0),
          child: UnitRuler(
            height: 300,
            width: MediaQuery.of(context).size.width,
            unitName: unit,
            controller: _unitController,
            scrollDirection: Axis.vertical,
            backgroundColor: themeColor,
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
            unitIntervalTextStyle: TextStyle(
              color: widget.isDarkTheme ? const Color(0xFFBCC2CB) : const Color(0xFF191A1C),
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
            "${currentHeight.toInt()} ${unit.symbol}",
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
    const double rulerMarkerPositionLeft = 180;
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
              rulerPadding: const EdgeInsets.only(left: rulerMarkerPositionLeft, right: 0, top: 0, bottom: 40),
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
