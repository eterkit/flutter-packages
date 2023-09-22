import 'package:health_flutter/src/extensions/extensions.dart';
import 'package:health_flutter/src/messages/pigeon_messages.dart';
import 'package:health_flutter/src/models/health_data.dart';
import 'package:health_flutter/src/models/models.dart';

/// Helper utils for [HealthData] model.
abstract class HealthDataUtils {
  /// Helps to convert "raw" native data to
  ///
  /// It's not exposed publicly on purpose as only `toJson` method should be accessible.
  static HealthData dataFromJson(Map<String, dynamic> json) {
    final type = HealthDataType.values[json['type_index'] as int];

    return HealthData(
      unit: type.unit,
      type: type,
      value: type.valueFromJson(json),
      startDate: DateTime.fromMillisecondsSinceEpoch(json['start_date_timestamp'] as int),
      endDate: DateTime.fromMillisecondsSinceEpoch(json['end_date_timestamp'] as int),
    );
  }
}
