// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

/// Returns the size factor of the shorter side.
double shorterSideFactor(Size smallerSize, Size biggerSize) {
  final widthFactor = smallerSize.width / biggerSize.width;
  final heightFactor = smallerSize.height / biggerSize.height;
  return min(widthFactor, heightFactor);
}
