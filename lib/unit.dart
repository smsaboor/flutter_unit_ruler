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
  static Length get length => Length._instance;

  /// Returns the [Weight] unit category.
  static Weight get weight => Weight();
}

/// Represents the unit category for length measurements (e.g., inch, centimeter).
class Length {
  /// The singleton instance of [Length].
  static final Length _instance = Length._internal();
  /// Private constructor for the singleton instance.
  Length._internal();
  /// Provides access to the singleton instance of [Length].
  factory Length() => _instance;

  /// A list of [UnitName] objects representing different length units.
  static List<UnitName> lengths = [
    UnitName(
      name: 'kilometer',
      symbol: 'km',
      unitGroup: 10,
      unitIntervals: List.generate(
          10, (i) => UnitInterval(begin: i * 1000, end: (i + 1) * 1000, scale: 1)),
    ),
    UnitName(
      name: 'meter',
      symbol: 'm',
      unitGroup: 10,
      unitIntervals: List.generate(
          10, (i) => UnitInterval(begin: i * 100, end: (i + 1) * 100, scale: 1)),
    ),
    UnitName(
      name: 'centimeter',
      symbol: 'cm',
      unitGroup: 10,
      unitIntervals: List.generate(
          15, (i) => UnitInterval(begin: i * 10, end: (i + 1) * 10, scale: 1)),
    ),
    UnitName(
      name: 'millimeter',
      symbol: 'mm',
      unitGroup: 10,
      unitIntervals: List.generate(
          20, (i) => UnitInterval(begin: i * 10, end: (i + 1) * 10, scale: 1)),
    ),
    UnitName(
      name: 'micrometer',
      symbol: 'µm',
      unitGroup: 10,
      unitIntervals: List.generate(
          50, (i) => UnitInterval(begin: i * 10, end: (i + 1) * 10, scale: 1)),
    ),
    UnitName(
      name: 'nanometer',
      symbol: 'nm',
      unitGroup: 10,
      unitIntervals: List.generate(
          100, (i) => UnitInterval(begin: i * 10, end: (i + 1) * 10, scale: 1)),
    ),
    UnitName(
      name: 'mile',
      symbol: 'mi',
      unitGroup: 10,
      unitIntervals: List.generate(
          5, (i) => UnitInterval(begin: i * 5280, end: (i + 1) * 5280, scale: 1)),
    ),
    UnitName(
      name: 'yard',
      symbol: 'yd',
      unitGroup: 10,
      unitIntervals: List.generate(
          200, (i) => UnitInterval(begin: i * 3, end: (i + 1) * 3, scale: 1)),
    ),
    UnitName(
      name: 'foot',
      symbol: 'ft',
      unitGroup: 10,
      unitIntervals: List.generate(
          10, (i) => UnitInterval(begin: i * 12, end: (i + 1) * 12, scale: 1)),
    ),
    UnitName(
      name: 'inch',
      symbol: 'in',
      unitGroup: 12,
      unitIntervals: List.generate(
          10, (i) => UnitInterval(begin: i * 12, end: (i + 1) * 12, scale: 1)),
    ),
    UnitName(
      name: 'nautical mile',
      symbol: 'nmi',
      unitGroup: 10,
      unitIntervals: List.generate(
          5, (i) => UnitInterval(begin: i * 1852, end: (i + 1) * 1852, scale: 1)),
    ),
  ];

  /// Returns the [UnitName] for kilometers.
  UnitName get kilometer => lengths[0];

  /// Returns the [UnitName] for meters.
  UnitName get meter => lengths[1];

  /// Returns the [UnitName] for centimeters.
  UnitName get centimeter => lengths[2];

  /// Returns the [UnitName] for millimeters.
  UnitName get millimeter => lengths[3];

  /// Returns the [UnitName] for micrometers.
  UnitName get micrometer => lengths[4];

  /// Returns the [UnitName] for nanometers.
  UnitName get nanometer => lengths[5];

  /// Returns the [UnitName] for miles.
  UnitName get mile => lengths[6];

  /// Returns the [UnitName] for yards.
  UnitName get yard => lengths[7];

  /// Returns the [UnitName] for feet.
  UnitName get foot => lengths[8];

  /// Returns the [UnitName] for inches.
  UnitName get inch => lengths[9];

  /// Returns the [UnitName] for nautical miles.
  UnitName get nauticalMile => lengths[10];
}


/// Represents the unit category for weight measurements (e.g., kilogram, pounds).
class Weight {
  /// The singleton instance of [Weight].
  static final Weight _instance = Weight._internal();
  /// Private constructor for the singleton instance.
  Weight._internal();
  /// Provides access to the singleton instance of [Length].
  factory Weight() => _instance;

  /// A list of [UnitName] objects representing different weight units.
  static List<UnitName> weights = [
    UnitName(
      name: 'gram',
      symbol: 'g',
      unitGroup: 10,
      unitIntervals: List.generate(
          50, (i) => UnitInterval(begin: i * 100, end: (i + 1) * 100, scale: 1)),
    ),
    UnitName(
      name: 'tonne',
      symbol: 't',
      unitGroup: 10,
      unitIntervals: List.generate(
          10, (i) => UnitInterval(begin: i * 1000, end: (i + 1) * 1000, scale: 1)),
    ),
    UnitName(
      name: 'kilogram',
      symbol: 'kg',
      unitGroup: 10,
      unitIntervals: List.generate(
          35, (i) => UnitInterval(begin: i * 10, end: (i + 1) * 10, scale: 1)),
    ),
    UnitName(
      name: 'milligram',
      symbol: 'mg',
      unitGroup: 10,
      unitIntervals: List.generate(
          50, (i) => UnitInterval(begin: i * 100, end: (i + 1) * 100, scale: 1)),
    ),
    UnitName(
      name: 'microgram',
      symbol: 'µg',
      unitGroup: 10,
      unitIntervals: List.generate(
          50, (i) => UnitInterval(begin: i * 100, end: (i + 1) * 100, scale: 1)),
    ),
    UnitName(
      name: 'imperial ton',
      symbol: 'imp ton',
      unitGroup: 10,
      unitIntervals: List.generate(
          5, (i) => UnitInterval(begin: i * 1016, end: (i + 1) * 1016, scale: 1)),
    ),
    UnitName(
      name: 'US ton',
      symbol: 'ton',
      unitGroup: 10,
      unitIntervals: List.generate(
          5, (i) => UnitInterval(begin: i * 907, end: (i + 1) * 907, scale: 1)),
    ),
    UnitName(
      name: 'stone',
      symbol: 'st',
      unitGroup: 10,
      unitIntervals: List.generate(
          10, (i) => UnitInterval(begin: i * 6, end: (i + 1) * 6, scale: 1)),
    ),
    UnitName(
      name: 'pound',
      symbol: 'lb',
      unitGroup: 10,
      unitIntervals: List.generate(
          15, (i) => UnitInterval(begin: i * 10, end: (i + 1) * 10, scale: 1)),
    ),
    UnitName(
      name: 'ounce',
      symbol: 'oz',
      unitGroup: 10,
      unitIntervals: List.generate(
          20, (i) => UnitInterval(begin: i * 16, end: (i + 1) * 16, scale: 1)),
    ),
  ];

  /// Returns the [UnitName] for grams.
  UnitName get gram => weights[0];

  /// Returns the [UnitName] for tonnes.
  UnitName get tonne => weights[1];

  /// Returns the [UnitName] for kilograms.
  UnitName get kilogram => weights[2];

  /// Returns the [UnitName] for milligrams.
  UnitName get milligram => weights[3];

  /// Returns the [UnitName] for micrograms.
  UnitName get microgram => weights[4];

  /// Returns the [UnitName] for imperial tons.
  UnitName get imperialTon => weights[5];

  /// Returns the [UnitName] for US tons.
  UnitName get usTon => weights[6];

  /// Returns the [UnitName] for stones.
  UnitName get stone => weights[7];

  /// Returns the [UnitName] for pounds.
  UnitName get pound => weights[8];

  /// Returns the [UnitName] for ounces.
  UnitName get ounce => weights[9];
}

