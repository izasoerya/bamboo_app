import 'package:bamboo_app/src/app/routes/routes.dart';
import 'package:flutter/material.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text('Splash Screen'),
          ElevatedButton(
            onPressed: () {
              router.go('/login');
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}
