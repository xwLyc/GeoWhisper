// message_list_view.dart
import 'package:flutter/material.dart';
import 'package:geo_whisper/models/message_chat.dart';
import '../pages/message_chat_page.dart'; // ✅ 导入详情页
import 'message_card.dart';
import '../models/channel_message.dart';

class MessageListView extends StatelessWidget {
  final String channel;
  final List<ChannelMessage> messages; // ✅ 接收外部消息列表

  const MessageListView({
    Key? key,
    required this.channel,
    required this.messages, // ✅ 必填参数
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final messages = MockMessages.getMessagesByChannel(channel);

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
        // final msg = messages[messages.length - 1 - index]; // 反向遍历
        final msg = messages[index]; // ✅ 使用传入的 messages
        final channel = MessageChat(
          id: msg.channelId,
          name: msg.content, // 或根据需求自定义名称
          members: msg.members ?? 0,
          currentUserId: '112', // 从全局状态或 AuthService 获取
          authorId: msg.authorId,
        );
        return KeyedSubtree(
          // ✅ 强制使用唯一 Key
          key: ValueKey(msg.id), // ✅ 使用 message.id 作为 Key
          child: MessageCard(
            message: msg,
            onTap: () {
              Navigator.pushNamed(
                context,
                '/message_chat',
                arguments: channel, // ✅ 传递 Channel 对象
              );
            },
          ),
        );
      },
    );
  }
}
