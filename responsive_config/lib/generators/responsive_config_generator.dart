// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:responsive_annotation/annotations/responsive_config.dart';
import 'package:source_gen/source_gen.dart';

import 'package:responsive_config/domain/class.dart';
import 'package:responsive_config/templates/responsive_generator_template.dart';

/// Generator for `responsive_config` library.
/// Generates responsive code for classes annotated with [ResponsiveConfig].
class ResponsiveConfigGenerator
    extends GeneratorForAnnotation<ResponsiveConfig> {
  /// Default constructor for [ResponsiveConfigGenerator].
  ResponsiveConfigGenerator(this.options);

  /// Options for the [ResponsiveConfigGenerator].
  /// Can be provided directly to the [ResponsiveConfig] annotation
  /// or specified in the `build.yaml` file.
  final BuilderOptions options;

  @override
  dynamic generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        'Could not generate for non-class $element',
      );
    }
    final subject = Class.fromElement(element);
    final config = ResponsiveConfig.fromJson(options.config);
    return ResponsiveGeneratorTemplate(subject, config).generate();
  }
}
