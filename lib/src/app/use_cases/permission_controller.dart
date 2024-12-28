import 'package:device_info_plus/device_info_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionController {
  final void Function(String) callback;

  PermissionController({required this.callback});

  Future<int> _getAndroidSdkVersion() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.version.sdkInt;
  }

  Future<bool> reqLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      callback('Nyalakan GPS dan Tekan Retry');
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        callback('Izinkan Aplikasi Untuk Mengakses Lokasi');
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      openAppSettings();
      callback('Izinkan Aplikasi Untuk Mengakses Lokasi di Pengaturan');
      return false;
    }
    return true;
  }

  Future<bool> reqMediaPermission() async {
    PermissionStatus status;
    if (await Permission.photos.isPermanentlyDenied ||
        await Permission.mediaLibrary.isPermanentlyDenied) {
      openAppSettings();
      callback('Izinkan Aplikasi Untuk Mengakses Lokasi di Pengaturan');
      return false;
    }

    if (await _getAndroidSdkVersion() >= 33) {
      status = await Permission.photos.request();
    } else {
      status = await Permission.storage.request();
    }

    if (status.isDenied) {
      callback('Izinkan Aplikasi Untuk Mengakses Media');
      return false;
    }

    return true;
  }
}
