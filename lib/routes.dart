// lib/routes.dart
import 'package:flutter/material.dart';
import 'pages/channel_selection_page.dart';
import 'pages/channel_detail_page.dart';
import '../models/channel.dart';

Map<String, WidgetBuilder> appRoutes = {
  '/channel_selection': (context) => const ChannelSelectionPage(),
};

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/channel_detail':
      // ✅ 从 arguments 中提取 Channel 对象
      final Channel channel = settings.arguments as Channel;
      return MaterialPageRoute(
        builder: (context) => ChannelDetailPage(channel: channel),
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
