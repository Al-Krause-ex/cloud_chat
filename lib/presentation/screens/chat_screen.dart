import 'dart:async';

import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:web_socket_learn/app_setting/app_color.dart';
import 'package:web_socket_learn/data/models/user.dart';
import 'package:web_socket_learn/data/service/api_service.dart';
import 'package:web_socket_learn/presentation/widgets/message_card.dart';
import 'package:web_socket_learn/presentation/widgets/new_message.dart';

class ChatScreen extends StatefulWidget {
  final User user;
  final String chatId;

  const ChatScreen({Key? key, required this.user, required this.chatId})
      : super(key: key);

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final ApiService apiService = ApiService();

  final messageController = TextEditingController();
  final StreamController<List<ParseObject>> streamController =
      StreamController();
  final List<ParseObject> messageList = [];

  final QueryBuilder<ParseObject> queryMessages =
      QueryBuilder<ParseObject>(ParseObject('Message'));

  @override
  void initState() {
    super.initState();

    queryMessages.whereEqualTo(
      'chat',
      (ParseObject('Chats')
            ..parseClassName = 'Chats'
            ..objectId = widget.chatId)
          .toPointer(),
    );

    getMessagesList();
    apiService.startLiveQuery(messageList, streamController, queryMessages);
  }

  @override
  void dispose() {
    apiService.cancelLiveQuery();
    streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Live'),
        backgroundColor: AppColor.backgroundColor,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<List<ParseObject>>(
              stream: streamController.stream,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return const Center(
                      child: SizedBox(
                        width: 60,
                        height: 60,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  default:
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text("Error..."),
                      );
                    }
                    if (!snapshot.hasData) {
                      return const Center(
                        child: Text("No Data..."),
                      );
                    } else {
                      return ListView.builder(
                        padding: const EdgeInsets.only(top: 10.0),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          //*************************************
                          //Get Parse Object Values
                          final msg = snapshot.data![index];
                          final msgTitle = msg.get<String>('text')!;
                          final msgSender = msg['sender']['objectId'];

                          print(widget.user.id);

                          //*************************************

                          return MessageCard(
                            message: msgTitle,
                            userName: msg['senderName'],
                            isMe: widget.user.id == msgSender,
                            createdAt: DateTime.parse(msg['createdAt']),
                            key: ValueKey(msg['objectId']),
                          );
                        },
                      );
                    }
                }
              },
            ),
          ),
          NewMessage(
            chatId: widget.chatId,
            senderId: widget.user.id,
            senderName: widget.user.name,
          ),
        ],
      ),
    );
  }

  Future getMessagesList() async {
    final ParseResponse apiResponse = await queryMessages.query();

    if (apiResponse.success && apiResponse.results != null) {
      messageList.addAll(apiResponse.results as List<ParseObject>);
      streamController.add(apiResponse.results as List<ParseObject>);
    } else {
      messageList.clear();
      streamController.add([]);
    }
  }

  Future addMessage() async {
    if (messageController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Empty title'),
        duration: Duration(seconds: 2),
      ));
      return;
    }
    await apiService.saveMessage(
      text: messageController.text,
      chatId: widget.chatId,
      senderId: widget.user.id,
      senderName: widget.user.name,
    );
    messageController.clear();
  }

  Future deleteMessage(String id) async {
    await apiService.deleteMessage(id).then((value) {
      const snackBar = SnackBar(
        content: Text("Message deleted!"),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(snackBar);
    });
  }
}
