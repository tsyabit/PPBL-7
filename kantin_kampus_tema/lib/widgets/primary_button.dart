import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  const PrimaryButton({
    super.key,
    required this.label,
    this.icon,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) => icon == null
      ? ElevatedButton(onPressed: onPressed, child: Text(label))
      : ElevatedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon),
          label: Text(label),
        );
}
