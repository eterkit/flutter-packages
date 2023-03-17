import 'package:calendly/src/extensions/extensions.dart';
import 'package:calendly/src/models/calendly_options.dart';

/// Helper extension to create parametrized url.
extension ApplyCalendlyOptionsOnUrlExtension on CalendlyOptions {
  /// Helper method to create parametrized url from [CalendlyOptions].
  String applyOnUrl(String url) {
    final parametrizedUrl = StringBuffer();

    // Calendly widget options.
    parametrizedUrl
      ..write('$url?')
      ..writeAll([
        'hide_landing_page_details=${hideLandingPageDetails.number}',
        'hide_event_type_details=${hideEventTypeDetails.number}',
        'hide_gdpr_banner=${hideCookieBanner.number}',
        if (hideCookieBanner)
          'embed_domain="$embedDomain"', // Required to hide cookie banner.
        'background_color=${backgroundColor.hex}',
        'text_color=${textColor.hex}',
        'primary_color=${primaryColor.hex}',
      ], '&');

    // Prefill answers.
    final name = prefillAnswers?.name;
    final firstName = prefillAnswers?.firstName;
    final lastName = prefillAnswers?.lastName;
    final email = prefillAnswers?.email;
    final guests = prefillAnswers?.guests?.join(',');
    final customAnswers = prefillAnswers?.customAnswers;

    if (prefillAnswers != null) {
      parametrizedUrl.write('&');
      parametrizedUrl.writeAll([
        if (name != null) 'name=$name',
        if (firstName != null) 'firstName=$firstName',
        if (lastName != null) 'lastName=$lastName',
        if (email != null) 'email=$email',
        if (guests != null && guests.isNotEmpty) 'guests=$guests',
        if (customAnswers != null)
          ...customAnswers.entries.map((answer) {
            return '${answer.key}=${answer.value}';
          }).toList(growable: false),
      ], '&');
    }
    return '$parametrizedUrl';
  }
}
