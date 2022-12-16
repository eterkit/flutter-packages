import 'package:permission_guard/permission_guard.dart';

/// Extension used to provide default (non translated) values for UI elements,
/// such as: [PermissionGuardTitle], `description` and `action` labels.
extension PermissionGuardDefaultValuesExtension on PermissionStatus {
  /// Default value for `title` UI element.
  String get defaultTitle {
    switch (this) {
      case PermissionStatus.denied:
        return 'Permission denied';
      case PermissionStatus.restricted:
        return 'Permission restricted';
      case PermissionStatus.limited:
        return 'Permission limited';
      case PermissionStatus.permanentlyDenied:
        return 'Permission permanently denied';
      case PermissionStatus.granted:
        throw FallThroughError();
    }
  }

  /// Default value for `description` UI element.
  String get defaultDescription {
    switch (this) {
      case PermissionStatus.denied:
        return 'Please grant the access to continue.';
      case PermissionStatus.restricted:
        return 'Please remove restrictions to continue.';
      case PermissionStatus.limited:
        return 'Please grant the full access to continue.';
      case PermissionStatus.permanentlyDenied:
        return 'Please open settings to grant the access.';
      case PermissionStatus.granted:
        throw FallThroughError();
    }
  }

  /// Default value for `action` UI element.
  String get defaultAction {
    switch (this) {
      case PermissionStatus.denied:
        return 'Allow access';
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        return 'Open settings';
      case PermissionStatus.granted:
        throw FallThroughError();
    }
  }
}
