import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:link_manager/generated/l10n.dart';

class Error404Page extends StatelessWidget {
  const Error404Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(S.of(context).error_404_title),
      ),
      body:  Center(
        child: AutoSizeText(
          S.of(context).error_404,
          style:  const TextStyle(
            fontWeight: FontWeight.w700,
            color: Color.fromARGB(255, 40, 38, 38),
            fontSize: 26,
          ),
        ),
      ),
    );
  }
}
