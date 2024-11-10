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

/// Represents a range or interval of values on the ruler.
///
/// The [UnitInterval] class defines a range of values (from [begin] to [end]) on the ruler, with an optional
/// [scale] that can be applied to adjust the interval's size or behavior. It is typically used to represent
/// specific measurement intervals, such as ranges for weights (kg, pounds) or lengths (feet, cm).
///
/// The scale can be used to modify how the interval is displayed or mapped to the ruler's physical space,
/// making it more flexible in handling different measurement units and their corresponding ranges.
class UnitInterval {
  /// The scale factor for the interval, used to adjust the interval's size or behavior.
  /// The default value is 1.
  final double scale;

  /// The beginning value of the interval (inclusive).
  final int begin;

  /// The ending value of the interval (exclusive).
  final int end;

  /// Creates a [UnitInterval] with the specified [begin], [end], and optional [scale].
  ///
  /// The [begin] and [end] define the range of the interval, while the [scale] allows for adjusting the
  /// size or behavior of the interval on the ruler. If not provided, the [scale] defaults to 1.
  const UnitInterval({
    required this.begin,
    required this.end,
    this.scale = 1,
  });
}
