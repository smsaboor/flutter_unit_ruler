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

import 'package:flutter_unit_ruler/scale_interval.dart';

/// Represents a unit of measurement with a unique ID, name, symbol,
/// unit group, and a list of unit intervals defining the measurement range.
class ScaleUnit {
  /// The name of the unit (e.g., 'inch', 'centimeter').
  String name;

  /// The symbol representing the unit (e.g., 'in', 'cm').
  String symbol;

  /// The unit group category to which the unit belongs (e.g., 10 for centimeter, 12 for inches).
  int subDivisionCount;

  /// A list of unit scale intervals representing ranges and scales for the unit.
  List<ScaleIntervals> scaleIntervals;

  /// Creates an instance of [ScaleUnit] with the specified [id], [name],
  /// [symbol], [subDivisionCount], and [scaleIntervals].
  ScaleUnit({
    required this.name,
    required this.symbol,
    required this.subDivisionCount,
    required this.scaleIntervals,
  });
}

/// Abstract class to provide static access to unit categories like
/// length and weight.
abstract class UnitType {
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

  /// A list of [ScaleUnit] objects representing different length units.
  static List<ScaleUnit> lengths = [
    ScaleUnit(
      name: 'kilometer',
      symbol: 'km',
      subDivisionCount: 10,
      scaleIntervals: List.generate(
          10, (i) => ScaleIntervals(begin: i * 1000, end: (i + 1) * 1000, scale: 1)),
    ),
    ScaleUnit(
      name: 'meter',
      symbol: 'm',
      subDivisionCount: 10,
      scaleIntervals: List.generate(
          10, (i) => ScaleIntervals(begin: i * 100, end: (i + 1) * 100, scale: 1)),
    ),
    ScaleUnit(
      name: 'centimeter',
      symbol: 'cm',
      subDivisionCount: 10,
      scaleIntervals: List.generate(
          15, (i) => ScaleIntervals(begin: i * 10, end: (i + 1) * 10, scale: 1)),
    ),
    ScaleUnit(
      name: 'millimeter',
      symbol: 'mm',
      subDivisionCount: 10,
      scaleIntervals: List.generate(
          20, (i) => ScaleIntervals(begin: i * 10, end: (i + 1) * 10, scale: 1)),
    ),
    ScaleUnit(
      name: 'micrometer',
      symbol: 'µm',
      subDivisionCount: 10,
      scaleIntervals: List.generate(
          50, (i) => ScaleIntervals(begin: i * 10, end: (i + 1) * 10, scale: 1)),
    ),
    ScaleUnit(
      name: 'nanometer',
      symbol: 'nm',
      subDivisionCount: 10,
      scaleIntervals: List.generate(
          100, (i) => ScaleIntervals(begin: i * 10, end: (i + 1) * 10, scale: 1)),
    ),
    ScaleUnit(
      name: 'mile',
      symbol: 'mi',
      subDivisionCount: 10,
      scaleIntervals: List.generate(
          5, (i) => ScaleIntervals(begin: i * 5280, end: (i + 1) * 5280, scale: 1)),
    ),
    ScaleUnit(
      name: 'yard',
      symbol: 'yd',
      subDivisionCount: 10,
      scaleIntervals: List.generate(
          200, (i) => ScaleIntervals(begin: i * 3, end: (i + 1) * 3, scale: 1)),
    ),
    ScaleUnit(
      name: 'foot',
      symbol: 'ft',
      subDivisionCount: 10,
      scaleIntervals: List.generate(
          10, (i) => ScaleIntervals(begin: i * 12, end: (i + 1) * 12, scale: 1)),
    ),
    ScaleUnit(
      name: 'inch',
      symbol: 'in',
      subDivisionCount: 12,
      scaleIntervals: List.generate(
          10, (i) => ScaleIntervals(begin: i * 12, end: (i + 1) * 12, scale: 1)),
    ),
    ScaleUnit(
      name: 'nautical mile',
      symbol: 'nmi',
      subDivisionCount: 10,
      scaleIntervals: List.generate(
          5, (i) => ScaleIntervals(begin: i * 1852, end: (i + 1) * 1852, scale: 1)),
    ),
  ];

  /// Returns the [ScaleUnit] for kilometers.
  ScaleUnit get kilometer => lengths[0];

  /// Returns the [ScaleUnit] for meters.
  ScaleUnit get meter => lengths[1];

  /// Returns the [ScaleUnit] for centimeters.
  ScaleUnit get centimeter => lengths[2];

  /// Returns the [ScaleUnit] for millimeters.
  ScaleUnit get millimeter => lengths[3];

  /// Returns the [ScaleUnit] for micrometers.
  ScaleUnit get micrometer => lengths[4];

  /// Returns the [ScaleUnit] for nanometers.
  ScaleUnit get nanometer => lengths[5];

  /// Returns the [ScaleUnit] for miles.
  ScaleUnit get mile => lengths[6];

  /// Returns the [ScaleUnit] for yards.
  ScaleUnit get yard => lengths[7];

  /// Returns the [ScaleUnit] for feet.
  ScaleUnit get foot => lengths[8];

  /// Returns the [ScaleUnit] for inches.
  ScaleUnit get inch => lengths[9];

  /// Returns the [ScaleUnit] for nautical miles.
  ScaleUnit get nauticalMile => lengths[10];
}


/// Represents the unit category for weight measurements (e.g., kilogram, pounds).
class Weight {
  /// The singleton instance of [Weight].
  static final Weight _instance = Weight._internal();
  /// Private constructor for the singleton instance.
  Weight._internal();
  /// Provides access to the singleton instance of [Length].
  factory Weight() => _instance;

  /// A list of [ScaleUnit] objects representing different weight units.
  static List<ScaleUnit> weights = [
    ScaleUnit(
      name: 'gram',
      symbol: 'g',
      subDivisionCount: 10,
      scaleIntervals: List.generate(
          50, (i) => ScaleIntervals(begin: i * 100, end: (i + 1) * 100, scale: 1)),
    ),
    ScaleUnit(
      name: 'tonne',
      symbol: 't',
      subDivisionCount: 10,
      scaleIntervals: List.generate(
          10, (i) => ScaleIntervals(begin: i * 1000, end: (i + 1) * 1000, scale: 1)),
    ),
    ScaleUnit(
      name: 'kilogram',
      symbol: 'kg',
      subDivisionCount: 10,
      scaleIntervals: List.generate(
          35, (i) => ScaleIntervals(begin: i * 10, end: (i + 1) * 10, scale: 1)),
    ),
    ScaleUnit(
      name: 'milligram',
      symbol: 'mg',
      subDivisionCount: 10,
      scaleIntervals: List.generate(
          50, (i) => ScaleIntervals(begin: i * 100, end: (i + 1) * 100, scale: 1)),
    ),
    ScaleUnit(
      name: 'microgram',
      symbol: 'µg',
      subDivisionCount: 10,
      scaleIntervals: List.generate(
          50, (i) => ScaleIntervals(begin: i * 100, end: (i + 1) * 100, scale: 1)),
    ),
    ScaleUnit(
      name: 'imperial ton',
      symbol: 'imp ton',
      subDivisionCount: 10,
      scaleIntervals: List.generate(
          5, (i) => ScaleIntervals(begin: i * 1016, end: (i + 1) * 1016, scale: 1)),
    ),
    ScaleUnit(
      name: 'US ton',
      symbol: 'ton',
      subDivisionCount: 10,
      scaleIntervals: List.generate(
          5, (i) => ScaleIntervals(begin: i * 907, end: (i + 1) * 907, scale: 1)),
    ),
    ScaleUnit(
      name: 'stone',
      symbol: 'st',
      subDivisionCount: 10,
      scaleIntervals: List.generate(
          10, (i) => ScaleIntervals(begin: i * 6, end: (i + 1) * 6, scale: 1)),
    ),
    ScaleUnit(
      name: 'pound',
      symbol: 'lb',
      subDivisionCount: 10,
      scaleIntervals: List.generate(
          15, (i) => ScaleIntervals(begin: i * 10, end: (i + 1) * 10, scale: 1)),
    ),
    ScaleUnit(
      name: 'ounce',
      symbol: 'oz',
      subDivisionCount: 10,
      scaleIntervals: List.generate(
          20, (i) => ScaleIntervals(begin: i * 16, end: (i + 1) * 16, scale: 1)),
    ),
  ];

  /// Returns the [ScaleUnit] for grams.
  ScaleUnit get gram => weights[0];

  /// Returns the [ScaleUnit] for tonnes.
  ScaleUnit get tonne => weights[1];

  /// Returns the [ScaleUnit] for kilograms.
  ScaleUnit get kilogram => weights[2];

  /// Returns the [ScaleUnit] for milligrams.
  ScaleUnit get milligram => weights[3];

  /// Returns the [ScaleUnit] for micrograms.
  ScaleUnit get microgram => weights[4];

  /// Returns the [ScaleUnit] for imperial tons.
  ScaleUnit get imperialTon => weights[5];

  /// Returns the [ScaleUnit] for US tons.
  ScaleUnit get usTon => weights[6];

  /// Returns the [ScaleUnit] for stones.
  ScaleUnit get stone => weights[7];

  /// Returns the [ScaleUnit] for pounds.
  ScaleUnit get pound => weights[8];

  /// Returns the [ScaleUnit] for ounces.
  ScaleUnit get ounce => weights[9];
}

