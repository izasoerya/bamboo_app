import 'package:bamboo_app/src/domain/entities/e_polygon.dart';

abstract class RepositoryPolygon {
  Future<EntitiesPolygon?> createPolygon(EntitiesPolygon polygon);
  Future<EntitiesPolygon?> readPolygon(String uid);
  Future<List<EntitiesPolygon?>> readPolygons();
  Future<EntitiesPolygon?> updatePolygon(EntitiesPolygon polygon);
  Future<void> deletePolygon(String uid);
}
