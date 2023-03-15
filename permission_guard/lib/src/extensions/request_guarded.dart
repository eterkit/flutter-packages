import 'package:flutter/material.dart';

import 'package:permission_guard/permission_guard.dart';

/// Helper extension hat provide methods to safely request permissions.
extension RequestGuardedMethodExtension on Permission {
  /// Tries the default permission request, then if the native dialog can't
  /// be opened (for example because of [PermissionStatus.permanentlyDenied]),
  /// it shows the PermissionGuard dialog.
  ///
  /// **Note**: if status is already = [PermissionGuardOptions.validStatuses]
  /// no dialog will be shown.
  ///
  /// Always returns [PermissionStatus].
  ///
  /// You can pass [PermissionGuardOptions] to customize the the guardian.
  ///
  /// See [showDialog] for possible dialog customization options.
  Future<PermissionStatus?> requestGuarded(
    BuildContext context, {
    PermissionGuardOptions options = const PermissionGuardOptions(),
    bool barrierDismissible = true,
    Color? barrierColor = Colors.black54,
    String? barrierLabel,
    bool useSafeArea = true,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
    Offset? anchorPoint,
    Color? backgroundColor,
    EdgeInsets insetPadding = const EdgeInsets.all(24),
    EdgeInsets contentPadding = const EdgeInsets.all(24),
    bool fillAvailableSpace = false,
  }) async {
    PermissionStatus status = await request();
    if (options.validStatuses.contains(status)) return status;

    if (context.mounted) {
      return showDialog<PermissionStatus>(
        context: context,
        anchorPoint: anchorPoint,
        barrierColor: barrierColor,
        barrierDismissible: barrierDismissible,
        barrierLabel: barrierLabel,
        routeSettings: routeSettings,
        useRootNavigator: useRootNavigator,
        builder: (context) => WillPopScope(
          onWillPop: () async {
            Navigator.of(context).pop(status);
            return true;
          },
          child: AlertDialog(
            backgroundColor: backgroundColor,
            insetPadding: insetPadding,
            contentPadding: EdgeInsets.zero,
            content: Stack(
              children: [
                Column(
                  mainAxisSize:
                      fillAvailableSpace ? MainAxisSize.max : MainAxisSize.min,
                  children: [
                    PermissionGuard(
                      permission: this,
                      options: options.copyWith(
                        requestOnInit: false,
                        skipInitialChange: true,
                        padding: contentPadding,
                      ),
                      onPermissionStatusChanged: (value) => status = value,
                      onPermissionGranted: () => Navigator.of(context).pop(),
                      child: const SizedBox.shrink(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return null;
    }
  }
}
