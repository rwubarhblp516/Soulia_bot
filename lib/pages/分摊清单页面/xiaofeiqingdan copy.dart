// ignore_for_file: camel_case_types, unused_field, file_names

import 'package:flutter/material.dart';
import 'zongji.dart';
import 'package:shared_preferences/shared_preferences.dart';

class xiaofeiqingdan extends StatefulWidget {
  const xiaofeiqingdan({Key? key}) : super(key: key);

  @override
  State<xiaofeiqingdan> createState() => _xiaofeiqingdanState();
}

class _xiaofeiqingdanState extends State<xiaofeiqingdan> {
  late SharedPreferences _prefs;

  final List<Map<String, String>> _dataList = []; // 存储用户输入的数据
  bool _isLayoutCompleted = false;
  final TextEditingController _controller = TextEditingController(); // 创建控制器

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
    // 在下一帧绘制之后执行回调函数
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _isLayoutCompleted = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    int personCount = int.tryParse(_controller.text) ?? 0;
    return Center(
        child: Column(children: <Widget>[
      SizedBox(
          //宽度为屏幕宽度
          width: MediaQuery.of(context).size.width,
          //高度为屏幕高度的2/3
          height: MediaQuery.of(context).size.height * 0.85,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Row(
                  children: [
                    Icon(
                      Icons.face_retouching_natural,
                    ),
                    Text('姓名', style: TextStyle(fontSize: 20)),
                    SizedBox(width: 45), // 添加间距
                    Icon(Icons.shopify),
                    Text('物品', style: TextStyle(fontSize: 20)),
                    SizedBox(width: 35), // 添加间距
                    Icon(Icons.flutter_dash),
                    Text('消费金额', style: TextStyle(fontSize: 20)),
                  ],
                ),
                bottom: const PreferredSize(
                  preferredSize: Size.fromHeight(1),
                  child: Divider(),
                ), // 添加分割线
                automaticallyImplyLeading: false,
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                        // height: MediaQuery.of(context).size.height * 0.3,
                        child: ListView.builder(
                      addAutomaticKeepAlives: true,
                      itemCount: _dataList.length,
                      itemBuilder: (context, index) {
                        final data = _dataList[index];
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            SizedBox(
                              width: 70,
                              child: TextField(
                                decoration:
                                    const InputDecoration(hintText: '姓名'),
                                textAlign: TextAlign.center, // 设置文本居中对齐
                                onChanged: (value) {
                                  // 更新数据
                                  setState(() {
                                    data['name'] = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: TextField(
                                decoration:
                                    const InputDecoration(hintText: '物品'),
                                textAlign: TextAlign.center, // 设置文本居中对齐
                                onChanged: (value) {
                                  // 更新数据
                                  setState(() {
                                    data['item'] = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 60,
                              child: TextField(
                                decoration:
                                    const InputDecoration(hintText: '金额'),
                                textAlign: TextAlign.center, // 设置文本居中对齐
                                onChanged: (value) {
                                  // 更新数据
                                  setState(() {
                                    data['amount'] = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 28,
                              height: 28,
                              child: IconButton(
                                icon: const Icon(Icons.delete_sweep_rounded),
                                onPressed: () {
                                  // 删除数据项
                                  setState(() {
                                    _dataList.removeAt(index);
                                  });
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    )),
                    // 增加下划线
                    const Divider(),
                    SizedBox(
                      // height: MediaQuery.of(context).size.height * 0.5,
                      child: Zongji(
                        dataList: _dataList,
                        personCount: personCount,
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: Center(
                        child: TextField(
                          controller: _controller, // 设置控制器
                          textAlign: TextAlign.center, // 设置文本居中对齐
                          decoration: const InputDecoration(
                            hintText: '总人数',
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              floatingActionButton: Stack(
                children: [
                  Positioned(
                    bottom: 16,
                    left: 35,
                    child: FloatingActionButton(
                      onPressed: () {
                        showDialog(
                          // 设置弹窗大小

                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                '清空数据',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              content: const Text('确定要清空所有数据吗？'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('取消'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _dataList.clear();
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('确定'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      mini: true, // 设置为小型按钮
                      heroTag: null,
                      child: const Icon(Icons.refresh),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: FloatingActionButton(
                      onPressed: () {
                        // 添加新的数据项
                        setState(() {
                          _dataList.add({
                            'name': '',
                            'item': '',
                            'amount': '',
                          });
                        });
                      },
                      mini: true, // 设置为小型按钮
                      heroTag: null,
                      child: const Icon(
                        Icons.add,
                      ), // 避免与其他按钮的标签冲突
                    ),
                  )
                ],
              ), // 添加“+”按钮
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endDocked,
            ),
          ))
    ]));
  }
}
