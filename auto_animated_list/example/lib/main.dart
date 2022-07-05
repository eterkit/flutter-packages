import 'package:auto_animated_list/auto_animated_list.dart';
import 'package:example/utils/fruits.dart';
import 'package:flutter/material.dart';
import 'package:fuzzy/fuzzy.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auto Animated List Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const _limit = 10;
  String _query = '';

  List<String> get _displayedFruits {
    final fuzzy = Fuzzy<String>(
      Fruits.list,
      options: FuzzyOptions(
        threshold: 0.5,
        keys: [
          WeightedKey(name: 'name', getter: (fruit) => fruit, weight: 1),
        ],
      ),
    );
    final results = fuzzy.search(_query);
    return results
        .getRange(0, results.length > _limit ? _limit : results.length)
        .map((result) => result.item)
        .toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auto Animated List Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _SearchInputField(
              onChanged: (value) => setState(() => _query = value),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: AutoAnimatedList<String>(
                items: _displayedFruits,
                itemBuilder: (context, fruit, index, animation) {
                  return SizeFadeTransition(
                    animation: animation,
                    child: ListTile(
                      leading: Text('${index + 1}'),
                      title: Text(fruit),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchInputField extends StatelessWidget {
  const _SearchInputField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  final ValueSetter<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      decoration: const InputDecoration(
        labelText: 'Search',
        focusedBorder: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(),
      ),
    );
  }
}
