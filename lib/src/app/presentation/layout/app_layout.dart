import 'package:bamboo_app/src/app/blocs/polygon_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppLayout extends StatelessWidget {
  final Widget child;
  const AppLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => PolygonStateBloc(),
        child: SafeArea(child: child),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
