// ignore_for_file: camel_case_types
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'xiaofeiqingdan.dart';

class Money_AAPage extends StatefulWidget {
  const Money_AAPage({super.key});

  @override
  State<Money_AAPage> createState() => _Money_AAPageState();
}

class _Money_AAPageState extends State<Money_AAPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //左边添加返回icon
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 20),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        //标题居中
        centerTitle: true,
        title: const Text(
          '分摊清单',
        ),
      ),
      body: const xiaofeiqingdan(),
    );
  }
}
