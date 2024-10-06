import 'package:flutter/material.dart';

class AppLayout extends StatelessWidget {
  final Widget child;
  const AppLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: child),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
