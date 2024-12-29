import 'package:bamboo_app/src/domain/entities/e_marker.dart';
import 'package:bamboo_app/src/domain/infrastructure/i_marker.dart';

class ServiceMarker {
  Future<Set<EntitiesMarker>> fetchListMarker(String uid) async {
    final res = await InfrastructureMarker().readListMarker(uid);
    return res.where((e) => e != null).map((e) => e!).toSet();
  }

  Future<EntitiesMarker> fetchMarker(String uidMarker) async {
    final res = await InfrastructureMarker().readMarker(uidMarker);
    return res!;
  }

  Future<void> addMarker(EntitiesMarker marker) async {
    await InfrastructureMarker().createMarker(marker);
  }

  Future<void> updateMarker(EntitiesMarker marker) async {
    await InfrastructureMarker().updateMarker(marker);
  }

  Future<void> testDeleteImageMarker() async {
    await InfrastructureMarker().testDeleteImageMarker();
  }
}
