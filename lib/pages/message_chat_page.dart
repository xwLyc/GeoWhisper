// lib/pages/message_chat_page.dart
import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import '../models/message_chat.dart';
import '../models/chat_detail.dart';
import '../services/websocket_service.dart';
import '../services/joined_channel_manager.dart'; // 假设你有这个类

class MessageChatPage extends StatefulWidget {
  final MessageChat messageChat;

  const MessageChatPage({Key? key, required this.messageChat})
      : super(key: key);

  @override
  State<MessageChatPage> createState() => _MessageChatPageState();
}

class _MessageChatPageState extends State<MessageChatPage> {
  late final MockWebSocketService _webSocketService;
  final List<ChatMessage> _messages = [];
  late final ChatUser _currentUser;

  bool get _hasJoined => widget.messageChat.isJoined;

  @override
  void initState() {
    super.initState();

    _currentUser = ChatUser(
      id: widget.messageChat.currentUserId,
      firstName: "我",
    );

    if (_hasJoined) {
      _initWebSocket();
    }
  }

  void _initWebSocket() {
    _webSocketService = MockWebSocketService(widget.messageChat.id);
    _webSocketService.connect(widget.messageChat.id);
    _webSocketService.messageStream.listen(_handleIncomingMessage);
  }

  void _handleIncomingMessage(ChatDetail newMessage) {
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
    final localMsg = ChatDetail(
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
      widget.messageChat.isJoined = true;
    });

    _initWebSocket();

    // 加入频道记录（假设你有这个类）
    JoinedChannelManager().addChannel(widget.messageChat);
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
        title: Text(widget.messageChat.name),
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
