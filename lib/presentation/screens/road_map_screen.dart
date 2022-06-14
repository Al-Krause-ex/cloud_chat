import 'package:flutter/material.dart';
import 'package:web_socket_learn/app_setting/app_color.dart';

class RoadMapScreen extends StatelessWidget {
  RoadMapScreen({Key? key}) : super(key: key);

  static const String version = 'Версия 0.0.1';

  final List<Map<String, dynamic>> plans = [
    {
      'title': 'Авторизация',
      'description':
          'Как я буду общаться, если я даже не вошёл?!',
      'isDone': true,
    },
    {
      'title': 'Сброс пароля',
      'description': 'А что если я забыл пароль?',
      'isDone': true,
    },
    {
      'title': 'Загрузка чатов',
      'description': 'Несмотря на то, что чаты нельзя создавать, "уместно" будет их отобразить :)',
      'isDone': true,
    },
    {
      'title': 'Чат - родной мой',
      'description': 'Кстати, мы можем переписываться, даже ограниченное количество функций нам не помешает',
      'isDone': true,
    },
    {
      'title': 'Регистрация',
      'description':
          'Было бы здорово, если бы я сам мог создавать аккаунт!',
      'isDone': false,
    },
    {
      'title': 'Профиль',
      'description':
          'В профиле для начала будет: редактирование имени. Также в него перенесётся выход из аккаунта',
      'isDone': false,
    },
    {
      'title': 'Создание чата',
      'description':
          'Мессенджер - не мессенджер, если мы не можем создавать и удалять свои чаты',
      'isDone': false,
    },
    {
      'title': 'Удаление чата',
      'description':
          'Смотря на созданный ранее план, безумно хочется добавить сюда Удаление чата',
      'isDone': false,
    },
    {
      'title': 'Редактирование чата',
      'description':
          'А как же добавлять и убирать участников чата? Или может изменить название имени чата? Добавим в план и эту задачу.\n\nCRUD вырисовывается!',
      'isDone': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RoadMap'),
        centerTitle: true,
        backgroundColor: AppColor.backgroundColor,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20.0),
          const Text(
            version,
            style: TextStyle(
              color: AppColor.titleColor,
            ),
          ),
          const SizedBox(height: 15.0),
          const Text(
            'Планы',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
              color: AppColor.titleColor,
            ),
          ),
          const SizedBox(height: 5.0),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, i) => Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ]),
                padding: const EdgeInsets.only(
                  left: 10.0,
                  right: 10.0,
                  top: 7.0,
                  bottom: 7.0,
                ),
                margin: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 0.0,
                    right: 10.0,
                    top: 10.0,
                    bottom: 10.0,
                  ),
                  child: Row(
                    children: [
                      Checkbox(value: plans[i]['isDone'], onChanged: (v) {}),
                      const SizedBox(width: 5.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            plans[i]['title'],
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                              color: AppColor.titleColor,
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 123.0,
                            child: Text(
                              plans[i]['description'],
                              style: TextStyle(
                                fontSize: 15.0,
                                color: AppColor.titleColor.withOpacity(0.8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              itemCount: plans.length,
            ),
          ),
        ],
      ),
    );
  }
}
