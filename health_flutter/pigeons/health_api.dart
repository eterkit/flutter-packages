import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/messages/pigeon_messages.dart',
    swiftOut: 'ios/Classes/PigeonMessages.swift',
    kotlinOptions: KotlinOptions(package: 'com.eterkit.health_flutter'),
    kotlinOut: 'android/src/main/kotlin/com/eterkit/health_flutter/PigeonMessages.kt',
  ),
)
@HostApi()
abstract class HealthApi {
  bool checkAvailability();

  @async
  bool canRequestPermissions(List<HealthPermission> permissions);

  @async
  bool requestPermissions(List<HealthPermission> permissions);

  @async
  List<Map> getDataForType(
    HealthDataType type,
    int startDateMillisecondsSinceEpoch,
    int endDateMillisecondsSinceEpoch,
  );
}

/// Helper object to group `HealthDataType` and `PermissionType` together.
class HealthPermission {
  // NOTE: Could be removed (replaced with Map<HealthDataType, PermissionType>) after pigeon issue resolution.
  // Issue: https://github.com/flutter/flutter/issues/133728
  const HealthPermission(
    this.dataType,
    this.permissionType,
  );

  final HealthDataType dataType;
  final PermissionType permissionType;
}

/// Enum representing permission levels.
enum PermissionType {
  read,
  write,
  readWrite,
}

/// Enum representing health units.
enum HealthUnit {
  kilocalorie,

  /// In celsius.
  degree,
}

/// Enum representing health data types.
/// **Important**: Order of this enum is respected on native platforms.
///
/// Please keep it in alphabetical order on every platform.
enum HealthDataType {
  activeEnergyBurned,
  basalBodyTemperature,
  basalEnergyBurned,
}
