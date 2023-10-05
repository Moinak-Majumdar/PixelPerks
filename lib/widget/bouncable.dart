import 'package:flutter/material.dart';

class WidgetBounce extends StatefulWidget {
  const WidgetBounce({
    super.key,
    required this.child,
    required this.isAnimating,
    this.onEnd,
    required this.duration,
    this.alwaysAnimated = false,
  });

  final Widget child;
  final bool isAnimating;
  final Duration duration;
  final void Function()? onEnd;
  final bool alwaysAnimated;

  @override
  State<WidgetBounce> createState() => _WidgetBounceState();
}

class _WidgetBounceState extends State<WidgetBounce>
    with SingleTickerProviderStateMixin {
  late AnimationController _ac;
  late Animation<double> scale;

  @override
  void initState() {
    _ac = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: widget.duration.inMilliseconds ~/ 2,
      ),
    );

    super.initState();
  }

  @override
  void didUpdateWidget(covariant WidgetBounce oldWidget) {
    if (widget.isAnimating != oldWidget.isAnimating) {
      if (widget.isAnimating || widget.alwaysAnimated) {
        doAnimation();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  Future doAnimation() async {
    await _ac.forward();
    await _ac.reverse();
    await Future.delayed(const Duration(milliseconds: 200));

    if (widget.onEnd != null) {
      widget.onEnd!();
    }
  }

  @override
  void dispose() {
    _ac.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return ScaleTransition(
      scale: Tween<double>(begin: 1, end: 1.5).animate(_ac),
      child: widget.child,
    );
  }
}
