// models/chat_message.dart
import 'package:flutter_chat_types/flutter_chat_types.dart' as ChatTypes;

class ChatMessage {
  final String id;
  final String text;
  final String userId;
  final String username;
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.text,
    required this.userId,
    required this.username,
    required this.timestamp,
  });

  // 转换为 flutter_chat_types 的 Message 格式（v3.6.2）
  ChatTypes.Message toChatTypesMessage({required ChatTypes.User currentUser}) {
    return ChatTypes.TextMessage(
      id: id,
      author: ChatTypes.User(id: userId),
      createdAt: timestamp.millisecondsSinceEpoch, // 注意：v3.6.2 仍使用毫秒时间戳
      text: text,
    );
  }
}
