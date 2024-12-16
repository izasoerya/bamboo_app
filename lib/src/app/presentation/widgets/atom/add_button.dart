import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final VoidCallback onTap;
  const AddButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onTap,
      child: const Icon(Icons.add, size: 30),
    );
  }
}
