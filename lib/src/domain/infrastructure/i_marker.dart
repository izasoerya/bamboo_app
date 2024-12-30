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
    String publicURL = '';
    final oldMarker = await readMarker(marker.uid);
    try {
      if (!marker.urlImage.contains('NULL:')) {
        final String shortImageURL = marker.urlImage.split('file_picker/').last;
        if (marker.urlImage.isNotEmpty) {
          final imageRes =
              await updateImageMarker(marker.urlImage, oldMarker!.urlImage);
          if (!imageRes) {
            print('Error: Image not updated');
          }
          publicURL =
              db.storage.from('bamboo_images').getPublicUrl(shortImageURL);
        }
      }
      final res = await db
          .from('marker')
          .update(marker
              .copyWith(
                uid: _uuid.v4(),
                urlImage: marker.urlImage.contains('NULL:')
                    ? marker.urlImage.split('NULL:').last
                    : publicURL,
              )
              .toJSON())
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
  Future<bool> updateImageMarker(String url, String oldUrl) async {
    final File imageFile = File(url);
    final String shortFileURL = url.split('file_picker/').last;

    try {
      final String relativePath = oldUrl.split('bamboo_images/').last;
      await db.storage.from('bamboo_images').remove([relativePath]);
    } catch (e) {
      print('Error: $e');
    }
    try {
      await db.storage.from('bamboo_images').upload(
            shortFileURL,
            imageFile,
            fileOptions: const FileOptions(upsert: true),
          );
      return true;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  @override
  Future<void> testDeleteImageMarker() async {
    try {
      final res = await db.storage.from('bamboo_images').remove([
        'https://gysbnohwkzlxhlqcfhwn.supabase.co/storage/v1/object/public/bamboo_images/1735372142085/IMG-20241228-WA0044.jpg'
      ]);
      print('Response: $res');
    } catch (e) {
      print('Error: $e');
    }
  }
}
