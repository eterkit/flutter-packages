import 'package:flutter/material.dart';
import 'package:permission_guard_example/utils/notifiers.dart';
import 'package:permission_guard_example/utils/router.dart';
import 'package:permission_guard_example/utils/themes.dart';

void main() => runApp(const ExampleApp());

class ExampleApp extends StatelessWidget {
  const ExampleApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: modeNotifier,
      builder: (_, mode, __) {
        return MaterialApp.router(
          themeMode: mode,
          darkTheme: Themes.buildDark(context),
          theme: Themes.buildLight(context),
          routerConfig: router,
        );
      },
    );
  }
}
