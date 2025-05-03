// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import 'channel_message_page.dart';
import 'joined_groups_page.dart';
import 'settings_page.dart';
import 'friend_list_page.dart';
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
      const FriendListPage(),
      const SettingsPage(),
    ];

    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // 🔧 关键设置
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        // showSelectedLabels: false, // ✅ 隐藏选中项文字
        // showUnselectedLabels: false, // ✅ 隐藏未选中项文字
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.public),
            label: '广场',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum_rounded),
            label: '频道',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_outlined), // 好友列表图标
            label: '好友',
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
