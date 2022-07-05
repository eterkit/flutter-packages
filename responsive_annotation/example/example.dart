import 'package:flutter/material.dart';

import 'package:responsive_annotation/responsive_annotation.dart';

part 'example.g.dart';

@ResponsiveConfig()
abstract class Example {
  const Example({
    required this.margin,
    required this.title,
  });

  factory Example.of(BuildContext context) => _$ResponsiveExample.of(context);

  @ResponsiveVariable<double>(
    mobile: 32,
    tablet: 64,
    laptop: 96,
    desktop: 128,
    widescreen: 256,
  )
  final double margin;

  @ResponsiveVariable<String>(
    mobile: 'Mobile',
    tablet: 'Tablet',
    laptop: 'Laptop',
    desktop: 'Desktop',
    widescreen: 'Widescreen',
  )
  final String title;
}
