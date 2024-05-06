import 'package:flutter/material.dart';

class LabelTap extends StatelessWidget {

  final String label;
  final Function()? onTap;
  final double? fontSize;

  const LabelTap({
    super.key,
    required this.label,
    required this.onTap,
    this.fontSize
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
      label,
      style: TextStyle(
        fontSize: fontSize ?? 16
      ),
    )
    );
  }
}