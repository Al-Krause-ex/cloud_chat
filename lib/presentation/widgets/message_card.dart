import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_socket_learn/app_setting/app_color.dart';

class MessageCard extends StatelessWidget {
  final String message;
  final String userName;
  final bool isMe;
  final DateTime createdAt;

  const MessageCard({
    Key? key,
    required this.message,
    required this.userName,
    required this.isMe,
    required this.createdAt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return t();
    // Container(
    //   width: 300.0,
    //   decoration: BoxDecoration(
    //     color: isMe ? AppColor.buttonColor : const Color(0xffE3EDFF),
    //     borderRadius: BorderRadius.only(
    //       topRight: const Radius.circular(10.0),
    //       topLeft: const Radius.circular(10.0),
    //       bottomRight:
    //           isMe ? const Radius.circular(0.0) : const Radius.circular(10.0),
    //       bottomLeft:
    //           isMe ? const Radius.circular(10.0) : const Radius.circular(0.0),
    //     ),
    //   ),
    //   padding: const EdgeInsets.all(12.0),
    //   margin: isMe
    //       ? const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 20.0)
    //       : const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 20.0),
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       if (!isMe)
    //         Text(
    //           userName,
    //           style: const TextStyle(
    //             fontSize: 16.0,
    //             fontWeight: FontWeight.w500,
    //             color: AppColor.titleColor,
    //           ),
    //         ),
    //       if (!isMe) const SizedBox(height: 6.0),
    //       Text(
    //         message,
    //         style: TextStyle(color: isMe ? Colors.white : AppColor.titleColor),
    //       ),
    //       const SizedBox(height: 6.0),
    //       Align(
    //         alignment: Alignment.bottomRight,
    //         child: Text(
    //           '13:00',
    //           style: TextStyle(
    //               color: isMe ? Colors.white : AppColor.titleColor,
    //               fontSize: 12.0),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }

  Widget t() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(
            left: 14.0,
            right: 14.0,
            top: 10.0,
            bottom: 5.0,
          ),
          margin: EdgeInsets.only(
            left: isMe ? 40.0 : 0.0,
            right: isMe ? 0.0 : 40.0,
          ),
          child: Align(
            alignment: (isMe ? Alignment.topRight : Alignment.topLeft),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: (isMe ? AppColor.buttonColor : Colors.grey.shade200),
              ),
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 16.0,
                bottom: 16.0,
              ),
              constraints: const BoxConstraints(minWidth: 110.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isMe)
                    Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: AppColor.titleColor,
                      ),
                    ),
                  if (!isMe) const SizedBox(height: 6.0),
                  Text(
                    message,
                    style: TextStyle(
                      color: isMe ? Colors.white : AppColor.titleColor,
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              right: isMe ? 20.0 : 0.0, left: isMe ? 0.0 : 20.0, bottom: 10.0),
          child: Align(
            alignment: isMe ? Alignment.topRight : Alignment.topLeft,
            child: Text(
              '${createdAt.day} ${getMonthName(createdAt.month)}, ${DateFormat('HH:mm').format(createdAt)}',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: AppColor.titleColor.withOpacity(0.7),
                fontSize: 13.0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  String getMonthName(int monthNum) {
    switch (monthNum) {
      case 1:
        return 'Янв';
      case 2:
        return 'Фев';
      case 3:
        return 'Мар';
      case 4:
        return 'Апр';
      case 5:
        return 'Май';
      case 6:
        return 'Июн';
      case 7:
        return 'Июл';
      case 8:
        return 'Авг';
      case 9:
        return 'Сен';
      case 10:
        return 'Окт';
      case 11:
        return 'Ноя';
      case 12:
        return 'Дек';
      default:
        return '';
    }
  }
}
