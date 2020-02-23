import 'package:flutter/material.dart';
import 'package:glory/zhihu/page/daily.dart';
import 'package:glory/zhihu/page/package.dart';

void main() => runApp(MyApp());
///知乎日报主界面
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: AppAllPage()
    );
  }
}

