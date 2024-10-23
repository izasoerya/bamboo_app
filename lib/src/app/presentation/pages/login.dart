import 'package:bamboo_app/src/app/presentation/widgets/atom/role_account.dart';
import 'package:bamboo_app/src/domain/service/s_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:bamboo_app/src/app/routes/routes.dart';
import 'package:bamboo_app/src/app/use_cases/textfield_validator.dart';
import 'package:bamboo_app/src/app/presentation/widgets/atom/auth_text_field.dart';
import 'package:bamboo_app/src/app/presentation/widgets/atom/toggle_ui_mode.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();
  final _validatorEmail = TextfieldValidator.email;
  final _validatorPassword = TextfieldValidator.password;

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 1.sw,
        height: 0.6.sh,
        margin: EdgeInsets.symmetric(horizontal: 0.05.sw),
        padding: EdgeInsets.symmetric(vertical: 0.03.sh, horizontal: 0.05.sw),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Masuk',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Masuk Untuk Melanjutkan',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyMedium!.color,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                const ToggleUIModeButton(),
              ],
            ),
            SizedBox(height: 0.03.sh),
            RoleAccount(onChanged: (bool isUser) => print(isUser)),
            SizedBox(height: 0.03.sh),
            AuthTextField(
              controller: _controllerEmail,
              validator: _validatorEmail,
              hintText: 'Email',
              label: 'Email',
            ),
            SizedBox(height: 0.02.sh),
            AuthTextField(
              controller: _controllerPassword,
              validator: _validatorPassword,
              hintText: 'Password',
              label: 'Password',
            ),
            SizedBox(height: 0.02.sh),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    final res = await ServiceUser().signIn(
                      _controllerEmail.text,
                      _controllerPassword.text,
                    );
                    if (res != null) router.go('/dashboard');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Email atau Password Salah'),
                      ),
                    );
                  },
                  child: Text(
                    'Login',
                    style: Theme.of(context).textTheme.bodyLarge!,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Lupa Password?'),
                ),
              ],
            ),
            SizedBox(height: 0.025.sh),
            TextButton(
              onPressed: () {},
              child: const Text('Belum Punya Akun? Buat Akun'),
            ),
          ],
        ),
      ),
    );
  }
}
