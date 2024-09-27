import 'package:flutter/material.dart';

class Error404Page extends StatelessWidget {
  const Error404Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Страница не найдена')),
      body: const Center(
        child: Text(
          'Ошибка 404',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Color.fromARGB(255, 40, 38, 38),
            fontSize: 26,
          ),
        ),
      ),
    );
  }
}
