import 'package:flutter/material.dart';

/// Helper extension to convert `material` color to `HEX`.
extension ColoRToHexExtension on Color {
  /// `HEX` representation of this material color.
  String get hex => '${alpha.toRadixString(16)}'
          '${red.toRadixString(16).padLeft(2, '0')}'
          '${green.toRadixString(16).padLeft(2, '0')}'
          '${blue.toRadixString(16).padLeft(2, '0')}'
      .substring(2);
}
