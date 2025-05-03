// lib/main.dart
import 'package:flutter/material.dart';
import 'routes.dart'; // 路由配置
import 'pages/home_page.dart'; // 引入新首页

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '匿名树洞',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const HomePage(), // ✅ 使用 BottomNavigation 封装后的主页
      routes: appRoutes,
      onGenerateRoute: generateRoute,
    );
  }
}
