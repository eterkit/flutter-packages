import 'package:flutter/material.dart';
import 'package:permission_guard/permission_guard.dart';
import 'package:permission_guard_example/utils/notifiers.dart';

class ExampleGuardPage extends StatelessWidget {
  const ExampleGuardPage({
    super.key,
    required this.permission,
  });

  final Permission permission;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample page'),
      ),
      body: const PermissionGuard(
        permission: Permission.camera,
        child: _PermissionGrantedBody(),
      ),
      bottomNavigationBar: const _PermissionIndependentContent(),
    );
  }
}

class _PermissionGrantedBody extends StatelessWidget {
  const _PermissionGrantedBody();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle,
              color: Theme.of(context).colorScheme.primary,
              size: 48,
            ),
            const SizedBox(height: 8),
            Text(
              'This is the child content\nprovided to PermissionGuard',
              style: Theme.of(context).primaryTextTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _PermissionIndependentContent extends StatelessWidget {
  const _PermissionIndependentContent();

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Theme.of(context).appBarTheme.backgroundColor,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Permission independent content.\nSwitch to change theme.',
              style: Theme.of(context).primaryTextTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).appBarTheme.foregroundColor,
                  ),
              textAlign: TextAlign.start,
            ),
            ValueListenableBuilder(
              valueListenable: modeNotifier,
              builder: (_, mode, __) {
                final activeColor = Theme.of(context).colorScheme.primary;
                return Row(
                  children: [
                    Switch(
                      value: mode == ThemeMode.dark,
                      activeTrackColor: activeColor.withOpacity(0.7),
                      activeColor: activeColor,
                      onChanged: (value) {
                        modeNotifier.value =
                            value ? ThemeMode.dark : ThemeMode.light;
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
