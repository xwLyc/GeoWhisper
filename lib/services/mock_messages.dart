// lib/models/mock_messages.dart
class MockMessages {
  static final List<Map<String, dynamic>> _messages = [
    {
      'content': '北京王府井地铁站有人捡到学生证！',
      'channel': '北京王府井地铁站',
      'likes': 12,
      'replies': 2
    },
    {
      'content': '上海陆家嘴星巴克有优惠活动！',
      'channel': '星巴克(陆家嘴店)',
      'likes': 8,
      'replies': 1
    },
    {'content': '北京协和医院附近发现流浪猫', 'channel': '北京协和医院', 'likes': 5, 'replies': 0},
  ];

  static List<Map<String, dynamic>> getMessagesByChannel(String channel) {
    if (channel == '定位中...') return [];
    return _messages.where((msg) => msg['channel'] == channel).toList();
  }
}
