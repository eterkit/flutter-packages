import 'dart:io';

import 'package:edge_detector/edge_detector.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ExamplePage(),
    );
  }
}

class ExamplePage extends StatefulWidget {
  const ExamplePage({
    super.key,
  });

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _setDemoImage();
  }

  @override
  Widget build(BuildContext context) {
    final imageFile = _imageFile;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edge Detector Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16).copyWith(
          bottom: MediaQuery.of(context).padding.bottom + 16,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: imageFile != null
                  ? Center(child: ImageCropper.file(imageFile))
                  : const SizedBox.expand(),
            ),
            ElevatedButton(
              onPressed: _pickImage,
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromHeight(56),
              ),
              child: const Text('Pick image'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _setDemoImage() async {
    final response = await http.get(Uri.parse(_Constants.demoImageUrl));
    final directory = (await getTemporaryDirectory()).path;
    final path = '$directory/edge-detector-demo-image.jpg';
    final file = File(path);
    await file.writeAsBytes(response.bodyBytes);
    setState(() => _imageFile = file);
  }

  Future<void> _pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() => _imageFile = File(image.path));
  }
}

abstract class _Constants {
  static const demoImageUrl =
      'https://media.istockphoto.com/id/1147445388/photo/white-paper-with-clipboard-on-black-background.jpg?b=1&s=170667a&w=0&k=20&c=QpttVdu4j624jgRGi0GjIlaHipsEeO9zEZbsYYe51s8=';
}
