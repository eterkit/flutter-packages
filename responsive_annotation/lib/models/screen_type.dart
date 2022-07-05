// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Enum used to determine screen sizes.
enum ScreenType {
  /// ScreenType.mobile is used to determine if the screen
  /// is bigger than mobile breakpoint.
  mobile,

  /// ScreenType.tablet is used to determine if the screen
  /// is bigger than tablet breakpoint.
  tablet,

  /// ScreenType.laptop is used to determine if the screen
  /// is bigger than laptop breakpoint.
  laptop,

  /// ScreenType.desktop is used to determine if the screen
  /// is bigger than desktop breakpoint.
  desktop,

  /// ScreenType.widescreen is used to determine if the screen
  /// is bigger than widescreen breakpoint.
  widescreen,
}
