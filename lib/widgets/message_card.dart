// lib/widgets/message_card.dart
import 'package:flutter/material.dart';
import '../models/channel_message.dart';

class MessageCard extends StatelessWidget {
  final ChannelMessage message;
  final VoidCallback onTap; // ✅ 新增点击回调
  const MessageCard({
    Key? key,
    required this.message, // ✅ 接收 ChannelMessage 对象
    required this.onTap, // ✅ 必须传入点击事件
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap, // ✅ 触发回调
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(message.content),
                Row(
                  children: [
                    IconButton(
                        icon: const Icon(Icons.favorite_border),
                        onPressed: () {}),
                    Text('${message.likes}'),
                    SizedBox(width: 8),
                    IconButton(
                        icon: const Icon(Icons.chat_bubble_outline),
                        onPressed: () {}),
                    Text('${message.replies}'),
                    Spacer(),
                    Icon(Icons.person_outline, size: 16), // ✅ 成员人数图标
                    Text('${message.members}人'), // ✅ 显示成员人数
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
