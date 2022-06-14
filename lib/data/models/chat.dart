import 'package:web_socket_learn/data/models/message.dart';

class Chat {
  String id;
  String name;
  String adminId;
  List<Message> messages;

  Chat({
    required this.id,
    required this.name,
    required this.adminId,
    required this.messages,
  });
}
