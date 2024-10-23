import 'package:bamboo_app/src/domain/entities/e_polygon.dart';
import 'package:bamboo_app/src/domain/repositories/r_polygon.dart';

class InfrastructurePolygon implements RepositoryPolygon {
  @override
  Future<EntitiesPolygon?> createPolygon(EntitiesPolygon polygon) {
    // TODO: implement createPolygon
    throw UnimplementedError();
  }

  @override
  Future<EntitiesPolygon?> readPolygon(String uid) {
    // TODO: implement readPolygon
    throw UnimplementedError();
  }

  @override
  Future<List<EntitiesPolygon?>> readPolygons() {
    // TODO: implement readPolygons
    throw UnimplementedError();
  }

  @override
  Future<EntitiesPolygon?> updatePolygon(EntitiesPolygon polygon) {
    // TODO: implement updatePolygon
    throw UnimplementedError();
  }

  @override
  Future<void> deletePolygon(String uid) {
    // TODO: implement deletePolygon
    throw UnimplementedError();
  }
}
