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

/// A controller for managing and notifying changes to a unit's value.
///
/// The [ScaleController] class extends [ValueNotifier] and is used to track a numeric value that represents
/// a specific unit (e.g., weight, length) on the ruler. It provides a way to notify listeners when the value
/// changes, enabling updates to the UI or other components that depend on the unit's current value.
///
/// [ScaleController] is designed to be used with widgets or other components that need to react to changes
/// in a unit's value, such as updating the ruler position or displaying the current measurement value.
class ScaleController extends ValueNotifier<num> {
  /// Creates a [ScaleController] with an initial value.
  ///
  /// The [initialValue] is the starting value for the controller. It sets the initial numeric value for the
  /// unit when the controller is first created.
  ScaleController({num value = 0}) : super(value);
// Additional methods or properties can be added here if needed.
}
