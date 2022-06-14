import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:toast/toast.dart';
import 'package:web_socket_learn/app_setting/app_assets.dart';
import 'package:web_socket_learn/app_setting/app_color.dart';
import 'package:web_socket_learn/domain/cubit/auth_cubit.dart';
import 'package:web_socket_learn/presentation/widgets/reset_password_dialog.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({Key? key}) : super(key: key);

  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cloud Chat'),
        backgroundColor: AppColor.backgroundColor,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
        ),
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            var isLoading = state is AuthLoading;

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Lottie.asset(AppAssets.lottieCloud),
                  TextField(
                    controller: controllerUsername,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.none,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor.titleColor),
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      labelText: 'Логин',
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: controllerPassword,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.none,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor.titleColor),
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      labelText: 'Пароль',
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: AppColor.backgroundColor,
                      fixedSize:
                          Size(MediaQuery.of(context).size.width - 150.0, 50.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: isLoading
                        ? null
                        : () => signIn(context, context.read<AuthCubit>()),
                    child: isLoading
                        ? const SizedBox(
                            height: 20.0,
                            width: 20.0,
                            child: CircularProgressIndicator(
                              color: AppColor.backgroundColor,
                            ),
                          )
                        : const Text('Войти'),
                  ),
                  const SizedBox(height: 15),
                  TextButton(
                    onPressed: () =>
                        resetPassword(context, context.read<AuthCubit>()),
                    child: const Text(
                      'Сбросить пароль',
                      style: TextStyle(
                        color: AppColor.buttonColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void signIn(context, AuthCubit authCubit) async {
    final username = controllerUsername.text.trim();
    final password = controllerPassword.text.trim();

    if (username.isEmpty || password.isEmpty) {
      Toast.show(
        'Заполните логин и пароль',
        duration: Toast.lengthShort,
        gravity: Toast.bottom,
        backgroundColor: Colors.red,
      );
      return;
    }

    authCubit.workWithLoading();

    var isSigned =
        await authCubit.signIn(context, username: username, password: password);

    authCubit.workWithLoading();

    if (!isSigned) {
      Toast.show(
        'Неправильно введён логин или пароль',
        duration: Toast.lengthShort,
        gravity: Toast.bottom,
        backgroundColor: Colors.red,
      );
    }
  }

  void resetPassword(context, AuthCubit authCubit) async {
    var controllerEmail = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => ResetPasswordDialog(
        controllerEmail: controllerEmail,
        authCubit: authCubit,
      ),
    );
  }
}
