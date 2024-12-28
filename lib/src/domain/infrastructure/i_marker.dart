import 'dart:io';

import 'package:bamboo_app/src/domain/entities/e_marker.dart';
import 'package:bamboo_app/src/domain/repositories/r_marker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class InfrastructureMarker implements RepositoryPolygon {
  final Uuid _uuid = const Uuid();
  final db = Supabase.instance.client;

  @override
  Future<EntitiesMarker?> createMarker(EntitiesMarker marker) async {
    String publicURL = '';
    try {
      final String shortImageURL = marker.urlImage.split('file_picker/').last;
      if (marker.urlImage.isNotEmpty) {
        final imageRes = await createImageMarker(marker.urlImage);
        if (!imageRes) {
          print('Error: Image not uploaded');
        }
        publicURL =
            db.storage.from('bamboo_images').getPublicUrl(shortImageURL);
      }
      final res = await db
          .from('marker')
          .insert(marker
              .copyWith(
                uid: _uuid.v4(),
                urlImage: publicURL,
              )
              .toJSON())
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
  Future<EntitiesMarker?> updateMarker(EntitiesMarker marker) async {
    print(marker.uid);
    try {
      final res = await db
          .from('marker')
          .update(marker.copyWith(uid: _uuid.v4()).toJSON())
          .eq('uid', marker.uid)
          .select()
          .single();
      return EntitiesMarker.fromJSON(res);
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  @override
  Future<void> deleteMarker(String uid) {
    // TODO: implement deletePolygon
    throw UnimplementedError();
  }

  @override
  Future<bool> createImageMarker(String url) async {
    final File imageFile = File(url);
    final String shortFileURL = url.split('file_picker/').last;

    try {
      await db.storage.from('bamboo_images').upload(shortFileURL, imageFile);
      return true;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  @override
  Future<void> deleteImageMarker() {
    // TODO: implement deleteImageMarker
    throw UnimplementedError();
  }
}
