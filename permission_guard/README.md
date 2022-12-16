# permission_guard

UI wrapper around [permission_handler](https://pub.dev/packages/permission_handler) package that makes handling permission states easy.

## Setup

Before requesting/checking any permissions, you need to setup each platform individually.
**Instructions**: see [setup](https://pub.dev/packages/permission_handler#setup) section of [permission_handler](https://pub.dev/packages/permission_handler).

## Preview

Widget            |  Dialog
:-------------------------:|:-------------------------:
<img src="https://github.com/eterkit/flutter-packages/blob/main/permission_guard/widget.gif?raw=true">  |  <img src="https://github.com/eterkit/flutter-packages/blob/main/permission_guard/dialog.gif?raw=true">

# Example usage

### How to use

#### Widget

```dart
...
PermissionGuard(
  permission: Permission.camera,
  child: _PermissionGrantedBody(),
),
...
```

#### Dialog

```dart
...
onPressed: () async {
  final status = await Permission.photos.requestGuarded(context);
  debugPrint('$status');
},
...
```

#### Customizations
Both `PermissionGuard` widget & `requestGuarded` method accepts
`PermissionGuardOptions` that allows customization of almost every element

```dart
  PermissionGuardOptions({
    // Useful to customize the behavior of the guardian.
    bool requestOnInit,
    bool skipInitialChange,
    List<PermissionStatus> validStatuses,
    // Useful to customize loader appearance & behavior.
    bool displayLoader,
    Widget loader,
    // Useful to override the default dimensions.
    EdgeInsets? padding,
    double? iconSpacing,
    double? titleSpacing,
    double? descriptionSpacing,
    Widget? icon,
    //  Useful to override default icon.
    this.icon,
    // Useful to override default strings with translated ones based on status.
    String Function(PermissionStatus status)? title,
    String Function(PermissionStatus status)? description,
    String Function(PermissionStatus status)? action,
    // Useful to provide custom widgets based on status.
    Widget Function(PermissionStatus status)? titleBuilder,
    Widget Function(PermissionStatus status)? descriptionBuilder,
    // (Provides action `call` method so it can be used in a custom widget)
    Widget Function(PermissionStatus status, VoidCallback call)? actionBuilder,
  });
```

### Full example

[Source code](https://github.com/eterkit/flutter-packages/tree/main/permission_guard/example)

An example showing how to set up and use `permission_guard` package.
