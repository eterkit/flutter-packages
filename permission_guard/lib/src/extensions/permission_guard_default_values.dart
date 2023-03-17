import 'package:permission_guard/permission_guard.dart';

/// Extension used to provide default (non translated) values for UI elements,
/// such as: [PermissionGuardTitle], `description` and `action` labels.
extension PermissionGuardDefaultValuesExtension on PermissionStatus {
  /// Default value for `title` UI element.
  String get defaultTitle {
    return switch (this) {
      PermissionStatus.denied => 'Permission denied',
      PermissionStatus.restricted => 'Permission restricted',
      PermissionStatus.limited ||
      PermissionStatus.provisional =>
        'Permission limited',
      PermissionStatus.permanentlyDenied => 'Permission permanently denied',
      PermissionStatus.granted => throw AssertionError('Shouldn\'t be called'),
    };
  }

  /// Default value for `description` UI element.
  String get defaultDescription {
    return switch (this) {
      PermissionStatus.denied => 'Please grant the access to continue.',
      PermissionStatus.restricted => 'Please remove restrictions to continue.',
      PermissionStatus.limited ||
      PermissionStatus.provisional =>
        'Please grant the full access to continue.',
      PermissionStatus.permanentlyDenied =>
        'Please open settings to grant the access.',
      PermissionStatus.granted => throw AssertionError('Shouldn\'t be called'),
    };
  }

  /// Default value for `action` UI element.
  String get defaultAction {
    return switch (this) {
      PermissionStatus.denied => 'Allow access',
      PermissionStatus.restricted => 'Please remove restrictions to continue.',
      PermissionStatus.limited ||
      PermissionStatus.provisional ||
      PermissionStatus.permanentlyDenied =>
        'Open settings',
      PermissionStatus.granted => throw AssertionError('Shouldn\'t be called'),
    };
  }
}
