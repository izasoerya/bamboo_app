import 'package:bamboo_app/src/app/presentation/widgets/atom/header_auth.dart';
import 'package:bamboo_app/src/app/presentation/widgets/atom/modal_snackbar.dart';
import 'package:bamboo_app/src/app/use_cases/auth_controller.dart';
import 'package:bamboo_app/src/domain/entities/e_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:bamboo_app/src/app/routes/routes.dart';
import 'package:bamboo_app/utils/textfield_validator.dart';
import 'package:bamboo_app/src/app/presentation/widgets/atom/auth_text_field.dart';
import 'package:uuid/uuid.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _controllerName = TextEditingController();
  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();
  final Uuid _uuid = const Uuid();

  @override
  void dispose() {
    _controllerName.dispose();
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.05.sw, vertical: 0.05.sh),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          const HeaderAuth(
            heading: 'Daftar',
            subheading: 'Daftar untuk Melanjutkan',
          ),
          SizedBox(height: 0.03.sh),
          AuthTextField(
            controller: _controllerName,
            validator: TextfieldValidator.validator(TextFieldType.name),
            hintText: 'Nama',
            label: 'Nama',
          ),
          SizedBox(height: 0.02.sh),
          AuthTextField(
            controller: _controllerEmail,
            validator: TextfieldValidator.validator(TextFieldType.email),
            hintText: 'Email',
            label: 'Email',
          ),
          SizedBox(height: 0.02.sh),
          AuthTextField(
            controller: _controllerPassword,
            validator: TextfieldValidator.validator(TextFieldType.password),
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
                  final res = await const AuthController().signUp(
                    EntitiesUser(
                      uid: _uuid.v4(),
                      name: _controllerName.text,
                      email: _controllerEmail.text,
                      password: _controllerPassword.text,
                    ),
                  );
                  if (context.mounted) {
                    res
                        ? ModalSnackbar(context).show('Daftar Berhasil')
                        : ModalSnackbar(context).show('Daftar Gagal');
                  }
                },
                child: Text(
                  'Daftar',
                  style: Theme.of(context).textTheme.bodyLarge!,
                ),
              ),
            ],
          ),
          SizedBox(height: 0.025.sh),
          TextButton(
            onPressed: () => router.go('/login'),
            child: const Text('Sudah Punya Akun? Masuk'),
          ),
        ],
      ),
    );
  }
}
