import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_learn/data/models/chat.dart';
import 'package:web_socket_learn/data/models/user.dart';
import 'package:web_socket_learn/domain/managers/data_manager.dart';

part 'chats_list_state.dart';

class ChatsListCubit extends Cubit<ChatsListState> {
  final DataManager dataManager;

  ChatsListCubit(this.dataManager) : super(ChatsListInitial([], dataManager.user));

  void getChats() async {
    var chats = await dataManager.getChats();

    emit(ChatsListLoaded(chats, dataManager.user));
  }
}
