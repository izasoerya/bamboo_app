import 'package:bamboo_app/src/domain/entities/e_marker.dart';
import 'package:bamboo_app/src/domain/infrastructure/i_marker.dart';

class ServiceMarker {
  double area(double base, double height) {
    return base * height / 2;
  }

  Future<List<EntitiesMarker>> fetchPolygon(String uid) async {
    final res = await InfrastructureMarker().readListMarker(uid);
    return res.map((e) => e!).toList();
  }
}
