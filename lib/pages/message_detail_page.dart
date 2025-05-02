import 'package:flutter/material.dart';

class MessageDetailPage extends StatelessWidget {
  final String messageContent;

  const MessageDetailPage({Key? key, required this.messageContent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('消息详情')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(messageContent),
      ),
    );
  }

  // 静态方法：从路由参数中解析数据
  static Route<dynamic> route(RouteSettings settings) {
    final String message = settings.arguments as String;
    return MaterialPageRoute(
      builder: (context) => MessageDetailPage(messageContent: message),
    );
  }
}
