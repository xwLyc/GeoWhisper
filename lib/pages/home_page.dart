// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import 'message_square_page.dart';
import 'joined_groups_page.dart';
import 'settings_page.dart';
import '../services/message_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final MockMessageService messageService =
      MockMessageService(); // ✅ 可替换为 ApiMessageService

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      MessageSquarePage(messageService: messageService),
      const JoinedGroupsPage(),
      const SettingsPage(),
    ];

    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        showSelectedLabels: false, // ✅ 隐藏选中项文字
        showUnselectedLabels: false, // ✅ 隐藏未选中项文字
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.public),
            label: '广场',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: '群组',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '设置',
          ),
        ],
      ),
    );
  }
}
