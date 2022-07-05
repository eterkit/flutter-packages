# responsive_config

:warning: This package is still under development, some features might not satisfy expected generated code.

Provides Flutter [Build System](https://github.com/dart-lang/build) builders for handling Responsive class variables.

The builders generate code when they find members annotated with classes defined
in [responsive_annotation](https://github.com/eterkit/flutter-packages/tree/main/responsive_annotation) [![Pub Package](https://img.shields.io/pub/v/responsive_annotation.svg)](https://pub.dev/packages/responsive_annotation).

## Setup

To configure your project for
`responsive_config`, see the [example](https://github.com/eterkit/flutter-packages/tree/main/responsive_config/example).

## Example

Given a library `example.dart` with an `AppConfig` class annotated with
`ResponsiveConfig` and fields annotated with `ResponsiveVariable`:

```dart
import 'package:flutter/material.dart';

import 'package:responsive_annotation/responsive_annotation.dart';

part 'example.g.dart';

@ResponsiveConfig(tabletBreakpoint: 700)
abstract class AppConfig {
  const AppConfig({
    required this.margin,
    required this.title,
    required this.customSample,
  });

  factory AppConfig.of(BuildContext context) =>
      _$ResponsiveAppConfig.of(context);

  @ResponsiveVariable<double>(
    mobile: 16,
    tablet: 32,
    laptop: 48,
    desktop: 64,
    widescreen: 128,
  )
  final double margin;

  @ResponsiveVariable<String>(
    mobile: 'Mobile',
    tablet: 'Tablet',
    laptop: 'Laptop',
    desktop: 'Desktop',
    widescreen: 'Widescreen',
  )
  final String title;

  @ResponsiveVariable<CustomClass>(
    mobile: CustomClassMobile(),
    tablet: CustomClass(),
    laptop: CustomClassLaptop(),
    desktop: CustomClass(),
    widescreen: CustomClassWidescreen(),
  )
  final CustomClass customSample;
}

class CustomClass {
  const CustomClass();
}

class CustomClassMobile extends CustomClass {
  const CustomClassMobile();
}

class CustomClassLaptop extends CustomClass {
  const CustomClassLaptop();
}

class CustomClassWidescreen extends CustomClass {
  const CustomClassWidescreen();
}
```

## Running the code generator

Once you have added the annotations to your code you then need to run the code
generator to generate the missing `.g.dart` generated dart files.

Run `flutter pub run build_runner build` in your package
directory.

## Annotation values
This package allows you to annotate 
- **classes** (only), with:
```dart
@ResponsiveConfig()
class SampleClass {}
```
This will generate the responsive code for this class

- **non static final variables** (only), with:
```dart
@ResponsiveVariable<T>(
    mobile: 16, 
    tablet: 32, 
    laptop: 64, 
    desktop: 128, 
    widescreen: 256,
)
final double margin;

// No code will be generated for static or non final variables 
// even if the annotation is present.
@ResponsiveVariable()
static const double commonSpacing = 24;
```
This will generate the responsive code for this field.
Note that you can only provide simple types `T`
or non parameterized default constructors as custom type `T`.
Parametrized and/or named constructors are not supported yet.

## Screen breakpoints
### default
ResponsiveConfig is used to annotate classes that contains responsive fields.
Default breakpoint values are:
- `mobile = 320;` **Note**: must be bigger than `0`
- `tablet = 768;` **Note**: must be bigger than `mobile`
- `laptop = 992;` **Note**: must be bigger than `tablet`
- `desktop = 1200;` **Note**: must be bigger than `laptop`
- `widescreen = 1920;` **Note**: must be bigger than `desktop`

### custom
There are 2 ways to specify custom breakpoints
- You can provide desired values directly in the annotation, for example:
```dart
@ResponsiveConfig(tabletBreakpoint: 700, desktopBreakpoint: 1064)
class SampleClass {}

```
- You can enable them globally for the whole project in your [build.yaml] file,
like so:
```yaml
targets:
  $default:
    builders:
      responsive_config:
        enabled: true
        options:
          mobile_breakpoint: 400
          tablet_breakpoint: 800
          laptop_breakpoint: 1000
          desktop_breakpoint: 1250
          widescreen_breakpoint: 2000
```

