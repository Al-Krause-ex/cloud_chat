import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:web_socket_learn/data/models/chat.dart';

class ApiService {
  static const keyApplicationId = 'zn04QF6GzZtNDhqUNaWvH6410oliNUz9xsSKbUai';
  static const keyClientKey = 'XuCJDS5MFPhJpczFPX0nXczCQ7UnfGv4PweMK4GC';
  static const keyParseServerUrl = 'https://parseapi.back4app.com';
  static const keyLiveQueryUrl = 'https://chat-test.b4a.io';

  final LiveQuery liveQuery = LiveQuery(debug: true);

  late Subscription<ParseObject> subscription;

  static Future<void> init() async {
    await Parse().initialize(
      keyApplicationId,
      keyParseServerUrl,
      clientKey: keyClientKey,
      liveQueryUrl: keyLiveQueryUrl,
      debug: false,
    );
  }

  Future<void> startLiveQuery(
    List<ParseObject> taskList,
    StreamController<List<ParseObject>> streamController,
    QueryBuilder<ParseObject> queryMessage,
  ) async {
    subscription = await liveQuery.client.subscribe(queryMessage);

    subscription.on(LiveQueryEvent.create, (value) {
      debugPrint('*** CREATE ***: $value ');
      taskList.add(value);
      streamController.add(taskList);
    });

    subscription.on(LiveQueryEvent.update, (value) {
      debugPrint('*** UPDATE ***: $value ');
      taskList[taskList
          .indexWhere((element) => element.objectId == value.objectId)] = value;
      streamController.add(taskList);
    });

    subscription.on(LiveQueryEvent.delete, (value) {
      debugPrint('*** DELETE ***: $value ');
      taskList.removeWhere((element) => element.objectId == value.objectId);
      streamController.add(taskList);
    });
  }

  Future<void> cancelLiveQuery() async {
    liveQuery.client.unSubscribe(subscription);
  }

  Future<List<Chat>> getChatsList(String userId) async {
    final List<String> chatIds = [];
    final List<Chat> chats = [];

    final QueryBuilder<ParseObject> queryRelationChats =
        QueryBuilder<ParseObject>(ParseObject('RelationChat'));

    queryRelationChats.whereEqualTo(
      'user',
      (ParseObject('User')
            ..parseClassName = '_User'
            ..objectId = userId)
          .toPointer(),
    );

    final ParseResponse apiResponseRelation = await queryRelationChats.query();

    for (var r in apiResponseRelation.results as List<dynamic>) {
      chatIds.add(r['chatId']['objectId']);
    }

    ///Получаем сами чаты
    final QueryBuilder<ParseObject> queryChats =
        QueryBuilder<ParseObject>(ParseObject('Chats'));

    for (var chatId in chatIds) {
      queryChats.whereEqualTo('objectId', chatId);
    }

    final ParseResponse apiResponseChat = await queryChats.query();

    for (var r in apiResponseChat.results as List<dynamic>) {
      chats.add(Chat(
        id: r['objectId'],
        name: r['name'],
        adminId: r['adminId'],
        messages: [],
      ));
    }

    return chats;
  }

  Future<void> saveMessage({
    required String text,
    required String chatId,
    required String senderId,
    required String senderName,
  }) async {
    final message = ParseObject('Message')
      ..set('text', text)
      ..set('chat', (ParseObject('Chats')..objectId = chatId).toPointer())
      ..set('sender', (ParseObject('_User')..objectId = senderId).toPointer())
      ..set('senderName', senderName);
    await message.save();
  }

  Future<void> getMessagesList(
    List<ParseObject> taskList,
    StreamController<List<ParseObject>> streamController,
    QueryBuilder<ParseObject> queryMessage,
  ) async {
    final ParseResponse apiResponse = await queryMessage.query();

    if (apiResponse.success && apiResponse.results != null) {
      taskList.addAll(apiResponse.results as List<ParseObject>);
      streamController.add(apiResponse.results as List<ParseObject>);
    } else {
      taskList.clear();
      streamController.add([]);
    }
  }

  Future<void> updateMessage(String id, bool done) async {
    var message = ParseObject('Message')..objectId = id;
    await message.save();
  }

  Future<void> deleteMessage(String id) async {
    var message = ParseObject('Message')..objectId = id;
    await message.delete();
  }
}
