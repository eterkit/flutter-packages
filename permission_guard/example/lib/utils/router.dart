import 'package:go_router/go_router.dart';
import 'package:permission_guard/permission_guard.dart';
import 'package:permission_guard_example/pages/guarded_page.dart';
import 'package:permission_guard_example/pages/home.dart';

final router = GoRouter(
  initialLocation: '/${AppRoute.home}',
  routes: [
    GoRoute(
      path: '/${AppRoute.home}',
      name: AppRoute.home,
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          name: AppRoute.guardSample,
          path: AppRoute.guardSample,
          builder: (context, state) {
            final permission = state.extra as Permission;
            return ExampleGuardPage(permission: permission);
          },
        ),
      ],
    ),
  ],
);

abstract class AppRoute {
  static const String home = 'home';
  static const String guardSample = 'guard-sample';
}
