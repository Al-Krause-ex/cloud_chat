import 'package:flutter/material.dart';
import 'package:web_socket_learn/app_setting/app_path.dart';
import 'package:web_socket_learn/data/models/chat.dart';
import 'package:web_socket_learn/data/models/user.dart';
import 'package:web_socket_learn/data/repository.dart';

class DataManager {
  final Repository repository;

  DataManager(this.repository);

  User user = User.empty();
  late List<Chat> chats;

  Future<bool> signIn({
    required String username,
    required String password,
  }) async {
    user = await repository.signIn(username, password);
    if (user.id.isEmpty) return false;

    return true;
  }

  Future signOut() async {
    await repository.signOut();
  }

  Future<bool> resetPassword(String email) async {
    return repository.resetPassword(email);
  }

  Future<List<Chat>> getChats() async {
    return chats = await repository.getChats(user.id);
  }
}
