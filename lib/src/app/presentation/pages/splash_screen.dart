import 'package:bamboo_app/src/app/presentation/widgets/atom/retry_button.dart';
import 'package:bamboo_app/src/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

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

  Future<void> _requestPermissions() async {
    bool locationGranted = await _requestLocationPermission();
    bool mediaGranted = await _requestMediaPermission();

    if (locationGranted && mediaGranted) {
      router.go('/login');
    }
  }

  Future<bool> _requestLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _error = 'Location services are disabled.';
      });
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _error = 'Location permissions are denied, press Retry to try again.';
        });
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _error =
            'Location permissions are permanently denied. Open app settings to enable.';
      });
      openAppSettings();
      return false;
    }

    return true;
  }

  Future<bool> _requestMediaPermission() async {
    if (await Permission.photos.isGranted ||
        await Permission.mediaLibrary.isGranted) {
      return true;
    }

    PermissionStatus status;
    if (await Permission.photos.isPermanentlyDenied ||
        await Permission.mediaLibrary.isPermanentlyDenied) {
      setState(() {
        _error =
            'Media permissions are permanently denied. Open app settings to enable.';
      });
      openAppSettings();
      return false;
    }

    if (androidSdkVersion >= 33) {
      // Android 13+ uses read-only media permissions.
      status = await Permission.photos.request();
    } else {
      // Android <13 uses legacy storage permissions.
      status = await Permission.storage.request();
    }

    if (status.isDenied) {
      setState(() {
        _error =
            'Media permissions are denied. Press Retry to request permissions again.';
      });
      return false;
    }

    return true;
  }

  int get androidSdkVersion =>
      int.tryParse(Theme.of(context).platform.toString().split(' ')[1]) ?? 0;

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
