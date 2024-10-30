import 'package:bamboo_app/src/domain/entities/e_polygon.dart';
import 'package:bamboo_app/src/domain/repositories/r_polygon.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class InfrastructurePolygon implements RepositoryPolygon {
  final Uuid _uuid = const Uuid();
  final db = FirebaseFirestore.instance;
  @override
  Future<EntitiesPolygon?> createPolygon(EntitiesPolygon polygon) async {
    await db
        .collection('polygons')
        .doc()
        .set(polygon.copyWith(uid: _uuid.v4()).toJSON())
        .onError((error, stackTrace) {
      print('Error: $error');
      return null;
    });
    return polygon;
  }

  @override
  Future<EntitiesPolygon?> readPolygon(String uid) async {
    final polygons =
        await db.collection('polygons').where('uid', isEqualTo: uid).get();
    if (polygons.docs.isNotEmpty) {
      return EntitiesPolygon.fromJSON(polygons.docs.first.data());
    }
    return null;
  }

  @override
  Future<List<EntitiesPolygon?>> readPolygons(String uidUser) async {
    final polygons = await db
        .collection('polygons')
        .where('uidUser', arrayContains: uidUser)
        .get();
    if (polygons.docs.isNotEmpty) {
      print(polygons.docs.first.data());
      return polygons.docs
          .map((e) => EntitiesPolygon.fromJSON(e.data()))
          .toList();
    }
    return [null];
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
