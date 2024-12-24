import 'package:bamboo_app/src/domain/entities/e_marker.dart';
import 'package:bamboo_app/src/domain/infrastructure/i_marker.dart';

class ServiceMarker {
  Future<Set<EntitiesMarker>> fetchMarker(String uid) async {
    final res = await InfrastructureMarker().readListMarker(uid);
    return res.where((e) => e != null).map((e) => e!).toSet();
  }

  Future<void> addMarker(EntitiesMarker marker) async {
    await InfrastructureMarker().createMarker(marker);
  }

  Future<void> updateMarker(EntitiesMarker marker) async {
    await InfrastructureMarker().updateMarker(marker);
  }
}
