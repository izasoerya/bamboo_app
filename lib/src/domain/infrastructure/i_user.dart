import 'package:bamboo_app/src/domain/entities/e_user.dart';
import 'package:bamboo_app/src/domain/repositories/r_user.dart';

class InfrastructureUser implements RepositoryUser {
  @override
  Future<EntitiesUser?> createUser(EntitiesUser user) {
    // TODO: implement createUser
    throw UnimplementedError();
  }

  @override
  Future<EntitiesUser?> readUser(String uid) {
    // TODO: implement readUser
    throw UnimplementedError();
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
