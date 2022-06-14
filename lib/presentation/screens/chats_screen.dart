import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:web_socket_learn/app_setting/app_color.dart';
import 'package:web_socket_learn/app_setting/app_path.dart';
import 'package:web_socket_learn/data/service/api_service.dart';
import 'package:web_socket_learn/domain/cubit/chats_list_cubit.dart';
import 'package:web_socket_learn/presentation/widgets/alert_dialog_quit.dart';

class ChatsScreen extends StatelessWidget {
  ChatsScreen({Key? key}) : super(key: key);

  final ApiService apiService = ApiService();
  final List<ParseObject> chatsList = [];

  @override
  Widget build(BuildContext context) {
    final chatsCubit = BlocProvider.of<ChatsListCubit>(context);
    chatsCubit.getChats();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats Screen'),
        backgroundColor: AppColor.backgroundColor,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (ctx) =>
                  AlertDialogQuit(dataManager: chatsCubit.dataManager),
            );
          },
          icon: const Icon(Icons.exit_to_app),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              Navigator.of(context).pushNamed(AppPath.roadMapScreen);
            },
          )
        ],
      ),
      body: BlocBuilder<ChatsListCubit, ChatsListState>(
        builder: (context, state) {
          if (state is ChatsListLoaded) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.builder(
                itemBuilder: ((ctx, i) => InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          AppPath.chatScreen,
                          arguments: {
                            'user': state.user,
                            'chatId': state.chats[i].id,
                          },
                        );
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                          color: AppColor.buttonColor,
                        ),
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          state.chats[i].name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )),
                itemCount: state.chats.length,
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
