import 'package:flutter/material.dart';
import 'package:web_socket_learn/app_setting/app_path.dart';
import 'package:web_socket_learn/domain/managers/data_manager.dart';

class AlertDialogQuit extends StatefulWidget {
  final DataManager dataManager;

  const AlertDialogQuit({Key? key, required this.dataManager})
      : super(key: key);

  @override
  AlertDialogQuitState createState() => AlertDialogQuitState();
}

class AlertDialogQuitState extends State<AlertDialogQuit> {
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !isLoading,
      child: AlertDialog(
        title: const Text('Выйти из аккаунта?'),
        actions: [
          TextButton(
            onPressed: () async {
              setState(() {
                isLoading = true;
              });

              await widget.dataManager.signOut().then((value) {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed(AppPath.authScreen);

                setState(() {
                  isLoading = false;
                });
              });
            },
            child: isLoading
                ? const SizedBox(
                    width: 17.0,
                    height: 17.0,
                    child: CircularProgressIndicator(strokeWidth: 3.0),
                  )
                : const Text('ДА'),
          ),
          TextButton(
              onPressed: isLoading
                  ? null
                  : () {
                      Navigator.of(context).pop();
                    },
              child: const Text('НЕТ')),
        ],
      ),
    );
  }
}
