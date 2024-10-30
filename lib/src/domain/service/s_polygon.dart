import 'package:bamboo_app/src/domain/entities/e_polygon.dart';
import 'package:bamboo_app/src/domain/infrastructure/i_polygon.dart';

class ServicePolygon {
  double area(double base, double height) {
    return base * height / 2;
  }

  Future<List<EntitiesPolygon>> fetchPolygon(String uid) async {
    final res = await InfrastructurePolygon().readPolygons(uid);
    return res.map((e) => e!).toList();
  }
}
