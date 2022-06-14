import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:web_socket_learn/app_setting/app_color.dart';
import 'package:web_socket_learn/domain/cubit/auth_cubit.dart';

class ResetPasswordDialog extends StatefulWidget {
  final AuthCubit authCubit;
  final TextEditingController controllerEmail;

  const ResetPasswordDialog({
    Key? key,
    required this.authCubit,
    required this.controllerEmail,
  }) : super(key: key);

  @override
  State<ResetPasswordDialog> createState() => _ResetPasswordDialogState();
}

class _ResetPasswordDialogState extends State<ResetPasswordDialog> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Введите E-mail',
        style: TextStyle(color: AppColor.titleColor),
      ),
      content: TextField(
        controller: widget.controllerEmail,
        keyboardType: TextInputType.emailAddress,
        textCapitalization: TextCapitalization.none,
        autocorrect: false,
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.titleColor),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          labelText: 'E-mail',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.controllerEmail.text = '';
            Navigator.of(context).pop();
          },
          child: const Text('ОТМЕНА'),
        ),
        TextButton(
          onPressed: isLoading
              ? null
              : () async {
                  var email = widget.controllerEmail.text.trim();
                  if (email.isEmpty) {
                    Toast.show(
                      'Введите правильную почту',
                      duration: Toast.lengthLong,
                      gravity: Toast.bottom,
                      backgroundColor: Colors.red,
                    );
                    return;
                  }

                  setState(() {
                    isLoading = true;
                  });

                  await widget.authCubit.resetPassword(email).then((value) {
                    if (value) {
                      Navigator.of(context).pop();
                      Toast.show(
                        'Инструкция по сбросу пароля отправлена на почту',
                        duration: Toast.lengthLong,
                        gravity: Toast.bottom,
                        backgroundColor: Colors.green,
                      );
                    }

                    setState(() {
                      isLoading = false;
                    });
                  });
                },
          child: isLoading
              ? const SizedBox(
                  height: 20.0,
                  width: 20.0,
                  child: CircularProgressIndicator(
                    color: AppColor.backgroundColor,
                  ),
                )
              : const Text('ОТПРАВИТЬ'),
        ),
      ],
    );
  }
}
