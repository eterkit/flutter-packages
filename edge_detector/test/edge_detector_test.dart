import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'package:edge_detector/edge_detector.dart';
import 'package:edge_detector/edge_detector_method_channel.dart';
import 'package:edge_detector/edge_detector_platform_interface.dart';

final File mockFile = File('file/path');

const Edges mockEdges = Edges(
  topLeft: Offset(0, 200),
  topRight: Offset(200, 200),
  bottomRight: Offset(200, 0),
  bottomLeft: Offset.zero,
);

class MockEdgeDetectorPlatform
    with MockPlatformInterfaceMixin
    implements EdgeDetectorPlatform {
  @override
  Future<Edges?> detectEdges(File imageFile) => Future.value(mockEdges);
}

void main() {
  final EdgeDetectorPlatform initialPlatform = EdgeDetectorPlatform.instance;

  test('$MethodChannelEdgeDetector is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelEdgeDetector>());
  });

  test('detectEdges', () async {
    final edgeDetector = EdgeDetector();
    final fakePlatform = MockEdgeDetectorPlatform();
    EdgeDetectorPlatform.instance = fakePlatform;

    expect(await edgeDetector.detectEdges(mockFile), mockEdges);
  });
}
