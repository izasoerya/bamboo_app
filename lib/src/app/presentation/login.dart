import 'package:bamboo_app/src/app/routes/routes.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Login'),
          ElevatedButton(
              onPressed: () {
                router.go('/dashboard');
              },
              child: Text('Dashboard')),
        ],
      ),
    );
  }
}
