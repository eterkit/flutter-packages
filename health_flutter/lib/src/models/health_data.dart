import 'package:health_flutter/src/extensions/extensions.dart';
import 'package:health_flutter/src/messages/pigeon_messages.dart';
import 'package:health_flutter/src/models/health_value.dart';

/// Main class for health data points.
class HealthData {
  /// Default constructor for [HealthData].
  const HealthData({
    required this.unit,
    required this.type,
    required this.value,
    required this.startDate,
    required this.endDate,
  });

  /// [HealthUnit] of this [HealthData].
  final HealthUnit unit;

  /// [HealthDataType] of this [HealthData].
  final HealthDataType type;

  /// [HealthValue] of this [HealthData].
  final HealthValue value;

  /// Start date of this [HealthData] point.
  ///
  /// Note: In [toJson] it is converted to `millisecondsSinceEpoch`.
  final DateTime startDate;

  /// End date of this [HealthData] point.
  ///
  /// Note: In [toJson] it is converted to `millisecondsSinceEpoch`.
  final DateTime endDate;

  /// Creates json representation of this instance.
  Map<String, dynamic> toJson() => {
        'unit': unit.jsonValue,
        'type': type.jsonValue,
        'value': value.toJson(),
        'start_date_timestamp': startDate.millisecondsSinceEpoch,
        'end_date_timestamp': endDate.millisecondsSinceEpoch,
      };
}
