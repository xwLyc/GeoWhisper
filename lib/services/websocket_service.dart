import 'dart:async';
import '../models/chat_detail.dart';

class MockWebSocketService {
  final StreamController<ChatDetail> _messageStreamController =
      StreamController.broadcast();
  late final String channelId;

  MockWebSocketService(this.channelId);

  // 模拟连接
  void connect(String channelId) {
    // 可选：发送欢迎消息
    _sendMockMessage('系统', '欢迎加入频道 $channelId');
  }

  // 模拟发送消息
  void sendMessage(ChatDetail chatDetail) {
    // 模拟服务端回复（延迟 1s）
    Future.delayed(const Duration(seconds: 1), () {
      _sendMockMessage('机器人', '你发送了：${chatDetail.text}');
    });
  }

  void _sendMockMessage(String userId, String text) {
    final chatDetail = ChatDetail(
      id: 'mock_${DateTime.now().millisecondsSinceEpoch}',
      text: text,
      userId: userId,
      username: userId,
      timestamp: DateTime.now(),
    );
    _messageStreamController.add(chatDetail);
  }

  Stream<ChatDetail> get messageStream => _messageStreamController.stream;

  void dispose() {
    _messageStreamController.close();
  }
}
