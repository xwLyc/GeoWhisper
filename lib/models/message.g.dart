// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      id: json['id'] as String,
      content: json['content'] as String,
      likes: (json['likes'] as num?)?.toInt() ?? 0,
      replies: (json['replies'] as num?)?.toInt() ?? 0,
      channelId: json['channelId'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      authorId: json['authorId'] as String,
      members: (json['members'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'likes': instance.likes,
      'replies': instance.replies,
      'channelId': instance.channelId,
      'timestamp': instance.timestamp.toIso8601String(),
      'members': instance.members,
      'authorId': instance.authorId,
    };
