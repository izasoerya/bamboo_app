import 'package:flutter/material.dart';

class RetryButton extends StatelessWidget {
  final VoidCallback onTap;
  const RetryButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: const Text('Retry'),
    );
  }
}
