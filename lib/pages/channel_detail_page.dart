import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import '../models/channel.dart';
import '../models/chat_message.dart';
import '../services/websocket_service.dart';

class ChannelDetailPage extends StatefulWidget {
  final Channel channel;

  const ChannelDetailPage({Key? key, required this.channel}) : super(key: key);

  @override
  State<ChannelDetailPage> createState() => _ChannelDetailPageState();
}

class _ChannelDetailPageState extends State<ChannelDetailPage> {
  // final WebSocketService _webSocketService = WebSocketService();
  late final MockWebSocketService _webSocketService;

  final List<ChatMessage> _messages = [];

  late final ChatUser _currentUser;

  @override
  void initState() {
    super.initState();

    _currentUser = ChatUser(
      id: widget.channel.currentUserId,
      firstName: "我",
    );

    _webSocketService = MockWebSocketService(widget.channel.id);
    _webSocketService.connect(widget.channel.id);
    _webSocketService.messageStream.listen(_handleIncomingMessage);
  }

  void _handleIncomingMessage(LocalChatMessage newMessage) {
    final chatMessage = ChatMessage(
      text: newMessage.text,
      user: ChatUser(
        id: newMessage.userId,
        firstName: newMessage.username,
      ),
      createdAt: newMessage.timestamp,
    );

    setState(() {
      _messages.insert(0, chatMessage);
    });
  }

  void _handleSend(ChatMessage message) {
    final localMsg = LocalChatMessage(
      id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
      text: message.text,
      userId: _currentUser.id,
      username: _currentUser.firstName ?? "我",
      timestamp: DateTime.now(),
    );

    _webSocketService.sendMessage(localMsg);

    setState(() {
      _messages.insert(0, message);
    });
  }

  @override
  void dispose() {
    _webSocketService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.channel.name),
      ),
      body: DashChat(
        currentUser: _currentUser,
        onSend: _handleSend,
        messages: _messages,
        inputOptions: InputOptions(
          alwaysShowSend: true,
          sendOnEnter: true,
        ),
        messageOptions: MessageOptions(
          showOtherUsersAvatar: false,
          currentUserContainerColor: Theme.of(context).primaryColor,
          containerColor: Colors.grey.shade300,
          textColor: Colors.black,
        ),
      ),
    );
  }
}
