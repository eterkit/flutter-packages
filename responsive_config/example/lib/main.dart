import 'package:flutter/material.dart';

import 'package:example/app_config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive config',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppConfig.of(context).title,
        ),
      ),
      body: Container(
        color: Colors.blueAccent,
        margin: EdgeInsets.all(
          AppConfig.of(context).margin,
        ),
        child: Center(
          child: Text(
            AppConfig.of(context).description,
            style: Theme.of(context)
                .textTheme
                .headline4
                ?.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
