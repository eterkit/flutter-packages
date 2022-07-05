// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:meta/meta_meta.dart';

import 'package:responsive_annotation/models/screen_type.dart';

/// An annotation used to specify a variable to generate responsive code for.
/// Can only be used on non static final fields.
@Target({TargetKind.field})
class ResponsiveVariable<T> {
  /// ResponsiveVariable<T> is used to annotate variables that are responsive.
  /// * [mobile] is the value applied for [ScreenType.mobile].
  /// * [tablet] is the value applied for [ScreenType.tablet].
  /// * [laptop] is the value applied for [ScreenType.laptop].
  /// * [desktop] is the value applied for [ScreenType.desktop].
  /// * [widescreen] is the value applied for [ScreenType.widescreen].
  ///
  /// Note that you can only provide simple types [T]
  /// or non parameterized default constructors as custom type [T].
  /// Parametrized and/or named constructors are not supported yet.
  const ResponsiveVariable({
    required this.mobile,
    required this.tablet,
    required this.laptop,
    required this.desktop,
    required this.widescreen,
  })  : type = T,
        assert(mobile != null),
        assert(tablet != null),
        assert(laptop != null),
        assert(desktop != null),
        assert(widescreen != null);

  /// Value used for [ScreenType.mobile]. Must not be null.
  /// It should be of a basic type or a non parameterized default constructor.
  final T mobile;

  /// Value used for [ScreenType.tablet]. Must not be null.
  /// It should be of a basic type or a non parameterized default constructor.
  final T tablet;

  /// Value used for [ScreenType.laptop]. Must not be null.
  /// It should be of a basic type or a non parameterized default constructor.
  final T laptop;

  /// Value used for [ScreenType.desktop]. Must not be null.
  /// It should be of a basic type or a non parameterized default constructor.
  final T desktop;

  /// Value used for [ScreenType.widescreen]. Must not be null.
  /// It should be of a basic type or a non parameterized default constructor.
  final T widescreen;

  /// Type of the variable is set automatically from the annotation.
  /// It should be of a basic type or a non parameterized default constructor.
  final Type type;
}
