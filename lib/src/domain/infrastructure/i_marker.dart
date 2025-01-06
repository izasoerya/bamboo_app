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
    String shortImageURL = '';
    if (marker.urlImage.contains('file_picker/')) {
      shortImageURL = marker.urlImage.split('file_picker/').last;
    }
    if (marker.urlImage.contains('cache/')) {
      shortImageURL = marker.urlImage.split('cache/').last;
    }
    try {
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
    String shortImageURL = '';
    if (marker.urlImage.contains('file_picker/')) {
      shortImageURL = marker.urlImage.split('file_picker/').last;
    }
    if (marker.urlImage.contains('cache/')) {
      shortImageURL = marker.urlImage.split('cache/').last;
    }
    try {
      if (!marker.urlImage.contains('NULL:')) {
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
  Future<void> deleteMarker(EntitiesMarker marker) async {
    try {
      if (marker.urlImage.isNotEmpty) {
        await deteleImageMarker(marker.urlImage);
      }
      await db.from('marker').delete().eq('uid', marker.uid);
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Future<bool> createImageMarker(String url) async {
    final File imageFile = File(url);
    String shortFileURL = '';
    if (url.contains('file_picker/')) {
      shortFileURL = url.split('file_picker/').last;
    }
    if (url.contains('cache/')) {
      shortFileURL = url.split('cache/').last;
    }
    print('url: $url');
    print('short url: $shortFileURL');
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
    String shortImageURL = '';
    if (url.contains('file_picker/')) {
      shortImageURL = url.split('file_picker/').last;
    }
    if (url.contains('cache/')) {
      shortImageURL = url.split('cache/').last;
    }

    try {
      final String relativePath = oldUrl.split('bamboo_images/').last;
      await db.storage.from('bamboo_images').remove([relativePath]);
    } catch (e) {
      print('Error: $e');
    }
    try {
      await db.storage.from('bamboo_images').upload(
            shortImageURL,
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
  Future<void> deteleImageMarker(String url) async {
    final String relativePath = url.split('bamboo_images/').last;

    try {
      await db.storage.from('bamboo_images').remove([relativePath]);
    } catch (e) {
      print('Error: $e');
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
