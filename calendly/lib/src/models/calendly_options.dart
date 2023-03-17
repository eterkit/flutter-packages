import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Options to customize the [Calendly] widget.
class CalendlyOptions extends Equatable {
  /// Options to customize the [Calendly] widget.
  const CalendlyOptions({
    this.backgroundColor = _defaultBackgroundColor,
    this.textColor = _defaultTextColor,
    this.primaryColor = _defaultPrimaryColor,
    this.hideLandingPageDetails = false,
    this.hideEventTypeDetails = false,
    this.hideCookieBanner = false,
    this.embedDomain = '',
    this.shouldDisplayLoadingIndicator = true,
    this.prefillAnswers,
    this.loadingIndicator = const CircularProgressIndicator(
      color: _defaultPrimaryColor,
    ),
  });

  static const Color _defaultBackgroundColor = Color(0xFFFFFFFF);
  static const Color _defaultTextColor = Color(0xFF000000);
  static const Color _defaultPrimaryColor = Color(0xFF0069FF);

  /// Background color used on [Calendly] content.
  final Color backgroundColor;

  /// Text color used on [Calendly] content.
  final Color textColor;

  /// Buttons and links color used on [Calendly] content.
  final Color primaryColor;

  /// Use this setting to control whether to hide your profile picture, name, event duration, location, and description when Calendly is displayed.
  /// This will help reduce duplicate information that you may already have on your app page.
  ///
  /// Refers to `landing page` view.
  final bool hideLandingPageDetails;

  /// Use this setting to hide your profile picture, name, event duration, location, and description when Calendly is embedded.
  /// This will help reduce duplicate information that you may already have on your app page.
  ///
  /// Refers to `event type` view.
  final bool hideEventTypeDetails;

  /// Use this setting to control whether to hide Calendly’s request for cookie consent if your app already requests it.
  /// If you hide Calendly’s cookie banner, you’ll need to update your app’s privacy policy and terms of use to include Calendly.
  /// For more info, see [cookie management](https://help.calendly.com/hc/en-us/articles/4418236309399).
  final bool hideCookieBanner;

  /// To [hideCookieBanner], Calendly requires providing `embedDomain` field.
  ///
  /// Default is `empty` string, but maybe you want to use your domain for some reason.
  final String embedDomain;

  /// Pre-populate answers to invitee questions on the scheduling page.
  ///
  /// `PrefillAnswers` are set in the following structure:
  /// ```dart
  /// PrefillAnswers(
  ///     // If Name question is set to "Name"
  ///     name: 'John Doe',
  ///     // If Name question is set to "First Name, Last Name"
  ///     firstName: 'John',
  ///     // If Name question is set to "First Name, Last Name"
  ///     lastName: 'John',
  ///     email: 'john@doe.com',
  ///     guests: ['test1@gmail.com', 'test2@gmail.com'],
  ///     customAnswers: {
  ///       'a1': 'Answer to question 1',
  ///       'a': 'Answer to question 2',
  ///       ...
  ///       'a10': 'Answer to question 10', // Max length is 10.
  ///     }
  /// )
  /// ```
  final PrefillAnswers? prefillAnswers;

  /// Whether to display [loadingIndicator] while [Calendly] is initially loading.
  final bool shouldDisplayLoadingIndicator;

  /// Widget to display while [Calendly] is initially loading.
  final Widget loadingIndicator;

  @override
  List<Object?> get props => [
        backgroundColor,
        textColor,
        primaryColor,
        hideLandingPageDetails,
        hideEventTypeDetails,
        hideCookieBanner,
        shouldDisplayLoadingIndicator,
        prefillAnswers,
        loadingIndicator,
      ];
}

/// Answers to pre-populate invitee questions on the scheduling page.
class PrefillAnswers extends Equatable {
  /// Answers to pre-populate invitee questions on the scheduling page.
  const PrefillAnswers({
    this.name,
    this.firstName,
    this.lastName,
    this.email,
    this.guests,
    this.customAnswers,
  });

  /// This will be used as invitee `Name` while scheduling.
  ///
  /// **IMPORTANT NOTE**: If you use it, please make sure
  /// that your event accepts full `Name` instead of `First Name` & `Last Name`.
  final String? name;

  /// This will be used as invitee `First Name` while scheduling.
  ///
  /// **IMPORTANT NOTE**: If you use it, please make sure
  /// that your event accepts `First Name` & `Last Name` instead of full `Name`.
  final String? firstName;

  /// This will be used as invitee `Last name` while scheduling.
  ///
  /// **IMPORTANT NOTE**: If you use it, please make sure
  /// that your event accepts `First Name` & `Last Name` instead of full `Name`.
  final String? lastName;

  /// This email will be used as invitee email while scheduling.
  final String? email;

  /// This list will be used as pre-populated `Guest Email(s)` while scheduling.
  ///
  /// Example:
  /// ```dart
  /// ['test1@gmail.com', 'test2@gmail.com']
  /// ```
  final List<String>? guests;

  /// You can also set custom answers to invitee questions you've added to your event type.
  ///
  /// Each custom answer will be numbered in order as a1, a2, a3, and up to a10.
  ///
  /// Example:
  /// ```dart
  /// {
  ///   'a1': 'Answer to question 1',
  ///   'a': 'Answer to question 2',
  ///   ...
  ///   'a10': 'Answer to question 10', // Max length is 10.
  /// }
  /// ```
  final Map<String, dynamic>? customAnswers;

  @override
  List<Object?> get props => [
        name,
        firstName,
        lastName,
        email,
        guests,
        customAnswers,
      ];
}
