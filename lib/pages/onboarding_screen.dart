import 'package:flutter/material.dart';
import 'message_list_page.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('欢迎使用匿名树洞')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('步骤1：切换频道', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            Text('点击顶部按钮选择附近场景'),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const MessageListPage()),
                );
              },
              child: const Text('跳过'),
            ),
          ],
        ),
      ),
    );
  }
}
