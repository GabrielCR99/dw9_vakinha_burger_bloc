import 'package:flutter/material.dart';

final class DeliveryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double width;
  final double height;

  const DeliveryButton({
    required this.label,
    required this.width,
    required this.onPressed,
    this.height = 50,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(onPressed: onPressed, child: Text(label)),
    );
  }
}
