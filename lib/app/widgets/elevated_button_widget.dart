import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final String label;
  final double height;
  final Gradient gradient;
  final VoidCallback? onPressed;

  const ElevatedButtonWidget({
    super.key,
    required this.onPressed,
    required this.label,
    this.borderRadius,
    this.width,
    this.height = 44.0,
    this.gradient =
        const LinearGradient(colors: [Colors.cyanAccent, Colors.indigo]),
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? BorderRadius.circular(15);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: borderRadius,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
        ),
        child: Text(label, style: Theme.of(context).textTheme.titleLarge),
      ),
    );
  }
}
