import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bamboo_app/src/app/blocs/theme_state.dart';

class ToggleUIModeButton extends StatelessWidget {
  const ToggleUIModeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeStateBloc, ThemeState>(
      builder: (context, state) {
        return Container(
          alignment: Alignment.centerRight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.secondary,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(
              state.themeMode == ThemeMode.light
                  ? Icons.wb_sunny
                  : Icons.nightlight_round,
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
            onPressed: () =>
                context.read<ThemeStateBloc>().add(ToggleThemeEvent()),
          ),
        );
      },
    );
  }
}
