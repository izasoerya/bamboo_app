import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  const SubmitButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}
