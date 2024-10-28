import 'package:bamboo_app/src/app/blocs/user_logged_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthLayout extends StatelessWidget {
  final Widget child;
  const AuthLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => UserLoggedStateBloc(),
        child: Center(
          child: IntrinsicHeight(
            child: SingleChildScrollView(
              child: Container(
                width: 1.sw,
                padding: EdgeInsets.symmetric(horizontal: 0.075.sw),
                alignment: Alignment.center,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
