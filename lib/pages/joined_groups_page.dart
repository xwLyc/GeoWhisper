// lib/pages/joined_groups_page.dart
import 'package:flutter/material.dart';
import '../models/channel.dart';
import '../services/joined_channel_manager.dart';
import 'channel_detail_page.dart';

class JoinedGroupsPage extends StatelessWidget {
  const JoinedGroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 获取已加入频道列表
    List<Channel> joinedChannels = JoinedChannelManager().joinedChannels;

    return Scaffold(
      appBar: AppBar(
        title: const Text('多人聊天'),
      ),
      body: joinedChannels.isEmpty
          ? const Center(child: Text('你还没有加入任何频道'))
          : ListView.builder(
              itemCount: joinedChannels.length,
              itemBuilder: (context, index) {
                final channel = joinedChannels[index];

                return ListTile(
                  leading: const Icon(Icons.chat),
                  title: Text(channel.name),
                  subtitle: Text('${channel.members} 人在线'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChannelDetailPage(channel: channel),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
