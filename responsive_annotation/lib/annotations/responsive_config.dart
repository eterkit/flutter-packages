// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:meta/meta_meta.dart';

import 'package:responsive_annotation/models/default_breakpoints.dart';
import 'package:responsive_annotation/models/screen_type.dart';

/// An annotation used to specify a class to generate responsive code for.
@Target({TargetKind.classType})
class ResponsiveConfig {
  /// ResponsiveConfig is used to annotate classes that contains responsive fields.
  /// Default breakpoint values are:
  /// * `mobile` = 320; Note: must be bigger than 0.
  /// * `tablet` = 768; Note: must be bigger than mobile.
  /// * `laptop` = 992; Note: must be bigger than tablet.
  /// * `desktop` = 1200; Note: must be bigger than laptop.
  /// * `widescreen` = 1920; Note: must be bigger than desktop.
  ///
  /// To change the default breakpoints, you can provide them directly in annotation
  /// or specify them in `build.yaml` file, to enable them globally.
  /// For example:
  /// ```
  /// targets:
  ///   $default:
  ///   builders:
  ///    responsive_config:
  ///      enabled: true
  ///      options:
  ///        widescreen_breakpoint: 2100
  ///        desktop_breakpoint: 1024
  ///        laptop_breakpoint: 768
  /// ```
  /// Check https://pub.dev/packages/responsive_config for more details.
  const ResponsiveConfig({
    this.widescreenBreakpoint,
    this.desktopBreakpoint,
    this.laptopBreakpoint,
    this.tabletBreakpoint,
    this.mobileBreakpoint,
  })  : assert(widescreenBreakpoint == null ||
            widescreenBreakpoint >
                (desktopBreakpoint ?? DefaultBreakpoints.desktop)),
        assert(desktopBreakpoint == null ||
            desktopBreakpoint >
                (laptopBreakpoint ?? DefaultBreakpoints.laptop)),
        assert(laptopBreakpoint == null ||
            laptopBreakpoint > (tabletBreakpoint ?? DefaultBreakpoints.tablet)),
        assert(tabletBreakpoint == null ||
            tabletBreakpoint > (mobileBreakpoint ?? DefaultBreakpoints.mobile)),
        assert(mobileBreakpoint == null || mobileBreakpoint > 0);

  /// Factory `fromJson` constructor for [ResponsiveConfig].
  factory ResponsiveConfig.fromJson(Map<String, dynamic> json) {
    return ResponsiveConfig(
      widescreenBreakpoint:
          json['widescreen_breakpoint']?.toDouble() as double?,
      desktopBreakpoint: json['desktop_breakpoint']?.toDouble() as double?,
      laptopBreakpoint: json['laptop_breakpoint']?.toDouble() as double?,
      tabletBreakpoint: json['tablet_breakpoint']?.toDouble() as double?,
      mobileBreakpoint: json['mobile_breakpoint']?.toDouble() as double?,
    );
  }

  /// Specifies custom breakpoint for [ScreenType.widescreen].
  /// If not specified, the default value is [DefaultBreakpoints.widescreen].
  final double? widescreenBreakpoint;

  /// Specifies custom breakpoint for [ScreenType.desktop].
  /// If not specified, the default value is [DefaultBreakpoints.desktop].
  final double? desktopBreakpoint;

  /// Specifies custom breakpoint for [ScreenType.laptop].
  /// If not specified, the default value is [DefaultBreakpoints.laptop].
  final double? laptopBreakpoint;

  /// Specifies custom breakpoint for [ScreenType.tablet].
  /// If not specified, the default value is [DefaultBreakpoints.tablet].
  final double? tabletBreakpoint;

  /// Specifies custom breakpoint for [ScreenType.mobile].
  /// If not specified, the default value is [DefaultBreakpoints.mobile].
  final double? mobileBreakpoint;
}
