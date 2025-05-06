import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/message_service.dart';
import '../models/channel_message.dart';
import '../widgets/message_list_view.dart';
import '../widgets/chat_input_bar_dash_style.dart';

class ChannelMessagePage extends StatefulWidget {
  final MessageService messageService;
  const ChannelMessagePage({Key? key, required this.messageService})
      : super(key: key);

  @override
  State<ChannelMessagePage> createState() => _ChannelMessagePageState();
}

class _ChannelMessagePageState extends State<ChannelMessagePage> {
  String currentChannelId = '';
  String currentChannelName = '';
  List<ChannelMessage> channelMessages = [];
  late Future<void> _initFuture;

  @override
  void initState() {
    super.initState();
    _initFuture = _initialize();
  }

  Future<void> _initialize() async {
    final prefs = await SharedPreferences.getInstance();
    String? storedId = prefs.getString('selected_channel_id');
    String? storedName = prefs.getString('selected_channel_name');

    // 如果未设置频道，默认使用“默认频道”
    if (storedId == null ||
        storedId.isEmpty ||
        storedName == null ||
        storedName.isEmpty) {
      storedId = 'default';
      storedName = '默认频道';
      await prefs.setString('selected_channel_id', storedId);
      await prefs.setString('selected_channel_name', storedName);
    }

    currentChannelId = storedId;
    currentChannelName = storedName;
    await _loadMessages(currentChannelId);
  }

  Future<void> _loadMessages(String channelId) async {
    try {
      final data = await widget.messageService.getMessagesByChannel(channelId);
      setState(() {
        channelMessages = data;
      });
    } catch (e) {
      debugPrint('加载频道消息失败：$e');
    }
  }

  void _addMessage(String content) async {
    final newMessage = ChannelMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      authorId: 'anonymous',
      content: content,
      likes: 0,
      replies: 0,
      channelId: currentChannelId,
      timestamp: DateTime.now(),
    );
    await widget.messageService.sendMessage(newMessage);
    setState(() {
      channelMessages.insert(0, newMessage);
    });
  }

  void _changeChannel() async {
    final result = await Navigator.pushNamed(context, '/channel_selection');
    if (result != null && result is Map<String, String>) {
      final newId = result['channelId']!;
      final newName = result['channelName']!;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('selected_channel_id', newId);
      await prefs.setString('selected_channel_name', newName);
      setState(() {
        currentChannelId = newId;
        currentChannelName = newName;
      });
      await _loadMessages(newId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(currentChannelName.isNotEmpty ? currentChannelName : '加载中...'),
        actions: [
          IconButton(
            icon: const Icon(Icons.swap_horiz),
            onPressed: _changeChannel,
          ),
        ],
      ),
      body: FutureBuilder(
        future: _initFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              Expanded(
                child: MessageListView(
                  channel: currentChannelId,
                  messages: channelMessages,
                ),
              ),
              SafeArea(
                child: DashStyleInputBar(onSend: _addMessage),
              ),
            ],
          );
        },
      ),
    );
  }
}
