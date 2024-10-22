import 'package:bamboo_app/src/app/blocs/theme_state.dart';
import 'package:bamboo_app/src/app/presentation/themes/ui_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:bamboo_app/src/app/routes/routes.dart';

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
              restorationScopeId: 'app',
              supportedLocales: const [Locale('en', '')],
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
