import 'package:health_flutter/src/messages/pigeon_messages.dart';
import 'package:health_flutter/src/models/models.dart';
import 'package:health_flutter/src/utils/health_data_utils.dart';

export 'package:health_flutter/src/messages/pigeon_messages.dart';
export 'package:health_flutter/src/extensions/extensions.dart';

/// Base class for `HealthFlutter` plugin.
class HealthFlutter {
  final HealthApi _healthApi = HealthApi();

  /// Returns a boolean value that indicates availability of the service:
  /// * `Android` - true if `HealthConnect` is available; otherwise, false.
  /// * `iOS` - true if `HealthKit` is available; otherwise, false.
  Future<bool> get checkAvailability => _healthApi.checkAvailability();

  /// Checks whether permissions dialog can be displayed to the user.
  ///
  /// On iOS permissions dialog can be displayed only once,
  /// after that permissions can only be managed through Health app.
  ///
  /// You might want to use [openSystemSettings] if returned value is `false`.
  Future<bool> canRequestPermissions(List<HealthPermission> permissions) async {
    return _healthApi.canRequestPermissions(permissions);
  }

  /// Requests health permissions of specific types that can be specified in [permissions].
  ///
  /// As iOS doesn't allow checking read permissions status.
  /// It only returns whether permission dialog was at least once presented to the user.
  ///
  /// So unless there is an error it will always return true. Otherwise false.
  ///
  /// You might want to use [canRequestPermissions] first.
  Future<bool> requestPermissions(List<HealthPermission> permissions) async {
    return _healthApi.requestPermissions(permissions);
  }

  /// Fetches health data for [types] in form of points in range [startDate] - [endDate].
  Future<List<HealthData>> getDataForTypes(
    List<HealthDataType> types, {
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final result = <HealthData>[];
    for (final type in types) {
      final jsonObjects = await _healthApi.getDataForType(
        type,
        startDate.millisecondsSinceEpoch,
        endDate.millisecondsSinceEpoch,
      );
      final healthData = jsonObjects.nonNulls.map((json) {
        return HealthDataUtils.dataFromJson(Map<String, dynamic>.from(json));
      });
      result.addAll(healthData);
    }
    return result;
  }
}
