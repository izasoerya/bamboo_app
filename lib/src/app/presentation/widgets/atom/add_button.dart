import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final VoidCallback onTap;
  const AddButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onTap,
      child: Icon(
        Icons.add,
        size: 30,
        color: Theme.of(context).textTheme.bodyMedium!.color,
      ),
    );
  }
}
