import 'package:flutter/material.dart';

class ButtonWithDescription extends StatelessWidget {
  const ButtonWithDescription({
    super.key,
    required this.label,
    required this.description,
    required this.onPressed,
  });

  final String label;
  final String description;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          description,
          textAlign: TextAlign.center,
          style: Theme.of(context).primaryTextTheme.titleMedium?.copyWith(
            color: Theme.of(context).focusColor,
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: onPressed,
          child: Text(label),
        ),
      ],
    );
  }
}
