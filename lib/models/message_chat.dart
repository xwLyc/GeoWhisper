// lib/models/message_chat.dart
import 'dart:convert';

class MessageChat {
  final String id;
  final String name; // 聊天室名称
  final int members;
  final String currentUserId; // 当前登录用户 ID（用于判断自己）
  final String authorId; // 楼主 ID（用于判断是否为楼主）
  bool isJoined; // ✅ 改为可变字段

  MessageChat({
    required this.id,
    required this.name,
    required this.authorId,
    required this.currentUserId, // ✅ 必须初始化
    this.members = 0,
    this.isJoined = false,
  });

  factory MessageChat.fromJson(
      Map<String, dynamic> json, String currentUserId) {
    return MessageChat(
      id: json['id'],
      name: json['name'],
      members: json['members'] ?? 0,
      currentUserId: currentUserId,
      authorId: json['authorId'],
      isJoined: json['isJoined'] ?? false,
    );
  }

  MessageChat copyWith({
    String? id,
    String? name,
    int? members,
    String? currentUserId,
    String? authorId,
    bool? isJoined,
  }) {
    return MessageChat(
      id: id ?? this.id,
      name: name ?? this.name,
      members: members ?? this.members,
      currentUserId: currentUserId ?? this.currentUserId,
      authorId: authorId ?? this.authorId,
      isJoined: isJoined ?? this.isJoined,
    );
  }
}
