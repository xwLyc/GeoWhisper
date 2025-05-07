// lib/services/joined_channel_manager.dart
import '../models/message_chat.dart';

class JoinedChatsManager {
  // 私有构造函数
  JoinedChatsManager._internal();

  // 单例实例
  static final JoinedChatsManager _instance = JoinedChatsManager._internal();

  // 提供访问点
  factory JoinedChatsManager() => _instance;

  final List<MessageChat> _joinedChats = [];

  List<MessageChat> get joinedChats => List.unmodifiable(_joinedChats);

  void addChannel(MessageChat chat) {
    if (!_joinedChats.any((c) => c.id == chat.id)) {
      _joinedChats.add(chat);
    }
  }

  void removechat(String chatId) {
    _joinedChats.removeWhere((c) => c.id == chatId);
  }

  bool isJoined(String chatId) {
    return _joinedChats.any((c) => c.id == chatId);
  }

  void clear() {
    _joinedChats.clear();
  }
}
