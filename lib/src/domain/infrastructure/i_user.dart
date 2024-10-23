import 'package:bamboo_app/src/domain/entities/e_user.dart';
import 'package:bamboo_app/src/domain/repositories/r_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InfrastructureUser implements RepositoryUser {
  final db = FirebaseFirestore.instance;
  @override
  Future<EntitiesUser?> createUser(EntitiesUser user) async {
    await db
        .collection('users')
        .doc()
        .set(user.toJSON())
        .onError((error, stackTrace) {
      print('Error: $error');
      return null;
    });
    return user;
  }

  @override
  Future<EntitiesUser?> readUser(String email) async {
    final user =
        await db.collection('users').where('email', isEqualTo: email).get();
    if (user.docs.isNotEmpty) {
      print(user.docs.first.data());
      return EntitiesUser.fromJSON(user.docs.first.data());
    }
    return null;
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
