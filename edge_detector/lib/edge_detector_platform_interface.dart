import 'dart:io';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'package:edge_detector/src/models/edges.dart';
import 'edge_detector_method_channel.dart';

/// Platform specific implementation of EdgeDetector.
abstract class EdgeDetectorPlatform extends PlatformInterface {
  /// Constructs a EdgeDetectorPlatform.
  EdgeDetectorPlatform() : super(token: _token);

  static final Object _token = Object();

  static EdgeDetectorPlatform _instance = MethodChannelEdgeDetector();

  /// The default instance of [EdgeDetectorPlatform] to use.
  ///
  /// Defaults to [MethodChannelEdgeDetector].
  static EdgeDetectorPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [EdgeDetectorPlatform] when
  /// they register themselves.
  static set instance(EdgeDetectorPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Detects edges of given [imageFile]
  ///
  /// Returns [Edges] when succeeded or null on failure.
  Future<Edges?> detectEdges(File imageFile) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
