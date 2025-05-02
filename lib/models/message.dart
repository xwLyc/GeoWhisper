class Message {
  final String content;
  final int likes;
  final int replies;
  final String channelId;
  final DateTime timestamp;

  Message({
    required this.content,
    required this.likes,
    required this.replies,
    required this.channelId,
    required this.timestamp,
  });
}
