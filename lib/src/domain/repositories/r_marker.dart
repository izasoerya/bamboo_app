import 'package:bamboo_app/src/domain/entities/e_marker.dart';

abstract class RepositoryPolygon {
  Future<EntitiesMarker?> createMarker(EntitiesMarker marker);
  Future<EntitiesMarker?> readMarker(String uid);
  Future<List<EntitiesMarker?>> readListMarker(String uidUser);
  Future<EntitiesMarker?> updateMarker(EntitiesMarker marker);
  Future<void> deleteMarker(EntitiesMarker marker);

  Future<bool> createImageMarker(String url);
  Future<bool> updateImageMarker(String url, String oldUrl);
  Future<void> deteleImageMarker(String uidMarker);

  Future<void> testDeleteImageMarker();
}
