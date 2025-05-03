// lib/pages/joined_groups_page.dart
import 'package:flutter/material.dart';
import '../models/message_chat.dart';
import '../services/joined_channel_manager.dart';
import 'message_chat_page.dart';

class JoinedGroupsPage extends StatelessWidget {
  const JoinedGroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 获取已加入频道列表
    List<MessageChat> joinedChats = JoinedChannelManager().joinedChats;

    return Scaffold(
      appBar: AppBar(
        title: const Text('多人聊天'),
      ),
      body: joinedChats.isEmpty
          ? const Center(child: Text('你还没有加入任何频道'))
          : ListView.builder(
              itemCount: joinedChats.length,
              itemBuilder: (context, index) {
                final messageChat = joinedChats[index];

                return ListTile(
                  leading: const Icon(Icons.chat),
                  title: Text(messageChat.name),
                  subtitle: Text('${messageChat.members} 人在线'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            MessageChatPage(messageChat: messageChat),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
