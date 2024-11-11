// Copyright [YEAR] [COPYRIGHT HOLDER]
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';

/// Defines the visual style for an interval on the ruler.
///
/// The [ScaleIntervalStyle] class allows you to customize the appearance of an interval on the ruler.
/// It includes properties like the interval's [scale], [color], [width], and [height], enabling flexible
/// customization of how each unit interval is displayed. This class can be used to modify the look of different
/// measurement intervals, making them distinct and visually appealing.
///
/// The [scale] can be used to adjust the relative size of the interval, while the [color], [width], and [height]
/// properties control the visual style of the interval.
class ScaleIntervalStyle {
  /// The scale factor for the interval, used to adjust its visual representation.
  /// The default value is -1, meaning no scale is applied by default.
  final int scale;

  /// The color used to render the interval on the ruler.
  final Color color;

  /// The width of the interval on the ruler, defining how much space the interval occupies.
  final double width;

  /// The height of the interval, which typically determines how tall the interval is rendered.
  final double height;

  /// Creates a [ScaleIntervalStyle] with the specified [color], [width], and [height].
  /// Optionally, you can provide a [scale] to adjust the interval's visual representation.
  ///
  /// The [scale] defaults to -1 (no scale applied), and the other properties are required.
  const ScaleIntervalStyle({
    this.scale = -1,
    required this.color,
    required this.width,
    required this.height,
  });
}
