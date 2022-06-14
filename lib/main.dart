import 'package:flutter/material.dart';
import 'package:web_socket_learn/data/repository.dart';
import 'package:web_socket_learn/data/service/api_service.dart';
import 'package:web_socket_learn/domain/managers/data_manager.dart';
import 'package:web_socket_learn/presentation/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ApiService.init();

  runApp(MyApp(
    appRouter: AppRouter(
      DataManager(Repository()),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRouter}) : super(key: key);

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cloud Chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
