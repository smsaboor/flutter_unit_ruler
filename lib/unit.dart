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

import 'package:flutter_unit_ruler/ruler_range.dart';

/// Represents a unit of measurement with a unique ID, name, symbol,
/// unit group, and a list of unit intervals defining the measurement range.
class UnitName {
  /// The unique identifier for the unit (e.g., 11 for inch, 12 for centimeter).
  int id;

  /// The name of the unit (e.g., 'inch', 'centimeter').
  String name;

  /// The symbol representing the unit (e.g., 'in', 'cm').
  String symbol;

  /// The unit group category to which the unit belongs (e.g., 10 for length, 12 for weight).
  int unitGroup;

  /// A list of unit intervals representing ranges and scales for the unit.
  List<UnitInterval> unitIntervals;

  /// Creates an instance of [UnitName] with the specified [id], [name],
  /// [symbol], [unitGroup], and [unitIntervals].
  UnitName({
    required this.id,
    required this.name,
    required this.symbol,
    required this.unitGroup,
    required this.unitIntervals,
  });
}

/// Abstract class to provide static access to unit categories like
/// length and weight.
abstract class Unit {
  /// Returns the [Length] unit category.
  static Length get length => Length();

  /// Returns the [Weight] unit category.
  static Weight get weight => Weight();
}

/// Represents the unit category for length measurements (e.g., inch, centimeter).
class Length {
  /// A list of [UnitName] objects representing different length units.
  static List<UnitName> lengths = [
    UnitName(
      id: 11,
      name: 'inch',
      symbol: 'in',
      unitGroup: 12,
      unitIntervals: List.generate(
          10, (i) => UnitInterval(begin: i * 12, end: (i + 1) * 12, scale: 1)),
    ),
    UnitName(
      id: 12,
      name: 'centimeter',
      symbol: 'cm',
      unitGroup: 10,
      unitIntervals: List.generate(
          15, (i) => UnitInterval(begin: i * 20, end: (i + 1) * 20, scale: 1)),
    ),
  ];

  /// Returns the [UnitName] for inches.
  UnitName get inches => lengths[0];

  /// Returns the [UnitName] for centimeters.
  UnitName get centimeter => lengths[1];
}

/// Represents the unit category for weight measurements (e.g., kilogram, pounds).
class Weight {
  /// A list of [UnitName] objects representing different weight units.
  static List<UnitName> weights = [
    UnitName(
      id: 21,
      name: 'kilogram',
      symbol: 'kg',
      unitGroup: 10,
      unitIntervals: List.generate(
          35, (i) => UnitInterval(begin: i * 10, end: (i + 1) * 10, scale: 1)),
    ),
    UnitName(
      id: 22,
      name: 'pounds',
      symbol: 'lbs',
      unitGroup: 10,
      unitIntervals: List.generate(
          15, (i) => UnitInterval(begin: i * 10, end: (i + 1) * 10, scale: 1)),
    ),
  ];

  /// Returns the [UnitName] for kilograms.
  UnitName get kg => weights[0];

  /// Returns the [UnitName] for pounds.
  UnitName get lbs => weights[1];
}
