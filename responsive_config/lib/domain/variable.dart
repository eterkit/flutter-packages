// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:responsive_annotation/responsive_annotation.dart';
import 'package:source_gen/source_gen.dart';

/// Basic class structure of a class annotated with [ResponsiveVariable]
class Variable {
  /// Default constructor for the [Variable].
  const Variable({
    required this.name,
    required this.type,
    required this.mobile,
    required this.tablet,
    required this.laptop,
    required this.desktop,
    required this.widescreen,
  });

  /// Factory `fromElement` constructor
  /// for creating a [Variable] from a [FieldElement].
  factory Variable.fromElement(FieldElement element) {
    const annotationChecker = TypeChecker.fromRuntime(ResponsiveVariable);
    final variableAnnotation = annotationChecker.firstAnnotationOf(element);

    dynamic type;
    dynamic mobile;
    dynamic tablet;
    dynamic laptop;
    dynamic desktop;
    dynamic widescreen;

    if (variableAnnotation != null) {
      final reader = ConstantReader(variableAnnotation);
      final mobileReader = reader.read('mobile');
      final tabletReader = reader.read('tablet');
      final laptopReader = reader.read('laptop');
      final desktopReader = reader.read('desktop');
      final widescreenReader = reader.read('widescreen');

      type = reader.read('type').typeValue;
      mobile = mobileReader.isLiteral
          ? mobileReader.literalValue
          : '${mobileReader.objectValue.type}()';
      tablet = tabletReader.isLiteral
          ? tabletReader.literalValue
          : '${tabletReader.objectValue.type}()';
      laptop = laptopReader.isLiteral
          ? laptopReader.literalValue
          : '${laptopReader.objectValue.type}()';
      desktop = desktopReader.isLiteral
          ? desktopReader.literalValue
          : '${desktopReader.objectValue.type}()';
      widescreen = widescreenReader.isLiteral
          ? widescreenReader.literalValue
          : '${widescreenReader.objectValue.type}()';
    }

    return Variable(
      name: element.name,
      type: type as DartType,
      mobile: mobile,
      tablet: tablet,
      laptop: laptop,
      desktop: desktop,
      widescreen: widescreen,
    );
  }

  /// The name of the variable.
  final String name;

  /// The type of the variable.
  final DartType type;

  /// The value of this variable for the mobile screen type.
  final dynamic mobile;

  /// The value of this variable for the tablet screen type.
  final dynamic tablet;

  /// The value of this variable for the laptop screen type.
  final dynamic laptop;

  /// The value of this variable for the desktop screen type.
  final dynamic desktop;

  /// The value of this variable for the widescreen screen type.
  final dynamic widescreen;
}
