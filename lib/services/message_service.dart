// lib/services/message_service.dart
import '../models/channel_message.dart';

abstract class MessageService {
  Future<List<ChannelMessage>> getMessagesByChannel(String channelId);
  Future<void> sendMessage(ChannelMessage message);
}

// ✅ 本地模拟实现
class MockMessageService implements MessageService {
  @override
  Future<List<ChannelMessage>> getMessagesByChannel(String channelId) async {
    // 模拟延迟
    await Future.delayed(Duration(milliseconds: 300));

    return [
      ChannelMessage(
        id: '1',
        authorId: 'xxx',
        content: '你好，世界！',
        likes: 5,
        replies: 2,
        channelId: channelId,
        timestamp: DateTime.now().subtract(Duration(minutes: 10)),
      ),
      // 更多模拟数据...
    ];
  }

  @override
  Future<void> sendMessage(ChannelMessage message) async {
    // 模拟网络请求延迟
    await Future.delayed(Duration(milliseconds: 500));
    print('模拟发送消息: ${message.content}');
  }
}

// ✅ 未来替换为 API 实现
class ApiMessageService implements MessageService {
  @override
  Future<List<ChannelMessage>> getMessagesByChannel(String channelId) async {
    // 使用 http 包请求 API
    // final response = await http.get(Uri.parse('...'));
    // 解析 JSON -> ChannelMessage.fromJson(...)
    return []; // 示例
  }

  @override
  Future<void> sendMessage(ChannelMessage message) async {
    // 提交到 API
  }
}
