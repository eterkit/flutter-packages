import 'package:health_flutter/src/messages/pigeon_messages.dart';
import 'package:health_flutter/src/models/models.dart';

/// Helper enums for `HealthDataType`.
extension HealthDataTypeExtensions on HealthDataType {
  /// Returns corresponding [HealthUnit] for this [HealthDataType].
  HealthUnit get unit {
    return switch (this) {
      HealthDataType.activeEnergyBurned ||
      HealthDataType.basalEnergyBurned =>
        HealthUnit.kilocalorie,
      HealthDataType.basalBodyTemperature => HealthUnit.degree,
    };
  }

  /// Returns corresponding [HealthUnit] for this [HealthDataType].
  HealthValue valueFromJson(Map<String, dynamic> json) {
    return switch (this) {
      HealthDataType.activeEnergyBurned ||
      HealthDataType.basalEnergyBurned ||
      HealthDataType.basalBodyTemperature =>
        NumericHealthValue.fromJson(json),
    };
  }
}

/// Helper enums for `HealthDataType` lists.
extension HealthDataTypeListExtensions on List<HealthDataType> {
  /// Converts List of `HealthDataType`'s to List of `PermissionRequest` with corresponding
  /// data types and `PermissionType.read`.
  ///
  /// Example usage:
  /// ```
  /// // It will convert all health data types to corresponding read permission requests.
  /// final permissionRequests = HealthDataType.values.toReadPermissionRequests;
  /// ```
  List<HealthPermission> get toReadPermissionRequests {
    return map((type) => HealthPermission(dataType: type, permissionType: PermissionType.read))
        .toList(growable: false);
  }
}
