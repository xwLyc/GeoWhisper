// lib/main.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'routes.dart'; // 路由配置
import 'pages/home_page.dart'; // 引入新首页

import 'package:permission_handler/permission_handler.dart';

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

// 动态申请定位权限
void requestPermission() async {
  // 申请权限
  bool hasLocationPermission = await requestLocationPermission();
  if (hasLocationPermission) {
    // 权限申请通过
  } else {}
}

/// 申请定位权限
/// 授予定位权限返回true， 否则返回false
Future<bool> requestLocationPermission() async {
  //获取当前的权限
  var status = await Permission.location.status;
  if (status == PermissionStatus.granted) {
    //已经授权
    return true;
  } else {
    //未授权则发起一次申请
    status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }
}
