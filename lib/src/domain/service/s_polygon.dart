import 'package:bamboo_app/src/domain/infrastructure/i_polygon.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ServicePolygon {
  double area(double base, double height) {
    return base * height / 2;
  }

  Future<List<LatLng>> fetchPolygon(String uid) async {
    final res = await InfrastructurePolygon().readPolygon(uid);
    return res!.polygon;
  }
}
