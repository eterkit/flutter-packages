import 'package:flutter_test/flutter_test.dart';

import 'package:responsive_annotation/annotations/responsive_config.dart';

void main() {
  const double customDesktopBreakpoint = 999;
  const double customTabletBreakpoint = 777;
  const double customMobileBreakpoint = 333;

  const Map<String, dynamic> validConfigJson = <String, dynamic>{
    'desktop_breakpoint': customDesktopBreakpoint,
    'tablet_breakpoint': customTabletBreakpoint,
    'mobile_breakpoint': customMobileBreakpoint,
  };

  const Map<String, dynamic> invalidTypesConfigJson = <String, dynamic>{
    'desktop_breakpoint': true,
    'tablet_breakpoint': 'customTabletBreakpoint',
    'mobile_breakpoint': 45,
  };

  group('$ResponsiveConfig annotation', () {
    group('${ResponsiveConfig.fromJson}', () {
      test(
          'should create ResponsiveConfig with proper parameters from a valid json',
          () {
        final sut = ResponsiveConfig.fromJson(validConfigJson);
        const matcher = ResponsiveConfig(
          desktopBreakpoint: customDesktopBreakpoint,
          tabletBreakpoint: customTabletBreakpoint,
          mobileBreakpoint: customMobileBreakpoint,
        );
        expect(sut.desktopBreakpoint, matcher.desktopBreakpoint);
        expect(sut.tabletBreakpoint, matcher.tabletBreakpoint);
        expect(sut.mobileBreakpoint, matcher.mobileBreakpoint);
      });

      test(
          'should throw $NoSuchMethodError while trying to call toDouble() for invalid json parameters type',
          () {
        expect(
          () => ResponsiveConfig.fromJson(invalidTypesConfigJson),
          throwsNoSuchMethodError,
        );
      });
    });

    group('$ResponsiveConfig parameters', () {
      test('should allow providing optional custom breakpoints them', () {
        const sut = ResponsiveConfig(
          desktopBreakpoint: customDesktopBreakpoint,
          tabletBreakpoint: customTabletBreakpoint,
        );
        expect(sut.desktopBreakpoint, customDesktopBreakpoint);
        expect(sut.tabletBreakpoint, customTabletBreakpoint);
        expect(sut.mobileBreakpoint, isNull);
      });
    });
  });
}
