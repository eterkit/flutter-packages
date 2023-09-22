import 'package:health_flutter/src/messages/pigeon_messages.dart';

/// Helper extension to create snake case enum value in toJson.
extension HealthDataTypeToJsonExtension on HealthDataType {
  /// Returns json `snake_case` value of this [HealthDataType].
  String get jsonValue => _toSnakeCase(name);
}

/// Helper extension to create snake case enum value in toJson.
extension HealthUnitToJsonExtension on HealthUnit {
  /// Returns json `snake_case` value of this [HealthUnit].
  String get jsonValue => _toSnakeCase(name);
}

String _toSnakeCase(String camelCaseValue) {
  final pattern = RegExp('(?<=[a-z])[A-Z]');
  return camelCaseValue.replaceAllMapped(pattern, (m) => '_${m.group(0)}').toLowerCase();
}
