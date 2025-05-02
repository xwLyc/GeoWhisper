import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('设置')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('主题模式'),
            subtitle: const Text('日间 / 夜间'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          ListTile(
            title: const Text('推送通知'),
            subtitle: const Text('接收频道热点消息'),
            trailing: Switch(value: true, onChanged: (val) {}),
          ),
          ListTile(
            title: const Text('隐私政策'),
            onTap: () {
              // 跳转至隐私协议网页
            },
          ),
        ],
      ),
    );
  }
}
