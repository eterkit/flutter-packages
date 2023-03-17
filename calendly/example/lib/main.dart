import 'package:calendly/calendly.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendly Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ExamplePage(),
    );
  }
}

class ExamplePage extends StatelessWidget {
  const ExamplePage({super.key});

  // NOTE: Provide valid schedulingUrl
  static const String _schedulingUrl =
      'https://calendly.com/olaneq/flutter-example';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendly Example'),
      ),
      body: const Calendly(
        schedulingUrl: _schedulingUrl,
        options: CalendlyOptions(
          backgroundColor: Colors.black,
          textColor: Colors.white,
          hideEventTypeDetails: false,
          hideLandingPageDetails: true,
          hideCookieBanner: true,
          prefillAnswers: PrefillAnswers(
            name: 'Marc Sanny',
            firstName: 'Marc',
            lastName: 'Sanny',
            email: 'eterkit@gmail.com',
            guests: [
              'test1@email.com',
              'test2@email.com',
            ],
            customAnswers: {
              'a1': 1,
              'a2': '+48665443221',
              'a3': 0,
            },
          ),
        ),
      ),
    );
  }
}
