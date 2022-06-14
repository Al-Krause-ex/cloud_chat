import 'package:web_socket_learn/data/models/chat.dart';
import 'package:web_socket_learn/data/models/user.dart';
import 'package:web_socket_learn/data/service/api_service.dart';
import 'package:web_socket_learn/data/service/auth_service.dart';

class Repository {
  final AuthService _authService = AuthService();
  final ApiService _apiService = ApiService();

  Future<User> signIn(String username, String password) async {
    return _authService.signIn(username: username, password: password);
  }

  void signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    await _authService.signUp(
      username: username,
      email: email,
      password: password,
    );
  }

  signOut() async {
    await _authService.signOut();
  }

  Future<bool> resetPassword(String email) async {
    return _authService.resetPassword(email);
  }

  Future<List<Chat>> getChats(String id) async {
    return _apiService.getChatsList(id);
  }
}
