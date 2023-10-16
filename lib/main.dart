import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/分摊清单页面/money_AA.dart';
import './pages/ThirdPage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //去掉debug标识
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/second': (context) => const Money_AAPage(),
        '/third': (context) => const MyHomePage(title: 'Soulia'),
      },
    );
  }
}
