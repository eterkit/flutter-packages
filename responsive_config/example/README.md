# Example

To use [responsive_config](https://github.com/eterkit/flutter-packages/tree/main/responsive_config) in your flutter application, add these dependencies to your pubspec.yaml.

```yaml
dependencies:
  responsive_annotation: <latest>

dev_dependencies:
  build_runner: <latest>
  responsive_config: <latest>
```

Annotate your code with classes defined in [responsive_annotation](https://github.com/eterkit/flutter-packages/tree/main/responsive_annotation/lib/annotations).

See [lib/app_config.dart](https://github.com/eterkit/flutter-packages/tree/main/responsive_config/example/lib/app_config.dart) for an example of a file using these annotations.

See [lib/app_config.g.dart](https://github.com/eterkit/flutter-packages/tree/main/responsive_config/example/lib/app_config.g.dart) for an example of a generated file with responsive code.

See [build.yaml](https://github.com/eterkit/flutter-packages/tree/main/responsive_config/example/build.yaml) for an example of a file using build options.

Run `flutter pub run build_runner build` to generate files into your source directory.

```bash
[INFO] Generating build script completed, took 401ms
[INFO] Reading cached asset graph completed, took 66ms
[INFO] Checking for updates since last build completed, took 653ms
[INFO] Running build completed, took 10.5s
[INFO] Caching finalized dependency graph completed, took 31ms
[INFO] Succeeded after 10.5s with 2 outputs (7 actions)
```

See [lib/main.dart](https://github.com/eterkit/flutter-packages/tree/main/responsive_config/example/lib/main.dart) for the example of using `AppConfig.of(context)`.
