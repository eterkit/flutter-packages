// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_config.dart';

// **************************************************************************
// ResponsiveConfigGenerator
// **************************************************************************

// ignore_for_file: prefer_const_constructors, prefer_int_literals

abstract class _$ResponsiveAppConfig {
  static AppConfig of(BuildContext context) {
    final screenType = _getScreenType(context);
    switch (screenType) {
      case ScreenType.mobile:
        return _$MobileAppConfig();
      case ScreenType.tablet:
        return _$TabletAppConfig();
      case ScreenType.laptop:
        return _$LaptopAppConfig();
      case ScreenType.desktop:
        return _$DesktopAppConfig();
      case ScreenType.widescreen:
        return _$WidescreenAppConfig();
    }
  }

  static ScreenType _getScreenType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 2100.0) {
      return ScreenType.widescreen;
    } else if (width >= 1200.0) {
      return ScreenType.desktop;
    } else if (width >= 992.0) {
      return ScreenType.laptop;
    } else if (width >= 640.0) {
      return ScreenType.tablet;
    } else {
      return ScreenType.mobile;
    }
  }
}

class _$MobileAppConfig implements AppConfig {
  @override
  final double margin = 32.0;
  @override
  final String title = 'Mobile';
  @override
  final String description = 'Using mobile config';
}

class _$TabletAppConfig implements AppConfig {
  @override
  final double margin = 64.0;
  @override
  final String title = 'Tablet';
  @override
  final String description = 'Using tablet config';
}

class _$LaptopAppConfig implements AppConfig {
  @override
  final double margin = 96.0;
  @override
  final String title = 'Laptop';
  @override
  final String description = 'Using laptop config';
}

class _$DesktopAppConfig implements AppConfig {
  @override
  final double margin = 128.0;
  @override
  final String title = 'Desktop';
  @override
  final String description = 'Using desktop config';
}

class _$WidescreenAppConfig implements AppConfig {
  @override
  final double margin = 256.0;
  @override
  final String title = 'Widescreen';
  @override
  final String description = 'Using widescreen config';
}
