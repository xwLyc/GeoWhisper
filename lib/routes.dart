// lib/routes.dart
import 'package:flutter/material.dart';
import 'pages/channel_selection_page.dart';
import 'pages/message_chat_page.dart';
import 'models/message_chat.dart';

Map<String, WidgetBuilder> appRoutes = {
  '/channel_selection': (context) => const ChannelSelectionPage(),
};

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/message_chat':
      // ✅ 从 arguments 中提取 MessageChat 对象
      final MessageChat messageChat = settings.arguments as MessageChat;
      return MaterialPageRoute(
        builder: (context) => MessageChatPage(messageChat: messageChat),
      );
    default:
      return _errorRoute();
  }
}

Route<dynamic> _errorRoute() {
  return MaterialPageRoute(
    builder: (_) => Scaffold(
      appBar: AppBar(title: Text('错误')),
      body: Center(child: Text('页面未找到')),
    ),
  );
}
