import 'package:bamboo_app/src/app/blocs/marker_state.dart';
import 'package:bamboo_app/src/app/routes/routes.dart';
import 'package:bamboo_app/src/domain/service/s_marker.dart';
import 'package:bamboo_app/utils/default_user.dart';
import 'package:bamboo_app/utils/util_excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppLayout extends StatelessWidget {
  final Widget child;
  const AppLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MarkerStateBloc>(
          create: (context) => MarkerStateBloc(),
        ),
      ],
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).secondaryHeaderColor,
                ),
                child: Text(
                  'Menu Tambahan',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                title: const Text('Download CSV'),
                leading: const Icon(Icons.download),
                onTap: () async => UtilExcel().createExcel(
                    await ServiceMarker().fetchListMarker(defaultUser.uid)),
              ),
              ListTile(
                title: const Text('Logout'),
                leading: const Icon(Icons.logout),
                onTap: () => router.go('/login'),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            child,
            Positioned(
              top: 40,
              left: 20,
              child: Builder(
                builder: (context) {
                  return FloatingActionButton(
                    onPressed: () => Scaffold.of(context).openDrawer(),
                    child: Icon(
                      Icons.menu,
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
