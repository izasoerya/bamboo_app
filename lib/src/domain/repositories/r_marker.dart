import 'package:bamboo_app/src/domain/entities/e_marker.dart';

abstract class RepositoryPolygon {
  Future<EntitiesMarker?> createMarker(EntitiesMarker polygon);
  Future<EntitiesMarker?> readMarker(String uid);
  Future<List<EntitiesMarker?>> readListMarker(String uidUser);
  Future<EntitiesMarker?> updateMarker(EntitiesMarker polygon);
  Future<void> deleteMarker(String uid);
}
