import 'dart:io';

import 'package:auto_crop/auto_crop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(const ExampleApp());

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
  final CropController _cropController = CropController(outputPixelRatio: 3);

  File? _imageFile;
  Uint8List? _croppedData;

  @override
  void initState() {
    super.initState();
    _setInitialImage();
  }

  @override
  Widget build(BuildContext context) {
    final imageFile = _imageFile;
    final croppedData = _croppedData;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auto Crop Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16).copyWith(
          bottom: MediaQuery.of(context).padding.bottom + 16,
        ),
        child: ListView(
          children: [
            Row(
              children: [
                _ActionButton(
                  label: 'Pick image',
                  onPressed: _pickImage,
                ),
                const SizedBox(width: 16),
                _ActionButton(
                  label: 'Crop image',
                  onPressed: _cropImage,
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (imageFile != null)
              AutoCrop(
                imageFile,
                controller: _cropController,
              ),
            if (croppedData != null) ...[
              const SizedBox(height: 16),
              Image.memory(
                croppedData,
              ),
            ]
          ],
        ),
      ),
    );
  }

  Future<void> _setInitialImage() async {
    final bytes = await rootBundle.load('assets/images/sample.jpg');
    final imageData =
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
    final directory = (await getTemporaryDirectory()).path;
    final path = '$directory/edge-detector-demo-image.jpg';
    final file = File(path);
    await file.writeAsBytes(imageData);
    setState(() => _imageFile = file);
  }

  Future<void> _pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() => _imageFile = File(image.path));
  }

  Future<void> _cropImage() async {
    final data = await _cropController.crop();
    if (data == null) return;
    setState(() => _croppedData = data);
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          fixedSize: const Size.fromHeight(56),
        ),
        child: Text(label),
      ),
    );
  }
}
