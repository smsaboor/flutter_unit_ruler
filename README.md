# flutter_unit_ruler

A simple scale ruler for adding length in feet and inches and cms ([pub.dev](https://pub.dev/packages/flutter_unit_ruler)).
## Screenshots

<img src="https://github.com/smsaboor/flutter_unit_ruler/blob/master/v_ruler.gif?raw=true" height="300em" />  <img src="https://github.com/smsaboor/flutter_unit_ruler/blob/master/h_ruler.jpg?raw=true"  height="300em" />

## Usage
To use this package :

- add the dependency to your [pubspec.yaml](https://github.com/smsaboor/flutter_unit_ruler/blob/main/pubspec.yaml) file.

 ```yaml
 dependencies:
    flutter:
      sdk: flutter
    flutter_unit_ruler:
```

### How to use

```dart
import 'package:flutter/material.dart';
import 'package:flutter_unit_ruler/flutter_unit_ruler.dart';
import 'package:example/height_in_cm.dart';
import 'package:example/height_in_feet.dart';
import 'package:example/weight_in_kg.dart';
import 'package:example/weight_in_lbs.dart';

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

```

## Pull Requests

Pull requests are most welcome. It usually will take me within 24-48 hours to respond to any issue or request.

1.  Please keep PR titles easy to read and descriptive of changes, this will make them easier to merge :)
2.  Pull requests _must_ be made against `develop` branch. Any other branch (unless specified by the maintainers) will get rejected.

### Created & Maintained By
> If you found this project helpful or you learned something from the source code and want to thank me, consider buying me a cup of :coffee:
>
> * [PayPal](https://paypal.me/mdsaboor)

# License

    Copyright (c) 2024 [Mohammad Saboor]
    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.