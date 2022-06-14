import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_learn/app_setting/app_path.dart';
import 'package:web_socket_learn/data/models/user.dart';
import 'package:web_socket_learn/data/repository.dart';

part 'data_state.dart';

class DataCubit extends Cubit<DataState> {
  final Repository repository;

  DataCubit(this.repository) : super(DataInitial(User.empty()));

  Future<bool> signIn(
    context, {
    required String username,
    required String password,
  }) async {
    User? user = await repository.signIn(username, password);
    if (user == null) return false;

    emit(DataAuth(user));
    Navigator.of(context).pushNamed(AppPath.chatsScreen);

    return true;
  }

  void signOut() {
    repository.signOut();
  }

  Future<bool> resetPassword(String email) async {
    return repository.resetPassword(email);
  }
}
