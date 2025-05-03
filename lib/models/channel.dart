// models/channel.dart
import 'dart:convert';

class Channel {
  final String id;
  final String name; // 聊天室名称
  final int onlineCount;
  final String currentUserId; // 当前登录用户 ID（用于判断自己）
  final String authorId; // 楼主 ID（用于判断是否为楼主）

  Channel({
    required this.id,
    required this.name,
    required this.authorId,
    required this.currentUserId, // ✅ 必须初始化
    this.onlineCount = 0,
  });

  factory Channel.fromJson(Map<String, dynamic> json, String currentUserId) {
    return Channel(
      id: json['id'],
      name: json['name'],
      onlineCount: json['onlineCount'] ?? 0,
      currentUserId: currentUserId,
      authorId: json['authorId'],
    );
  }
}
