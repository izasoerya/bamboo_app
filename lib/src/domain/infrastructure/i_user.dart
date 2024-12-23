import 'package:bamboo_app/src/domain/entities/e_user.dart';
import 'package:bamboo_app/src/domain/repositories/r_user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class InfrastructureUser implements RepositoryUser {
  final Uuid _uuid = const Uuid();
  final db = Supabase.instance.client;

  @override
  Future<EntitiesUser?> createUser(EntitiesUser user) async {
    try {
      final res = await db
          .from('authentication')
          .insert(user.copyWith(uid: _uuid.v4()).toJSON())
          .select()
          .single();
      return EntitiesUser.fromJSON(res);
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  @override
  Future<EntitiesUser?> readUser(String email) async {
    try {
      final res =
          await db.from('authentication').select().eq('email', email).single();
      return EntitiesUser.fromJSON(res);
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  @override
  Future<List<EntitiesUser?>> readUsers() {
    // TODO: implement readUsers
    throw UnimplementedError();
  }

  @override
  Future<EntitiesUser?> updateUser(EntitiesUser user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<void> deleteUser(String uid) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }
}
