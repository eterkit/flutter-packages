// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:custom_cropper/src/models/models.dart';

/// Widget that represents single edge from [edges].
class EdgeItem extends StatelessWidget {
  /// Default constructor for [EdgeItem].
  const EdgeItem(
    this.edge, {
    super.key,
    required this.edgeAttributes,
  });

  /// The point where the edge has to be rendered.
  final Offset edge;

  /// Options to customize the edge style.
  final EdgeAttributes edgeAttributes;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: edgeAttributes.size,
      height: edgeAttributes.size,
      decoration: BoxDecoration(
        color: edgeAttributes.color,
        shape: BoxShape.circle,
      ),
    );
  }
}
