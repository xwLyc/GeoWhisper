// lib/routes.dart
import 'package:flutter/material.dart';
import 'pages/channel_selection_page.dart';
import 'pages/message_detail_page.dart';

Map<String, WidgetBuilder> appRoutes = {
  '/channel_selection': (context) => const ChannelSelectionPage(),
};

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/message_detail':
      final String message = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => MessageDetailPage(messageContent: message),
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
