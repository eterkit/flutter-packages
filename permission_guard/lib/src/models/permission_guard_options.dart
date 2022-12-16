import 'package:flutter/material.dart';

import 'package:permission_guard/permission_guard.dart';

/// Customization options for [PermissionGuard] widget.
///
/// [PermissionGuard] uses Theme.of(context) everywhere possible.
/// If you want to customize just colors or text appearance, try to play around
/// with [ThemeData] like so:
/// ```
/// Theme(
///   data: Theme.of(context).copyWith(
///     primaryTextTheme: const TextTheme(
///       headlineMedium: TextStyle(fontSize: 30),
///       bodyMedium: TextStyle(fontSize: 14),
///     ),
///     colorScheme: Theme.of(context).colorScheme.copyWith(
///           primary: Colors.red,
///         ),
///   ),
///   child: const PermissionGuard(
///     permission: Permission.camera,
///     child: _PermissionGrantedBody(),
///   ),
/// ),
/// ```
class PermissionGuardOptions {
  /// Default constructor for [PermissionGuardOptions].
  const PermissionGuardOptions({
    this.requestOnInit = true,
    this.skipInitialChange = false,
    this.validStatuses = const [PermissionStatus.granted],
    this.displayLoader = true,
    this.loader,
    this.padding = const EdgeInsets.all(24),
    this.iconSpacing = 24,
    this.titleSpacing = 24,
    this.descriptionSpacing = 48,
    this.icon,
    this.title,
    this.description,
    this.action,
    this.titleBuilder,
    this.descriptionBuilder,
    this.actionBuilder,
  });

  /// Whether the guarded [permission] should be requested on initialization.
  ///
  /// **Note**: Result status is included in [onPermissionStatusChanged] call.
  /// To skip the result from initial change, see: [skipInitialChange].
  ///
  /// **Default**: `true`.
  ///
  /// /// **Ignored in request methods, respected only in nested widget**
  final bool requestOnInit;

  /// Use to skip the initial [onPermissionStatusChanged] call,
  /// even if [requestOnInit] = `true`.
  ///
  /// /// **Default**: `false`.
  ///
  /// **Ignored in request methods, respected only in nested widget**
  final bool skipInitialChange;

  /// All statuses that should release the guard.
  ///
  /// If status will meet any of [validStatuses] it will return [child] widget.
  ///
  /// It might be useful for allowing to continue with for example:
  /// [PermissionStatus.limited] on iOS.
  ///
  /// **Default**: `[PermissionStatus.granted]`.
  final List<PermissionStatus> validStatuses;

  /// Whether to display [loader] before the first check.
  final bool displayLoader;

  /// Loader widget to be displayed before the first check if [displayLoader].
  ///
  /// **Default**: [PermissionGuardLoadingIndicator].
  final Widget? loader;

  /// Padding around the content.
  ///
  /// **Default**: `24`.
  final EdgeInsets padding;

  /// Spacing between `icon` & `title`.
  ///
  /// **Default**: `24`.
  final double iconSpacing;

  /// Spacing between `title` & `description`.
  ///
  /// **Default**: `24`.
  final double titleSpacing;

  /// Spacing between `description` & `action`.
  ///
  /// **Default**: `48`.
  final double descriptionSpacing;

  /// Icon to be displayed for every [PermissionStatus] of [permission].
  /// Useful to display permission related icon.
  ///
  /// **Default**: [Icons.info_outline_rounded].
  final Widget? icon;

  /// Optional text to override default title.
  /// Useful for providing translated title value.
  ///
  /// **Note**: See [PermissionGuardDefaultValuesExtension] for default values.
  ///
  /// **Ignored** if [titleBuilder] is provided.
  final String Function(PermissionStatus status)? title;

  /// Optional text to override default description.
  /// Useful for providing translated description value.
  ///
  /// **Note**: See [PermissionGuardDefaultValuesExtension] for default values.
  ///
  /// **Ignored** if [descriptionBuilder] is provided.
  final String Function(PermissionStatus status)? description;

  /// Optional text to override default action label.
  /// Useful for providing translated action label value.
  ///
  /// **Note**: See [PermissionGuardDefaultValuesExtension] for default values.
  ///
  /// **Ignored** if [actionBuilder] is provided.
  final String Function(PermissionStatus status)? action;

  /// Optional widget to override default title.
  /// Useful for providing custom title widget.
  ///
  /// **Note**: See [PermissionGuardDefaultValuesExtension] for default values.
  final Widget Function(PermissionStatus status)? titleBuilder;

  /// Optional widget to override default description.
  /// Useful for providing custom description widget.
  ///
  /// **Note**: See [PermissionGuardDefaultValuesExtension] for default values.
  final Widget Function(PermissionStatus status)? descriptionBuilder;

  /// Optional widget to override default action.
  /// Useful for providing custom action widget.
  ///
  /// It provides the action `call` method so it can be used in a custom widget.
  ///
  /// **Note**: See [PermissionGuardDefaultValuesExtension] for default values.
  final Widget Function(PermissionStatus status, VoidCallback call)?
      actionBuilder;

  /// Allows creating a fast copy of current instance with small adjustments.
  PermissionGuardOptions copyWith({
    bool? requestOnInit,
    bool? skipInitialChange = false,
    List<PermissionStatus>? validStatuses,
    bool? displayLoader,
    EdgeInsets? padding,
    double? iconSpacing,
    double? titleSpacing,
    double? descriptionSpacing,
    Widget? icon,
    String Function(PermissionStatus status)? title,
    String Function(PermissionStatus status)? description,
    String Function(PermissionStatus status)? action,
    Widget Function(PermissionStatus status)? titleBuilder,
    Widget Function(PermissionStatus status)? descriptionBuilder,
    Widget Function(PermissionStatus status, VoidCallback call)? actionBuilder,
  }) =>
      PermissionGuardOptions(
        requestOnInit: requestOnInit ?? this.requestOnInit,
        skipInitialChange: skipInitialChange ?? this.skipInitialChange,
        validStatuses: validStatuses ?? this.validStatuses,
        displayLoader: displayLoader ?? this.displayLoader,
        padding: padding ?? this.padding,
        iconSpacing: iconSpacing ?? this.iconSpacing,
        titleSpacing: titleSpacing ?? this.titleSpacing,
        descriptionSpacing: descriptionSpacing ?? this.descriptionSpacing,
        icon: icon ?? this.icon,
        title: title ?? this.title,
        description: description ?? this.description,
        action: action ?? this.action,
        titleBuilder: titleBuilder ?? this.titleBuilder,
      );
}
