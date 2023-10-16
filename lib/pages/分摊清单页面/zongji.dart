import 'package:flutter/material.dart';

class Zongji extends StatefulWidget {
  final List<Map<String, String>> dataList;
  final int personCount;

  const Zongji({
    Key? key,
    required this.dataList,
    required this.personCount,
  }) : super(key: key);
  @override
  State<Zongji> createState() => _ZongjiState();
}

class _ZongjiState extends State<Zongji> {
  @override
  Widget build(BuildContext context) {
    // 假设以下是您的数据列表
    // final List<Map<String, String>> dataList = [
    //   {'name': '张三', 'item': '商品1', 'amount': '10'},
    //   {'name': '李四', 'item': '商品2', 'amount': '20'},
    //   {'name': '张三', 'item': '商品3', 'amount': '30'},
    //   {'name': '王五', 'item': '商品4', 'amount': '40'},
    //   {'name': '李四', 'item': '商品5', 'amount': '50'},
    // ];

// 计算每个人的消费总额和所有人的消费总额
    final Map<String, double> personTotal = {};
    double total = 0;
    for (final data in widget.dataList) {
      final name = data['name']!;
      final amount = double.tryParse(data['amount']!) ?? 0;
      personTotal[name] = (personTotal[name] ?? 0) + amount;
      total += amount;
    }

// 计算平均金额
    final perPerson = total / widget.personCount;

    // 构建UI
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        //高度为屏幕高度的1/3
        height: MediaQuery.of(context).size.height * 1 / 5,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('总计($total元)', style: const TextStyle(fontSize: 20)),
            automaticallyImplyLeading: false,
            //修改标题所占空间大小
            toolbarHeight: 40,
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(1),
              child: Divider(),
            ), // 添加下
          ),
          body: ListView(
            addAutomaticKeepAlives: true, //保持列表状态
            children: [
              for (final entry in personTotal.entries)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 50,
                      child: Text(entry.key),
                    ),
                    SizedBox(
                      width: 100,
                      child: Text('支出 ${entry.value}元'),
                    ),
                    if (entry.value - perPerson > 0)
                      SizedBox(
                        width: 100,
                        child: Text('应得 ${entry.value - perPerson}元'),
                      )
                    else
                      SizedBox(
                        width: 100,
                        child: Text('需要给 $perPerson元'),
                      ),
                  ],
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    width: 50,
                    child: Text('其他人'),
                  ),
                  const SizedBox(
                    width: 100,
                    child: Text('支出 0元'),
                  ),
                  SizedBox(
                    width: 100,
                    child: Text('需要给 $perPerson元'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
