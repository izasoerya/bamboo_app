import 'package:bamboo_app/src/app/routes/routes.dart';
import 'package:bamboo_app/src/domain/entities/e_user.dart';
import 'package:bamboo_app/src/domain/service/s_user.dart';
import 'package:bamboo_app/utils/default_user.dart';

class AuthController {
  const AuthController();

  Future<bool> signIn(String email, String password) async {
    final res = await ServiceUser().signIn(email, password);
    if (res != null) {
      defaultUser = res;
      router.go('/dashboard');
      return true;
    } else {
      return false;
    }
  }

  Future<bool> signUp(EntitiesUser user) async {
    final res = await ServiceUser().signUp(user);
    if (res != null) {
      router.go('/login');
      return true;
    } else {
      return false;
    }
  }
}
