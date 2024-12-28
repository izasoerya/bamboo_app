import 'package:bamboo_app/src/app/presentation/widgets/atom/retry_button.dart';
import 'package:bamboo_app/src/app/routes/routes.dart';
import 'package:bamboo_app/src/app/use_cases/permission_controller.dart';
import 'package:flutter/material.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  String _error = 'Requesting necessary permissions...';

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  void permissionCallback(String permission) {
    setState(() => _error = permission);
  }

  Future<void> _requestPermissions() async {
    bool pLocation = await PermissionController(callback: permissionCallback)
        .reqLocationPermission();
    bool pMedia = await PermissionController(callback: permissionCallback)
        .reqMediaPermission();

    if (pLocation && pMedia) router.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _error,
            style: TextStyle(
              fontSize: 24,
              color: Theme.of(context).textTheme.bodyMedium!.color,
            ),
            textAlign: TextAlign.center,
          ),
          const Padding(padding: EdgeInsets.only(top: 20)),
          RetryButton(onTap: () async => await _requestPermissions()),
        ],
      ),
    );
  }
}
