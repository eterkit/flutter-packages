import 'package:webview_flutter/webview_flutter.dart';

/// Helper extension to load proper asset/file,
/// **NOTE**: should be used only internally in [Calendly] package.
extension LoadWebviewExtension on WebViewController {
  // Used only for faster debugging. Replace with correct absolute path.
  // Keep it here, but when you finish debugging, please comment out.
  static const String _debugFilePath =
      '/Users/marcsanny/development/projects/flutter-packages/calendly/assets/index.html';
  static const String _indexHtmlAssetPath =
      'packages/calendly/assets/index.html';

  /// Loads proper asset/file to the [WebviewController].
  Future<void> loadView() async {
    loadFile(_debugFilePath);
    // loadFlutterAsset(_indexHtmlAssetPath);
  }
}
