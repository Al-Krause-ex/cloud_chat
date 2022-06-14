import 'package:flutter/material.dart';
import 'package:web_socket_learn/app_setting/app_color.dart';
import 'package:web_socket_learn/data/service/api_service.dart';

class NewMessage extends StatefulWidget {
  final String chatId;
  final String senderId;
  final String senderName;

  const NewMessage({
    Key? key,
    required this.chatId,
    required this.senderId,
    required this.senderName,
  }) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final ApiService apiService = ApiService();
  final _controller = TextEditingController();
  var _enteredMessage = '';

  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    Future addMessage() async {
      if (_controller.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Empty title'),
          duration: Duration(seconds: 2),
        ));
        return;
      }

      FocusScope.of(context).unfocus();

      setState(() {
        isLoading = true;
      });

      await apiService.saveMessage(
        text: _controller.text,
        chatId: widget.chatId,
        senderId: widget.senderId,
        senderName: widget.senderName,
      );

      _controller.clear();
      _enteredMessage = '';

      setState(() {
        isLoading = false;
      });
    }

    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
        height: 70,
        width: double.infinity,
        color: Colors.white,
        child: Row(
          children: [
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Введите текст сообщения...',
                  hintStyle: TextStyle(color: AppColor.titleColor),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  setState(() {
                    _enteredMessage = value;
                  });
                },
              ),
            ),
            const SizedBox(width: 15),
            FloatingActionButton(
              onPressed: _enteredMessage.trim().isEmpty || isLoading ? null : addMessage,
              backgroundColor: AppColor.backgroundColor,
              elevation: 0,
              child: const Icon(
                Icons.send,
                color: Colors.white,
                size: 20.0,
              ),
            ),
            const SizedBox(width: 5),
          ],
        ),
      ),
    );
  }
}
