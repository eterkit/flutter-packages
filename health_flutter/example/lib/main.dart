import 'package:flutter/material.dart';
import 'package:health_flutter/health_flutter.dart';
import 'package:health_flutter_example/widgets/primary_button.dart';

void main() => runApp(const ExampleApp());

class ExampleApp extends StatelessWidget {
  const ExampleApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Flutter Example',
      home: ExamplePage(),
    );
  }
}

class ExamplePage extends StatelessWidget {
  const ExamplePage({super.key});

  static final HealthFlutter _healthFlutter = HealthFlutter();

  static final List<HealthPermission> _permissions = HealthDataType.values.toReadPermissionRequests;

  Future<void> _checkAvailability() async {
    final result = await _healthFlutter.checkAvailability;
    debugPrint('Check availability result: $result');
  }

  Future<void> _canRequestPermissions() async {
    final result = await _healthFlutter.canRequestPermissions(_permissions);
    debugPrint('Can request permissions result: $result');
  }

  Future<void> _requestPermissions() async {
    final result = await _healthFlutter.requestPermissions(_permissions);
    debugPrint('Request permissions result: $result');
  }

  Future<void> _getData() async {
    final now = DateTime.now();

    final results = await _healthFlutter.getDataForTypes(
      HealthDataType.values,
      startDate: now.subtract(const Duration(days: 7)),
      endDate: now,
    );
    debugPrint('Get data results length: ${results.map((result) => result.toJson())}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Flutter Example'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          PrimaryButton(
            label: 'Check availability',
            onPressed: _checkAvailability,
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            label: 'Can request permissions',
            onPressed: _canRequestPermissions,
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            label: 'Request permissions',
            onPressed: _requestPermissions,
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            label: 'Get Data',
            onPressed: _getData,
          ),
        ],
      ),
    );
  }
}
