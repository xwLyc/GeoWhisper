import 'package:flutter/material.dart';

class FeedbackDialog extends StatelessWidget {
  final String messageContent;

  const FeedbackDialog({Key? key, required this.messageContent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('举报内容'),
      content: Text('确定要举报这条消息吗？\n\n$messageContent'),
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: const Text('取消'),
        ),
        TextButton(
          onPressed: () {
            // 提交举报逻辑（MVP阶段可留空）
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('举报提交成功')),
            );
          },
          child: const Text('确认'),
        ),
      ],
    );
  }
}
