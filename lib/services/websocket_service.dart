import 'dart:async';
import '../models/chat_message.dart' as LocalChatMessage;

class MockWebSocketService {
  final StreamController<LocalChatMessage.ChatMessage>
      _messageStreamController = StreamController.broadcast();
  late final String channelId;

  MockWebSocketService(this.channelId);

  // 模拟连接
  void connect(String channelId) {
    // 可选：发送欢迎消息
    _sendMockMessage('系统', '欢迎加入频道 $channelId');
  }

  // 模拟发送消息
  void sendMessage(LocalChatMessage.ChatMessage message) {
    // 模拟服务端回复（延迟 1s）
    Future.delayed(const Duration(seconds: 1), () {
      _sendMockMessage('机器人', '你发送了：${message.text}');
    });
  }

  void _sendMockMessage(String userId, String text) {
    final message = LocalChatMessage.ChatMessage(
      id: 'mock_${DateTime.now().millisecondsSinceEpoch}',
      text: text,
      userId: userId,
      username: userId,
      timestamp: DateTime.now(),
    );
    _messageStreamController.add(message);
  }

  Stream<LocalChatMessage.ChatMessage> get messageStream =>
      _messageStreamController.stream;

  void dispose() {
    _messageStreamController.close();
  }
}
