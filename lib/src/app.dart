import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:bamboo_app/src/app/routes/routes.dart';
import 'package:bamboo_app/src/app/blocs/theme_state.dart';
import 'package:bamboo_app/src/app/presentation/themes/ui_mode.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      child: BlocProvider(
        create: (context) => ThemeStateBloc(),
        child: BlocBuilder<ThemeStateBloc, ThemeState>(
          builder: (context, state) {
            return MaterialApp.router(
              themeAnimationStyle: AnimationStyle(
                curve: Curves.easeInCirc,
                duration: const Duration(milliseconds: 500),
              ),
              restorationScopeId: 'app',
              theme: UiMode.lightMode,
              darkTheme: UiMode.darkMode,
              themeMode: state.themeMode,
              routerConfig: router,
            );
          },
        ),
      ),
    );
  }
}
