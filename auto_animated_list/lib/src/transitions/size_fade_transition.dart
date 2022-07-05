import 'package:flutter/material.dart';

/// Transition that animates the size and the opacity of a widget.
class SizeFadeTransition extends StatefulWidget {
  /// Creates transition that animates the size and the opacity of a widget.
  const SizeFadeTransition({
    Key? key,
    required this.animation,
    required this.child,
    this.sizeFraction = 0.7,
  }) : super(key: key);

  /// The animation that controls the transition.
  final Animation<double> animation;

  /// The widget to animate.
  final Widget child;

  /// How long the [Interval] for the [SizeTransition] should be.
  ///
  /// The value must be between 0 and 1. Defaults to 0.7.
  ///
  /// For example a `sizeFraction` of `0.7` would result in `Interval(0.0, 0.7)`
  /// for the size animation and `Interval(0.7, 1.0)` for the opacity animation.
  final double sizeFraction;

  @override
  State<SizeFadeTransition> createState() => _SizeFadeTransitionState();
}

class _SizeFadeTransitionState extends State<SizeFadeTransition> {
  late Animation<double> _size;
  late Animation<double> _opacity;
  @override
  void initState() {
    super.initState();
    _handleAnimationUpdated();
  }

  @override
  void didUpdateWidget(SizeFadeTransition oldWidget) {
    super.didUpdateWidget(oldWidget);
    _handleAnimationUpdated();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: _size,
      child: FadeTransition(
        opacity: _opacity,
        child: widget.child,
      ),
    );
  }

  void _handleAnimationUpdated() {
    final curvedAnimation = CurvedAnimation(
      parent: widget.animation,
      curve: Curves.easeInOut,
    );
    _size = CurvedAnimation(
      curve: Interval(0, widget.sizeFraction),
      parent: curvedAnimation,
    );
    _opacity = CurvedAnimation(
      curve: Interval(widget.sizeFraction, 1),
      parent: curvedAnimation,
    );
  }
}
