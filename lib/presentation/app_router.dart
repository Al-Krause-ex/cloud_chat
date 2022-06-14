import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_learn/app_setting/app_path.dart';
import 'package:web_socket_learn/domain/cubit/auth_cubit.dart';
import 'package:web_socket_learn/domain/cubit/chats_list_cubit.dart';
import 'package:web_socket_learn/domain/managers/data_manager.dart';
import 'package:web_socket_learn/presentation/screens/auth_screen.dart';
import 'package:web_socket_learn/presentation/screens/chat_screen.dart';
import 'package:web_socket_learn/presentation/screens/chats_screen.dart';
import 'package:web_socket_learn/presentation/screens/road_map_screen.dart';

class AppRouter {
  final DataManager dataManager;

  AppRouter(this.dataManager);

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppPath.authScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (ctx) => AuthCubit(dataManager),
            child: AuthScreen(),
          ),
        );
      case AppPath.chatScreen:
        var args = settings.arguments as Map<String, dynamic>;

        return MaterialPageRoute(
          builder: (ctx) =>
              ChatScreen(user: args['user'], chatId: args['chatId']),
        );
      case AppPath.chatsScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (ctx) => ChatsListCubit(dataManager),
            child: ChatsScreen(),
          ),
        );

      case AppPath.roadMapScreen:
        return MaterialPageRoute(
          builder: (ctx) => RoadMapScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (ctx) => AuthScreen(),
        );
    }
  }
}
