// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/element.dart';
import 'package:responsive_annotation/responsive_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'package:responsive_config/domain/variable.dart';

/// Basic class structure of a class annotated with [ResponsiveConfig].
class Class {
  /// Default constructor for the `Class`.
  const Class({
    required this.name,
    required this.desktopBreakpoint,
    required this.tabletBreakpoint,
    required this.laptopBreakpoint,
    required this.mobileBreakpoint,
    required this.widescreenBreakpoint,
    required this.variables,
  });

  /// Factory `fromElement` constructor
  /// for creating a [Class] from a [ClassElement].
  factory Class.fromElement(ClassElement element) {
    final name = element.name;

    const annotationChecker = TypeChecker.fromRuntime(ResponsiveConfig);
    final configAnnotation = annotationChecker.firstAnnotationOf(element);

    final reader = ConstantReader(configAnnotation);
    final desktopReader = reader.read('desktopBreakpoint');
    final tabletReader = reader.read('tabletBreakpoint');
    final laptopReader = reader.read('laptopBreakpoint');
    final mobileReader = reader.read('mobileBreakpoint');
    final widescreenReader = reader.read('widescreenBreakpoint');

    final desktopBreakpoint = desktopReader.isNull
        ? DefaultBreakpoints.desktop
        : desktopReader.doubleValue;
    final tabletBreakpoint = tabletReader.isNull
        ? DefaultBreakpoints.tablet
        : tabletReader.doubleValue;
    final laptopBreakpoint = laptopReader.isNull
        ? DefaultBreakpoints.laptop
        : laptopReader.doubleValue;
    final mobileBreakpoint = mobileReader.isNull
        ? DefaultBreakpoints.mobile
        : mobileReader.doubleValue;
    final widescreenBreakpoint = widescreenReader.isNull
        ? DefaultBreakpoints.widescreen
        : widescreenReader.doubleValue;

    Iterable<Variable> variables() sync* {
      for (final fieldElement in element.fields) {
        if (fieldElement.isStatic || !fieldElement.isFinal) continue;
        yield Variable.fromElement(fieldElement);
      }
    }

    return Class(
      name: name,
      desktopBreakpoint: desktopBreakpoint,
      tabletBreakpoint: tabletBreakpoint,
      laptopBreakpoint: laptopBreakpoint,
      mobileBreakpoint: mobileBreakpoint,
      widescreenBreakpoint: widescreenBreakpoint,
      variables: variables(),
    );
  }

  /// The name of the class.
  final String name;

  /// The breakpoint for `ScreenType.mobile`.
  final double mobileBreakpoint;

  /// The breakpoint for `ScreenType.tablet`.
  final double tabletBreakpoint;

  /// The breakpoint for `ScreenType.laptop`.
  final double laptopBreakpoint;

  /// The breakpoint for `ScreenType.desktop`.
  final double desktopBreakpoint;

  /// The breakpoint for `ScreenType.widescreen`.
  final double widescreenBreakpoint;

  /// All variables annotated with `@ResponsiveVariable<T>`
  /// of the annotated class.
  final Iterable<Variable> variables;
}
