import 'package:bamboo_app/src/app/routes/routes.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Register'),
          ElevatedButton(
              onPressed: () {
                router.go('/login');
              },
              child: Text('Login')),
        ],
      ),
    );
  }
}
