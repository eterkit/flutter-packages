import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_guard/permission_guard.dart';
import 'package:permission_guard_example/utils/router.dart';
import 'package:permission_guard_example/widgets/button_with_description.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permission Guard Example'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16).copyWith(top: 64),
        children: [
          ButtonWithDescription(
            label: 'Go to page',
            description: '1. Nested in page',
            onPressed: () => context.pushNamed(
              AppRoute.guardSample,
              extra: Permission.camera,
            ),
          ),
          const Divider(),
          ButtonWithDescription(
            label: 'Request permission',
            description: '2. Dialog with callback',
            onPressed: () {
              Permission.photos.requestGuarded(context).then((status) {
                if (status != PermissionStatus.granted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    content: const Text(
                      'Permission granted',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              });
            },
          ),
        ],
      ),
    );
  }
}
