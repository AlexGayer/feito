import 'package:flutter/material.dart';

class ElevatedButtonPriorityWidget extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final String label;
  final double? width;
  final double height;

  final VoidCallback? onPressed;

  const ElevatedButtonPriorityWidget({
    super.key,
    this.borderRadius,
    this.width,
    required this.label,
    this.height = 44.0,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? BorderRadius.circular(0);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: borderRadius,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
