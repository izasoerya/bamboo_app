import 'package:bamboo_app/src/domain/entities/e_marker.dart';
import 'package:bamboo_app/src/domain/repositories/r_marker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class InfrastructureMarker implements RepositoryPolygon {
  final Uuid _uuid = const Uuid();
  final db = Supabase.instance.client;

  @override
  Future<EntitiesMarker?> createMarker(EntitiesMarker marker) async {
    try {
      final res = await db
          .from('marker')
          .insert(marker.copyWith(uid: _uuid.v4()).toJSON())
          .select()
          .single();
      return EntitiesMarker.fromJSON(res);
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  @override
  Future<EntitiesMarker?> readMarker(String uid) async {
    try {
      final res = await db.from('marker').select().eq('uid', uid).single();
      return EntitiesMarker.fromJSON(res);
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  @override
  Future<List<EntitiesMarker?>> readListMarker(String uidUser) async {
    try {
      final res =
          await db.from('marker').select().contains('uidUser', [uidUser]);
      return res.map((e) => EntitiesMarker.fromJSON(e)).toList();
    } catch (e) {
      print('Error: $e');
      return [null];
    }
  }

  @override
  Future<EntitiesMarker?> updateMarker(EntitiesMarker marker) {
    // TODO: implement updatePolygon
    throw UnimplementedError();
  }

  @override
  Future<void> deleteMarker(String uid) {
    // TODO: implement deletePolygon
    throw UnimplementedError();
  }
}
