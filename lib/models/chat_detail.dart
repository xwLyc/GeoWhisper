// lib/models/chat_detail.dart
import 'package:dash_chat_2/dash_chat_2.dart';

class ChatDetail {
  final String id;
  final String text;
  final String userId;
  final String username;
  final DateTime timestamp;

  ChatDetail({
    required this.id,
    required this.text,
    required this.userId,
    required this.username,
    required this.timestamp,
  });

  ChatMessage toDashChatMessage() {
    return ChatMessage(
      text: text,
      user: ChatUser(
        id: userId,
        firstName: username,
        profileImage: 'https://picsum.photos/200/300?random=$userId',
      ),
      createdAt: timestamp,
    );
  }
}
