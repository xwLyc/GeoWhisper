// lib/services/joined_channel_manager.dart
import '../models/message_chat.dart';

class JoinedChannelManager {
  // 私有构造函数
  JoinedChannelManager._internal();

  // 单例实例
  static final JoinedChannelManager _instance =
      JoinedChannelManager._internal();

  // 提供访问点
  factory JoinedChannelManager() => _instance;

  final List<MessageChat> _joinedChats = [];

  List<MessageChat> get joinedChats => List.unmodifiable(_joinedChats);

  void addChannel(MessageChat channel) {
    if (!_joinedChats.any((c) => c.id == channel.id)) {
      _joinedChats.add(channel);
    }
  }

  void removeChannel(String channelId) {
    _joinedChats.removeWhere((c) => c.id == channelId);
  }

  bool isJoined(String channelId) {
    return _joinedChats.any((c) => c.id == channelId);
  }

  void clear() {
    _joinedChats.clear();
  }
}
