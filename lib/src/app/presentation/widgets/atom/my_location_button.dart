import 'package:flutter/material.dart';

class MyLocationButton extends StatelessWidget {
  final VoidCallback onTap;
  const MyLocationButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onTap,
      child: Icon(
        Icons.my_location,
        size: 30,
        color: Theme.of(context).textTheme.bodyMedium!.color,
      ),
    );
  }
}
