import 'package:bamboo_app/src/domain/entities/e_marker.dart';
import 'package:bamboo_app/src/domain/repositories/r_marker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class InfrastructureMarker implements RepositoryPolygon {
  final Uuid _uuid = const Uuid();
  final db = FirebaseFirestore.instance;
  @override
  Future<EntitiesMarker?> createMarker(EntitiesMarker polygon) async {
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
  Future<EntitiesMarker?> readMarker(String uid) async {
    final polygons =
        await db.collection('polygons').where('uid', isEqualTo: uid).get();
    if (polygons.docs.isNotEmpty) {
      return EntitiesMarker.fromJSON(polygons.docs.first.data());
    }
    return null;
  }

  @override
  Future<List<EntitiesMarker?>> readListMarker(String uidUser) async {
    final polygons = await db
        .collection('polygons')
        .where('uidUser', arrayContains: uidUser)
        .get();
    if (polygons.docs.isNotEmpty) {
      return polygons.docs
          .map((e) => EntitiesMarker.fromJSON(e.data()))
          .toList();
    }
    return [null];
  }

  @override
  Future<EntitiesMarker?> updateMarker(EntitiesMarker polygon) {
    // TODO: implement updatePolygon
    throw UnimplementedError();
  }

  @override
  Future<void> deleteMarker(String uid) {
    // TODO: implement deletePolygon
    throw UnimplementedError();
  }
}
