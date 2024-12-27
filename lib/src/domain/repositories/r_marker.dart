import 'package:bamboo_app/src/domain/entities/e_marker.dart';

abstract class RepositoryPolygon {
  Future<EntitiesMarker?> createMarker(EntitiesMarker marker);
  Future<EntitiesMarker?> readMarker(String uid);
  Future<List<EntitiesMarker?>> readListMarker(String uidUser);
  Future<EntitiesMarker?> updateMarker(EntitiesMarker marker);
  Future<void> deleteMarker(String uid);
  Future<bool> createImageMarker(String url);
  Future<void> deleteImageMarker();
}
