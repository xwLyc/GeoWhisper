// lib/models/message.dart
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'message.g.dart'; // ✅ 必须与文件名一致（自动生成）

@JsonSerializable() // ✅ 标记类为可序列化
class Message {
  final String id;
  final String content;
  final int likes;
  final int replies;
  final String channelId;
  final DateTime timestamp;
  final int onlineCount;
  final String authorId;

  Message({
    required this.id,
    required this.content,
    this.likes = 0,
    this.replies = 0,
    required this.channelId,
    required this.timestamp,
    required this.authorId,
    this.onlineCount = 0,
  });

  // ✅ 使用生成的 _$MessageFromJson
  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  // ✅ 使用生成的 _$MessageToJson
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
