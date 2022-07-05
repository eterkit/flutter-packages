// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// ResponsiveConfigGenerator
// **************************************************************************

abstract class _$ResponsiveExample {
  static Example of(BuildContext context) {
    final screenType = _getScreenType(context);
    switch (screenType) {
      case ScreenType.mobile:
        return _$MobileExample();
      case ScreenType.tablet:
        return _$TabletExample();
      case ScreenType.laptop:
        return _$LaptopExample();
      case ScreenType.desktop:
        return _$DesktopExample();
      case ScreenType.widescreen:
        return _$WidescreenExample();
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

class _$MobileExample implements Example {
  @override
  final double margin = 32.0;
  @override
  final String title = 'Mobile';
}

class _$TabletExample implements Example {
  @override
  final double margin = 64.0;
  @override
  final String title = 'Tablet';
}

class _$LaptopExample implements Example {
  @override
  final double margin = 96.0;
  @override
  final String title = 'Laptop';
}

class _$DesktopExample implements Example {
  @override
  final double margin = 128.0;
  @override
  final String title = 'Desktop';
}

class _$WidescreenExample implements Example {
  @override
  final double margin = 256.0;
  @override
  final String title = 'Widescreen';
}
