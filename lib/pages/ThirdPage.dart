// ignore_for_file: file_names, library_private_types_in_public_api, constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:bubble/bubble.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final GlobalKey<AnimatedListState> _listKey =
      GlobalKey(); //用来调用insert和remove的
  final List<String> _data = []; //聊天记录
  static const String BOT_URL =
      "https://service-i39xofvw-1317262853.jp.apigw.tencentcs.com/release/"; // replace with server address//聊天机器人的地址
  final TextEditingController _queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Soulia"),
      ),
      body: Stack(
        children: <Widget>[
          AnimatedList(
              // key to call remove and insert from anywhere
              key: _listKey, //用来调用insert和remove的
              initialItemCount: _data.length, //初始长度
              itemBuilder:
                  (BuildContext context, int index, Animation animation) {
                //构建聊天记录
                return _buildItem(_data[index], animation, index);
              }),
          Align(
            //输入框
            alignment: Alignment.bottomCenter, //底部居中
            child: TextField(
              decoration: const InputDecoration(
                //输入框样式
                icon: Icon(
                  Icons.edit,
                  color: Color.fromARGB(255, 250, 183, 0),
                ),
                hintText: "输入...",
              ),
              controller: _queryController, //控制器
              textInputAction: TextInputAction.send, //回车键为发送
              onSubmitted: (msg) {
                _getResponse(); //获取机器人的回复
              },
            ),
          )
        ],
      ),
    );
  }

  http.Client _getClient() {
    return http.Client(); //创建一个http客户端
  }

  void _getResponse() {
    //获取机器人的回复
    if (_queryController.text.isNotEmpty) {
      //如果输入框不为空
      _insertSingleItem(_queryController.text); //将输入框的内容插入到聊天记录中
      var client = _getClient(); //创建一个http客户端
      try {
        client.post(
          //发送post请求
          BOT_URL as Uri, //请求地址
          body: {"query": _queryController.text}, //请求体
        ).then((response) {
          //请求成功后的回调
          Map<String, dynamic> data =
              jsonDecode(response.body); //将返回的json数据转换为map
          _insertSingleItem(data['response'] + "<bot>"); //将机器人的回复插入到聊天记录中
        });
      } catch (e) {
        if (kDebugMode) {
          print("Failed -> $e");
        } //请求失败
      } finally {
        client.close(); //关闭http客户端
        _queryController.clear(); //清空输入框
      }
    }
  }

  void _insertSingleItem(String message) {
    //将消息插入到聊天记录中
    _data.add(message);
    _listKey.currentState?.insertItem(_data.length - 1); //插入聊天记录
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildItem(String item, Animation animation, int index) {
    //构建聊天记录
    bool mine = item.endsWith("<bot>"); //判断是否是机器人的回复

    return SizeTransition(
      //动画效果
      sizeFactor: _animation,
      child: Padding(
        //聊天记录的样式
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          alignment: mine ? Alignment.topLeft : Alignment.topRight, //聊天记录的对齐方式
          child: Bubble(
            color: mine ? Colors.blue : Colors.indigo,
            padding: const BubbleEdges.all(10),
            child: Text(item.replaceAll("<bot>", "")),
          ),
        ),
      ),
    );
  }
}
  // const SizeTransition({
  //   super.key,
  //   this.axis = Axis.vertical,
  //   required Animation<double> sizeFactor,
  //   this.axisAlignment = 0.0,
  //   this.child,
  // }) : super(listenable: sizeFactor);
