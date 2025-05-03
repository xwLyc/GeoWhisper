// lib/services/joined_channel_manager.dart
import '../models/channel.dart';

class JoinedChannelManager {
  // 私有构造函数
  JoinedChannelManager._internal();

  // 单例实例
  static final JoinedChannelManager _instance =
      JoinedChannelManager._internal();

  // 提供访问点
  factory JoinedChannelManager() => _instance;

  final List<Channel> _joinedChannels = [];

  List<Channel> get joinedChannels => List.unmodifiable(_joinedChannels);

  void addChannel(Channel channel) {
    if (!_joinedChannels.any((c) => c.id == channel.id)) {
      _joinedChannels.add(channel);
    }
  }

  void removeChannel(String channelId) {
    _joinedChannels.removeWhere((c) => c.id == channelId);
  }

  bool isJoined(String channelId) {
    return _joinedChannels.any((c) => c.id == channelId);
  }

  void clear() {
    _joinedChannels.clear();
  }
}
