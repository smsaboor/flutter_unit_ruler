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

class UnitName {
  int id;
  String name;
  String symbol;
  int unitGroup;
  List<UnitInterval> unitIntervals;
  UnitName({required this.id, required this.name, required this.symbol, required this.unitGroup, required this.unitIntervals});
}

abstract class Unit {
  static Length get length => Length();
  static Weight get weight => Weight();
}

class Length {
  static List<UnitName> lengths = [
    UnitName(id: 11, name: 'inch', symbol: 'in', unitGroup: 12, unitIntervals:List.generate(10, (i) => UnitInterval(begin: i * 12, end: (i + 1) * 12, scale: 1)) ),
    UnitName(id: 12, name: 'centimeter', symbol: 'cm', unitGroup: 10, unitIntervals: List.generate(15, (i) => UnitInterval(begin: i * 20, end: (i + 1) * 20, scale: 1)) )
  ];

  UnitName get inches => lengths[0];

  UnitName get centimeter => lengths[1];
}

class Weight {
  List<UnitName> weights = [
    UnitName(id: 21, name: 'kilogram', symbol: 'kg',  unitGroup: 10, unitIntervals: [
      const UnitInterval(begin: 0, end: 10, scale: 1),
      const UnitInterval(begin: 10, end: 20, scale: 1),
      const UnitInterval(begin: 20, end: 30, scale: 1),
      const UnitInterval(begin: 30, end: 40, scale: 1),
      const UnitInterval(begin: 40, end: 50, scale: 1),
      const UnitInterval(begin: 50, end: 60, scale: 1),
      const UnitInterval(begin: 60, end: 70, scale: 1), // Expanded to 100
      const UnitInterval(begin: 70, end: 80, scale: 1), // Expanded to 200
      const UnitInterval(begin: 80, end: 90, scale: 1),
      const UnitInterval(begin: 90, end: 100, scale: 1),
      const UnitInterval(begin: 100, end: 110, scale: 1),
      const UnitInterval(begin: 110, end: 120, scale: 1),
      const UnitInterval(begin: 120, end: 130, scale: 1),
      const UnitInterval(begin: 130, end: 140, scale: 1),
      const UnitInterval(begin: 140, end: 150, scale: 1),
      const UnitInterval(begin: 150, end: 160, scale: 1),
      const UnitInterval(begin: 160, end: 170, scale: 1),
      const UnitInterval(begin: 170, end: 180, scale: 1),
      const UnitInterval(begin: 180, end: 190, scale: 1),
      const UnitInterval(begin: 190, end: 200, scale: 1),
      const UnitInterval(begin: 200, end: 210, scale: 1),
      const UnitInterval(begin: 210, end: 220, scale: 1),
      const UnitInterval(begin: 220, end: 230, scale: 1),
      const UnitInterval(begin: 230, end: 240, scale: 1),
      const UnitInterval(begin: 240, end: 250, scale: 1),
      const UnitInterval(begin: 250, end: 260, scale: 1),
      const UnitInterval(begin: 260, end: 270, scale: 1),
      const UnitInterval(begin: 270, end: 280, scale: 1),
      const UnitInterval(begin: 280, end: 290, scale: 1),
      const UnitInterval(begin: 290, end: 300, scale: 1),
      const UnitInterval(begin: 300, end: 310, scale: 1),
      const UnitInterval(begin: 310, end: 320, scale: 1),
      const UnitInterval(begin: 320, end: 330, scale: 1),
      const UnitInterval(begin: 330, end: 340, scale: 1),
      const UnitInterval(begin: 340, end: 350, scale: 1),
      const UnitInterval(begin: 350, end: 360, scale: 1),
      const UnitInterval(begin: 360, end: 370, scale: 1),
      const UnitInterval(begin: 370, end: 380, scale: 1),
      const UnitInterval(begin: 380, end: 390, scale: 1),
      const UnitInterval(begin: 390, end: 400, scale: 1),
      const UnitInterval(begin: 400, end: 410, scale: 1),
    ]),
    UnitName(id: 22, name: 'pound', symbol: 'lbs',  unitGroup: 10, unitIntervals: [
      const UnitInterval(begin: 0, end: 10, scale: 1),
      const UnitInterval(begin: 10, end: 20, scale: 1),
      const UnitInterval(begin: 20, end: 30, scale: 1),
      const UnitInterval(begin: 30, end: 40, scale: 1),
      const UnitInterval(begin: 40, end: 50, scale: 1),
      const UnitInterval(begin: 50, end: 60, scale: 1),
      const UnitInterval(begin: 60, end: 70, scale: 1), // Expanded to 100
      const UnitInterval(begin: 70, end: 80, scale: 1), // Expanded to 200
      const UnitInterval(begin: 80, end: 90, scale: 1),
      const UnitInterval(begin: 90, end: 100, scale: 1),
      const UnitInterval(begin: 100, end: 110, scale: 1),
      const UnitInterval(begin: 110, end: 120, scale: 1),
      const UnitInterval(begin: 120, end: 130, scale: 1),
      const UnitInterval(begin: 130, end: 140, scale: 1),
      const UnitInterval(begin: 140, end: 150, scale: 1),
      const UnitInterval(begin: 150, end: 160, scale: 1), // Expanded to 1000
      const UnitInterval(begin: 160, end: 170, scale: 1),
      const UnitInterval(begin: 170, end: 180, scale: 1),
      const UnitInterval(begin: 180, end: 190, scale: 1), // Expanded to 1000
      const UnitInterval(begin: 190, end: 200, scale: 1),
      const UnitInterval(begin: 200, end: 210, scale: 1),
      const UnitInterval(begin: 210, end: 220, scale: 1), // Expanded to 1000
      const UnitInterval(begin: 220, end: 230, scale: 1),
      const UnitInterval(begin: 230, end: 240, scale: 1),
      const UnitInterval(begin: 240, end: 250, scale: 1), // Expanded to 1000
      const UnitInterval(begin: 250, end: 260, scale: 1),
      const UnitInterval(begin: 260, end: 270, scale: 1),
      const UnitInterval(begin: 270, end: 280, scale: 1), // Expanded to 1000
      const UnitInterval(begin: 280, end: 290, scale: 1),
      const UnitInterval(begin: 290, end: 300, scale: 1),
      const UnitInterval(begin: 300, end: 310, scale: 1),
      const UnitInterval(begin: 310, end: 320, scale: 1),
      const UnitInterval(begin: 320, end: 330, scale: 1),
      const UnitInterval(begin: 330, end: 340, scale: 1),
      const UnitInterval(begin: 340, end: 350, scale: 1),
      const UnitInterval(begin: 350, end: 360, scale: 1),
      const UnitInterval(begin: 360, end: 370, scale: 1),
      const UnitInterval(begin: 370, end: 380, scale: 1),
      const UnitInterval(begin: 380, end: 390, scale: 1),
      const UnitInterval(begin: 390, end: 400, scale: 1),
      const UnitInterval(begin: 400, end: 410, scale: 1),
      const UnitInterval(begin: 410, end: 420, scale: 1),
      const UnitInterval(begin: 420, end: 430, scale: 1),
      const UnitInterval(begin: 430, end: 440, scale: 1),
      const UnitInterval(begin: 440, end: 450, scale: 1),
      const UnitInterval(begin: 450, end: 460, scale: 1),
      const UnitInterval(begin: 460, end: 470, scale: 1),
      const UnitInterval(begin: 470, end: 480, scale: 1),
      const UnitInterval(begin: 480, end: 490, scale: 1),
      const UnitInterval(begin: 490, end: 500, scale: 1),
      const UnitInterval(begin: 500, end: 510, scale: 1),
      const UnitInterval(begin: 510, end: 520, scale: 1),
      const UnitInterval(begin: 520, end: 530, scale: 1),
      const UnitInterval(begin: 530, end: 540, scale: 1),
      const UnitInterval(begin: 540, end: 550, scale: 1),
      const UnitInterval(begin: 550, end: 560, scale: 1),
      const UnitInterval(begin: 560, end: 570, scale: 1),
      const UnitInterval(begin: 570, end: 580, scale: 1),
      const UnitInterval(begin: 580, end: 590, scale: 1),
      const UnitInterval(begin: 590, end: 600, scale: 1),
      const UnitInterval(begin: 600, end: 610, scale: 1),
      const UnitInterval(begin: 610, end: 620, scale: 1),
      const UnitInterval(begin: 620, end: 630, scale: 1),
      const UnitInterval(begin: 630, end: 640, scale: 1),
      const UnitInterval(begin: 640, end: 650, scale: 1),
      const UnitInterval(begin: 650, end: 660, scale: 1),
      const UnitInterval(begin: 660, end: 670, scale: 1),
      const UnitInterval(begin: 670, end: 680, scale: 1),
      const UnitInterval(begin: 680, end: 690, scale: 1),
      const UnitInterval(begin: 690, end: 700, scale: 1),
      const UnitInterval(begin: 700, end: 710, scale: 1),
      const UnitInterval(begin: 710, end: 720, scale: 1),
      const UnitInterval(begin: 720, end: 730, scale: 1),
      const UnitInterval(begin: 730, end: 740, scale: 1),
      const UnitInterval(begin: 740, end: 750, scale: 1),
      const UnitInterval(begin: 750, end: 760, scale: 1),
      const UnitInterval(begin: 760, end: 770, scale: 1),
      const UnitInterval(begin: 770, end: 780, scale: 1),
      const UnitInterval(begin: 780, end: 790, scale: 1),
      const UnitInterval(begin: 790, end: 800, scale: 1),
      const UnitInterval(begin: 800, end: 810, scale: 1),
      const UnitInterval(begin: 810, end: 820, scale: 1),
      const UnitInterval(begin: 820, end: 830, scale: 1),
      const UnitInterval(begin: 830, end: 840, scale: 1),
      const UnitInterval(begin: 840, end: 850, scale: 1),
      const UnitInterval(begin: 850, end: 860, scale: 1),
      const UnitInterval(begin: 860, end: 870, scale: 1),
      const UnitInterval(begin: 870, end: 880, scale: 1),
      const UnitInterval(begin: 880, end: 890, scale: 1),
      const UnitInterval(begin: 890, end: 900, scale: 1),
    ])
    ];

  UnitName get kg => weights[0];
  UnitName get lbs => weights[1];
}
