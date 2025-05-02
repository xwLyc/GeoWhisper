import 'package:flutter/material.dart';
import 'pages/message_list_page.dart';
import 'routes.dart'; // 引入路由配置

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
      home: const MessageListPage(),
      routes: appRoutes,
      onGenerateRoute: generateRoute, // ✅ 必须启用动态路由
    );
  }
}
