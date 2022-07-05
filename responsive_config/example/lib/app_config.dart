import 'package:flutter/material.dart';

import 'package:responsive_annotation/responsive_annotation.dart';

part 'app_config.g.dart';

@ResponsiveConfig()
abstract class AppConfig {
  const AppConfig({
    required this.margin,
    required this.title,
    required this.description,
  });

  factory AppConfig.of(BuildContext context) =>
      _$ResponsiveAppConfig.of(context);

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

  @ResponsiveVariable<String>(
    mobile: 'Using mobile config',
    tablet: 'Using tablet config',
    laptop: 'Using laptop config',
    desktop: 'Using desktop config',
    widescreen: 'Using widescreen config',
  )
  final String description;
}
