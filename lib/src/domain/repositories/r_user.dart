import 'package:bamboo_app/src/domain/entities/e_user.dart';

abstract class RepositoryUser {
  Future<EntitiesUser?> createUser(EntitiesUser user);
  Future<EntitiesUser?> readUser(String uid);
  Future<List<EntitiesUser?>> readUsers();
  Future<EntitiesUser?> updateUser(EntitiesUser user);
  Future<void> deleteUser(String uid);
}
