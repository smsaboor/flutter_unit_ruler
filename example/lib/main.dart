import 'package:example/height_in_cm.dart';
import 'package:example/height_in_feet.dart';
import 'package:example/weight_in_kg.dart';
import 'package:example/weight_in_lbs.dart';
import 'package:flutter/material.dart';

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
      home: RulerExample(),
    );
  }
}



class RulerExample extends StatefulWidget {
  const RulerExample({super.key});

  @override
  State<RulerExample> createState() => _RulerExampleState();
}

class _RulerExampleState extends State<RulerExample> {
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
