import 'package:bamboo_app/src/domain/entities/e_user.dart';
import 'package:bamboo_app/src/domain/infrastructure/i_user.dart';

class ServiceUser {
  Future<EntitiesUser?> signUp(EntitiesUser user) async {
    final res = await InfrastructureUser().createUser(user);
    return res;
  }

  Future<EntitiesUser?> signIn(String email, String password) async {
    final res = await InfrastructureUser().readUser(email);
    if (res != null) {
      if (res.password == password) {
        return res;
      }
    }
    return null;
  }
}
