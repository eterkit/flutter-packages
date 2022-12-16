import 'package:flutter/material.dart';

/// Default loading indicator widget for `PermissionGuard`.
class PermissionGuardLoadingIndicator extends StatelessWidget {
  /// Default constructor for [PermissionGuardLoadingIndicator].
  const PermissionGuardLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
