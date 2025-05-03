// lib/models/channel_message.dart
// flutter pub run build_runner build 执行更新
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'channel_message.g.dart'; // ✅ 必须与文件名一致（自动生成）

@JsonSerializable() // ✅ 标记类为可序列化
class ChannelMessage {
  final String id;
  final String content;
  final int likes;
  final int replies;
  final String channelId;
  final DateTime timestamp;
  final int members;
  final String authorId;

  ChannelMessage({
    required this.id,
    required this.content,
    this.likes = 0,
    this.replies = 0,
    required this.channelId,
    required this.timestamp,
    required this.authorId,
    this.members = 0,
  });

  // ✅ 使用生成的 _$ChannelMessageFromJson
  factory ChannelMessage.fromJson(Map<String, dynamic> json) =>
      _$ChannelMessageFromJson(json);

  // ✅ 使用生成的 _$ChannelMessageToJson
  Map<String, dynamic> toJson() => _$ChannelMessageToJson(this);
}
