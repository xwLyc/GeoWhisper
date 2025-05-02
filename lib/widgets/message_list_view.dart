import 'package:flutter/material.dart';
import '../services/mock_messages.dart';
import 'message_card.dart';

class MessageListView extends StatelessWidget {
  final String channel;

  const MessageListView({Key? key, required this.channel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final messages = MockMessages.getMessagesByChannel(channel);

    // ✅ 空状态提示
    if (messages.isEmpty) {
      return const Center(
        child: Text(
          '此频道荒无人烟...',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    // ✅ 倒序显示最新消息（index = length - 1 - index）
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final msg = messages[messages.length - 1 - index]; // 反向遍历
        return MessageCard(
          content: msg['content']!,
          likes: msg['likes']!,
          replies: msg['replies']!,
        );
      },
    );
  }
}
