// lib/pages/channel_detail_page.dart
import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import '../models/channel.dart';
import '../models/chat_message.dart';
import '../services/websocket_service.dart';
import '../services/joined_channel_manager.dart'; // 假设你有这个类

class ChannelDetailPage extends StatefulWidget {
  final Channel channel;

  const ChannelDetailPage({Key? key, required this.channel}) : super(key: key);

  @override
  State<ChannelDetailPage> createState() => _ChannelDetailPageState();
}

class _ChannelDetailPageState extends State<ChannelDetailPage> {
  late final MockWebSocketService _webSocketService;
  final List<ChatMessage> _messages = [];
  late final ChatUser _currentUser;

  bool get _hasJoined => widget.channel.isJoined;

  @override
  void initState() {
    super.initState();

    _currentUser = ChatUser(
      id: widget.channel.currentUserId,
      firstName: "我",
    );

    if (_hasJoined) {
      _initWebSocket();
    }
  }

  void _initWebSocket() {
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

  void _joinChannel() {
    setState(() {
      widget.channel.isJoined = true;
    });

    _initWebSocket();

    // 加入频道记录（假设你有这个类）
    JoinedChannelManager().addChannel(widget.channel);
  }

  @override
  void dispose() {
    if (_hasJoined) {
      _webSocketService.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.channel.name),
      ),
      body: Column(
        children: [
          Expanded(
            child: DashChat(
              currentUser: _currentUser,
              onSend: _hasJoined ? _handleSend : (_) {}, // 禁止发送
              messages: _messages,
              inputOptions: InputOptions(
                inputDisabled: !_hasJoined, // ✅ 禁用输入框
                alwaysShowSend: true,
                sendOnEnter: true,
              ),
              messageOptions: MessageOptions(
                showOtherUsersAvatar: false,
                currentUserContainerColor: Theme.of(context).primaryColor,
                containerColor: Colors.grey.shade300,
                textColor: Colors.black,
              ),
              readOnly: !_hasJoined, // ✅ 禁用输入框
            ),
          ),
          if (!_hasJoined)
            SafeArea(
              child: Container(
                // width: double.infinity,
                // padding: const EdgeInsets.all(20),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.group_add),
                  label: const Text("加入频道"),
                  onPressed: _joinChannel,
                ),
              ),
            )
        ],
      ),
    );
  }
}
