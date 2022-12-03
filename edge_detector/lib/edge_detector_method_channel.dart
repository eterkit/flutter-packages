import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:edge_detector/src/models/edges.dart';
import 'edge_detector_platform_interface.dart';

/// An implementation of [EdgeDetectorPlatform] that uses method channels.
class MethodChannelEdgeDetector extends EdgeDetectorPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('eterkit.com/edge_detector');

  @override
  Future<Edges?> detectEdges(File imageFile) async {
    final filePath = imageFile.path;
    final result = await methodChannel.invokeMethod<Map<Object?, Object?>>(
      'detectEdges',
      {'filePath': filePath},
    );
    if (result == null) return null;
    final edges = Edges.fromPlatformResult(result);
    return edges;
  }
}
