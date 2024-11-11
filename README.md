# flutter_unit_ruler

flutter_unit_ruler is a versatile Flutter package that provides a digital ruler (Horizontal and Vertical) capable of measuring a wide range of units, including length (kilometers, meters, feet, inches) and weight (kilograms, pounds, tons). This tool is ideal for applications in construction, fitness, education, and other fields requiring accurate, interactive measurement displays. It offers seamless customization options, allowing developers to set unit types, scale divisions, and visual styles, making it easy to integrate precise and user-friendly measurement tools into your app.
([pub.dev](https://pub.dev/packages/flutter_unit_ruler)).
## Screenshots

![Vertical Ruler](./v_ruler.gif) ![Horizontal Ruler](./h_ruler.gif)

[//]: # (<img src="https://github.com/smsaboor/flutter_unit_ruler/blob/master/h_ruler.gif?raw=true"  height="500em" />)

## How to Use

This example demonstrates how to create a customizable vertical ruler using the flutter_unit_ruler package. You can use this ruler to display measurements in units like inches, centimeters, or any custom unit you define.

To use this package :

- add the dependency to your [pubspec.yaml](https://github.com/smsaboor/flutter_unit_ruler/blob/main/pubspec.yaml) file.

 ```yaml
 dependencies:
    flutter:
      sdk: flutter
    flutter_unit_ruler:
```


- Import the necessary packages:

```packges
import 'package:flutter/material.dart';
import 'package:flutter_unit_ruler/flutter_unit_ruler.dart';
import 'package:flutter_unit_ruler/unit.dart';
import 'package:flutter_unit_ruler/scale_controller.dart';
import 'package:flutter_unit_ruler/scale_line.dart';
```

- Code Example:
Below is the full code to create a ruler with centimeter units that dynamically updates as you scroll.

```dart
class RulerExample extends StatefulWidget {
  const RulerExample({super.key});

  @override
  State<RulerExample> createState() => _RulerExampleState();
}

class _RulerExampleState extends State<RulerExample> {
  final darkThemeColor = const Color(0xFF0b1f28); // Background color for the ruler
  late final ScaleController _scaleController; // Controller to manage the current value

  double currentHeight = 180.0; // Initial height value

  @override
  void initState() {
    _scaleController = ScaleController(value: currentHeight); // Initialize the controller
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
                height: 300, // Height of the ruler
                width: MediaQuery.of(context).size.width, // Width of the ruler
                controller: _scaleController, // Use scale controller for dynamic updates
                scrollDirection: Axis.vertical, // Set ruler orientation to vertical
                backgroundColor: darkThemeColor, // Background color
                scaleUnit: UnitType.length.centimeter, // Set unit to centimeters
                scaleAlignment: Alignment.topRight, // Align scale to the top-right
                scalePadding: const EdgeInsets.only(left: 0, right: 40, top: 10), // Padding for the scale
                scaleMargin: 120, // Margin for scale placement
                scaleMarker: Container(
                  height: 2,
                  width: 240,
                  color: const Color(0xFF3EB48C), // Color of scale marker
                ),
                scaleMarkerPositionTop: 10, // Top position of the scale marker
                scaleMarkerPositionLeft: 20, // Left position of the scale marker
                scaleIntervalText: (index, value) => value.toInt().toString(), // Format interval text
                scaleIntervalTextStyle: const TextStyle(
                  color: Color(0xFFBCC2CB),
                  fontSize: 14,
                ),
                scaleIntervalTextPosition: 80, // Text position on the scale
                scaleIntervalStyles: const [
                  ScaleIntervalStyle(color: Colors.yellow, width: 35, height: 2, scale: -1),
                  ScaleIntervalStyle(color: Colors.blue, width: 50, height: 2.5, scale: 0),
                  ScaleIntervalStyle(color: Colors.redAccent, width: 40, height: 2, scale: 5),
                ],
                onValueChanged: (value) => setState(() => currentHeight = value.toDouble()), // Update height value
              ),
            ),
            Positioned(
              bottom: 220,
              left: 110,
              child: Text(
                "${currentHeight.toInt()} ${UnitType.length.centimeter.symbol}",  // Display current height in centimeters
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

## Key Features
- Customizable Unit: You can specify a unit, such as UnitType.length.centimeter here, or define your own unit if needed.
  - For custom units, use the scaleUnit parameter to define properties:
  ```code
  scaleUnit:  ScaleUnit(
  name: 'inch',
  symbol: 'in',
  subDivisionCount: 12,
  scaleIntervals: List.generate(
  10, (i) => ScaleIntervals(begin: i * 12, end: (i + 1) * 12, scale: 1)),
  ),
  ```
- Dynamic Value Updates: With ScaleController, you can monitor and dynamically update the ruler value in real-time. This feature is ideal for applications requiring precise tracking, such as fitness or construction apps, where the current measurement needs to be frequently adjusted and displayed.
- Flexible Styling Options:
  - Customize the ruler's appearance with extensive styling options:
  - Background Color: Adjust the ruler background color to match your app theme.
  - Alignment & Padding: Control alignment, padding, and margins to position the ruler exactly where it’s needed within the app.
  - Scale Marker Styles: Modify the appearance of scale markers with customizable width, height, color, and placement.
  - Interval Text Styles: Customize the font size, color, and positioning of interval labels, ensuring readability and consistency with your app's design.


## Usage
Use this example to implement a scrollable vertical or horizontal ruler in your app. Modify parameters like scrollDirection and scaleUnit for additional configurations, and feel free to style the ruler's scale markers and interval text to match your app's theme.


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