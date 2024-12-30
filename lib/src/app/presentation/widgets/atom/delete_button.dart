import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  final VoidCallback onTap;
  const DeleteButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.zero, // Ensure no extra padding
        ),
        onPressed: onTap,
        child: Center(
          child: Icon(
            Icons.delete,
            size: 30,
            color: Theme.of(context).textTheme.bodyMedium!.color,
          ),
        ),
      ),
    );
  }
}
