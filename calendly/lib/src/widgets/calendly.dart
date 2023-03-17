import 'package:calendly/src/extensions/extensions.dart';
import 'package:calendly/src/models/models.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Core widget to display calendly booking experience.
class Calendly extends StatefulWidget {
  /// Core widget to display calendly booking experience.
  ///
  /// Provide the [schedulingUrl] which should be a valid url of the calendly `landing page` or calendly `event type`.
  ///
  /// Optionally you can provide [CalendlyOptions] to customize the experience.
  const Calendly({
    super.key,
    required this.schedulingUrl,
    this.options = const CalendlyOptions(),
  });

  /// Url of the scheduling `landing page` - https://developer.calendly.com/api-docs/ZG9jOjI3ODM2MTAy-getting-started-with-embeds#add-your-scheduling-page-to-your-website
  ///
  ///  or
  ///
  /// scheduling `event type` - https://developer.calendly.com/api-docs/ZG9jOjI3ODM2MTAy-getting-started-with-embeds#add-an-event-type-page-to-your-website.
  final String schedulingUrl;

  /// Options to customize the appearance of the [Calendly] widget.
  final CalendlyOptions options;

  @override
  State<Calendly> createState() => _CalendlyState();
}

class _CalendlyState extends State<Calendly> {
  bool _isLoading = true;

  late final WebViewController _webController;

  String get _calendlyUrl => widget.options.applyOnUrl(widget.schedulingUrl);

  @override
  void initState() {
    super.initState();
    _webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(widget.options.backgroundColor)
      ..enableZoom(false)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) async {
            await _webController.runJavaScript(
              '''
              Calendly.initInlineWidget({
                url: '$_calendlyUrl',
                parentElement: document.getElementById('eterkit-calendly'),
              });
              ''',
            );
            setState(() => _isLoading = false);
          },
        ),
      )
      ..addJavaScriptChannel(
        'eterkitCalendly',
        onMessageReceived: (message) {
          // TODO: Handle message.
          debugPrint(message.message);
        },
      )
      ..loadView();
  }

  @override
  void didUpdateWidget(covariant Calendly oldWidget) {
    super.didUpdateWidget(oldWidget);
    final shouldRefresh = oldWidget.schedulingUrl != widget.schedulingUrl ||
        oldWidget.options != widget.options;
    if (shouldRefresh) _webController.loadView();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: widget.options.backgroundColor,
      ),
      child: _isLoading && widget.options.shouldDisplayLoadingIndicator
          ? Center(child: widget.options.loadingIndicator)
          : WebViewWidget(controller: _webController),
    );
  }
}
