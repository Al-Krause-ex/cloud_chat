import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:web_socket_learn/data/models/user.dart';

class AuthService {
  Future<User?> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    final userParse = ParseUser.createUser(username, password, email);
    final response = await userParse.signUp();

    if (!response.success) return null;

    final jsonResponse = {
      'id': response.result['objectId'],
      'name': response.result['name'],
      'email': response.result['email'],
    };

    var user = User.fromJson(jsonResponse);

    return user;
  }

  Future<User> signIn({
    required String username,
    required String password,
  }) async {
    final userParse = ParseUser(username, password, null);
    final response = await userParse.login();

    if (!response.success) return User.empty();

    final jsonResponse = {
      'id': response.result['objectId'],
      'name': response.result['name'],
      'email': response.result['email'],
    };

    var user = User.fromJson(jsonResponse);

    return user;
  }

  Future signOut() async {
    final user = await ParseUser.currentUser() as ParseUser;
    var response = await user.logout();
  }

  Future hasLogged() async {
    ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
    if (currentUser == null) {
      return false;
    }

    final ParseResponse? parseResponse =
        await ParseUser.getCurrentUserFromServer(currentUser.sessionToken!);

    if (parseResponse?.success == null || !parseResponse!.success) {
      await currentUser.logout();
      return false;
    } else {
      return true;
    }
  }

  Future<bool> resetPassword(String email) async {
    final ParseUser user = ParseUser(null, null, email);
    final ParseResponse parseResponse = await user.requestPasswordReset();

    return parseResponse.success;
  }
}
