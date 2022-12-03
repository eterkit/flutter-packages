import 'package:flutter/services.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:edge_detector/edge_detector_method_channel.dart';
import 'edge_detector_test.dart';

void main() {
  final platform = MethodChannelEdgeDetector();
  const MethodChannel channel = MethodChannel('eterkit.com/edge_detector');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((methodCall) async {
      return mockEdges;
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('detectEdges', () async {
    expect(await platform.detectEdges(mockFile), mockEdges);
  });
}
