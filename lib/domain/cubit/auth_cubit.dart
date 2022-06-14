import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_learn/app_setting/app_path.dart';
import 'package:web_socket_learn/domain/managers/data_manager.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final DataManager dataManager;

  AuthCubit(this.dataManager) : super(AuthInitial());

  Future<bool> signIn(
    context, {
    required String username,
    required String password,
  }) async {
    var isLogged =
        await dataManager.signIn(username: username, password: password);

    if (isLogged) {
      emit(AuthLogged());
      Navigator.of(context).pushReplacementNamed(AppPath.chatsScreen);
    }

    return isLogged;
  }

  void signOut() {
    // repository.signOut();
  }

  Future<bool> resetPassword(String email) async {
    return await dataManager.resetPassword(email);
  }

  void workWithLoading() {
    if (state is AuthLoading) {
      emit(AuthLoaded());
    } else {
      emit(AuthLoading());
    }
  }
}
