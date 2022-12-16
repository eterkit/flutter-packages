import 'package:flutter/material.dart';

import 'package:permission_guard/permission_guard.dart';

/// Guardian widget, that assures that given [permission]
/// is granted or sufficient.
///
/// You can pass [PermissionGuardOptions] to customize the the.
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
class PermissionGuard extends StatefulWidget {
  /// Default constructor for [PermissionGuard].
  const PermissionGuard({
    super.key,
    required this.permission,
    required this.child,
    this.options = const PermissionGuardOptions(),
    this.onPermissionStatusChanged,
    this.onPermissionGranted,
  });

  /// [Permission] that requires guarding.
  final Permission permission;

  /// Widget that should be displayed when permission status is
  /// [PermissionStatus.granted].
  final Widget child;

  /// Customization options, see [PermissionGuardOptions] for default values.
  final PermissionGuardOptions options;

  /// Returns the new [PermissionStatus] whenever it's changed.
  ///
  /// **Note**: it will include the initial change if [requestOnInit]
  /// is `true` (default). To skip initial change, see: [skipInitialChange].
  final void Function(PermissionStatus status)? onPermissionStatusChanged;

  /// Callback for reacting to permission granted.
  ///
  /// **Note**: Permission is granted when is equal to any
  /// of the [validStatuses] (by default: `[PermissionStatus.granted]`).
  final VoidCallback? onPermissionGranted;

  @override
  State<PermissionGuard> createState() => _PermissionGuardState();
}

class _PermissionGuardState extends State<PermissionGuard>
    with WidgetsBindingObserver {
  PermissionStatus? _status;
  bool _isAppInBackground = false;

  PermissionGuardOptions get _options => widget.options;

  @override
  void initState() {
    super.initState();
    _initialize();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        if (!_isAppInBackground) return;
        _isAppInBackground = false;
        _checkStatus();
        break;
      case AppLifecycleState.paused:
        if (_isAppInBackground) return;
        _isAppInBackground = true;
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final status = _status;
    if (status == null) {
      return _options.displayLoader
          ? _options.loader ?? const PermissionGuardLoadingIndicator()
          : const SizedBox.shrink();
    }

    if (_options.validStatuses.contains(status)) return widget.child;

    return Padding(
      padding: _options.padding,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _options.icon ??
                Icon(
                  Icons.info_outline_rounded,
                  color: Theme.of(context).colorScheme.primary,
                  size: 48,
                ),
            SizedBox(height: _options.iconSpacing),
            _options.titleBuilder?.call(status) ??
                Text(
                  _options.title?.call(status) ?? status.defaultTitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).primaryTextTheme.headlineMedium,
                ),
            SizedBox(height: _options.titleSpacing),
            _options.descriptionBuilder?.call(status) ??
                Text(
                  _options.description?.call(status) ??
                      status.defaultDescription,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).primaryTextTheme.bodyMedium,
                ),
            SizedBox(height: _options.descriptionSpacing),
            _options.actionBuilder?.call(status, _handleRequestPermission) ??
                ElevatedButton(
                  onPressed: _handleRequestPermission,
                  child: Text(
                    _options.action?.call(status) ?? status.defaultAction,
                  ),
                ),
          ],
        ),
      ),
    );
  }

  Future<void> _initialize() async {
    _checkStatus(!_options.skipInitialChange);
    if (_options.requestOnInit) _handleRequestPermission();
  }

  Future<void> _checkStatus([bool notifyParent = true]) async {
    final status = await widget.permission.status;
    _setPermissionStatus(status, notifyParent);
  }

  Future<void> _handleRequestPermission() async {
    switch (_status) {
      // Cases where default native dialog wont show.
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.limited:
      case PermissionStatus.restricted:
        await openAppSettings();
        break;
      default:
        final status = await widget.permission.request();
        _setPermissionStatus(status);
        break;
    }
  }

  void _setPermissionStatus(
    PermissionStatus status, [
    bool notifyParent = true,
  ]) {
    // Check if new status is different from current status.
    if (_status == status) return;
    // Update state.
    setState(() => _status = status);
    // Call methods from parent class.
    if (notifyParent) widget.onPermissionStatusChanged?.call(status);
    if (_isGranted(status)) widget.onPermissionGranted?.call();
  }

  bool _isGranted(PermissionStatus status) =>
      _options.validStatuses.contains(status);
}
