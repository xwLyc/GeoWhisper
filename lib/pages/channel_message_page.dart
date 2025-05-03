// lib/pages/channel_message_page.dart
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart'; // ✅ 正确导入 geolocator
import '../services/location_service.dart';
import '../services/message_service.dart';
import '../widgets/message_list_view.dart';
import '../widgets/chat_input_bar.dart';
import '../models/channel_message.dart';
import '../widgets/chat_input_bar_dash_style.dart'; // 替换旧的 chat_input_bar

class ChaneelMessage extends StatefulWidget {
  final MessageService messageService; // ✅ 注入依赖
  const ChaneelMessage({
    Key? key,
    required this.messageService, // 可注入 MockMessageService 或 ApiMessageService
  }) : super(key: key);

  @override
  State<ChaneelMessage> createState() => _MessageSquarePageState();
}

class _MessageSquarePageState extends State<ChaneelMessage> {
  String currentChannel = '定位中...';
  late Future<void> _initFuture;
  final LocationService _locationService = LocationService();
  List<ChannelMessage> channelMessages = [];

  @override
  void initState() {
    super.initState();
    _initFuture = _loadInitialData();
    channelMessages = []; // ✅ 初始化为空列表
  }

  // 新增方法：添加新消息
  void _addMessage(String content) async {
    final newMessage = ChannelMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(), // ✅ 确保唯一 ID
      authorId: 'xxx',
      content: content,
      likes: 0,
      replies: 0,
      channelId: currentChannel,
      timestamp: DateTime.now(),
    );
    await widget.messageService.sendMessage(newMessage); // ✅ 提交到服务层
    setState(() {
      channelMessages.insert(0, newMessage); // ✅ 将新消息插入到列表顶部
    });
    // 自动滚动到顶部
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 假设你有一个 ScrollController 控制 MessageListView
      // 示例：scrollController.animateTo(0, ...);
    });
  }

  Future<void> _loadInitialData() async {
    try {
      final position = await _locationService.getCurrentPosition();

      if (position != null) {
        final channels = _locationService.getNearbyChannels(position);
        final selectedChannel = channels.isNotEmpty ? channels.first : '暂无附近频道';
        final data =
            await widget.messageService.getMessagesByChannel(selectedChannel);

        setState(() {
          currentChannel = selectedChannel;
          channelMessages = data;
        });
      } else {
        // ✅ 如果定位失败，使用默认位置（北京王府井）
        final defaultPosition = Position(
          latitude: 39.906712,
          longitude: 116.397481,
          timestamp: DateTime.now(),
          accuracy: 1.0,
          altitude: 0.0,
          heading: 0.0,
          speed: 0.0,
          speedAccuracy: 0.0,
          altitudeAccuracy: 0.0, // ✅ 新增参数
          headingAccuracy: 0.0, // ✅ 新增参数
        );
        final channels = _locationService.getNearbyChannels(defaultPosition);
        setState(() {
          currentChannel = channels.isNotEmpty ? channels.first : '定位失败';
        });
      }
    } catch (e) {
      setState(() {
        currentChannel = '定位失败，请手动开启权限';
      });
    }
  }

  void _navigateToChannelSelection(BuildContext context) async {
    final newChannel = await Navigator.pushNamed(
      context,
      '/channel_selection',
    );

    if (newChannel != null && newChannel is String) {
      setState(() {
        currentChannel = newChannel;
      });

      final data = await widget.messageService.getMessagesByChannel(newChannel);
      setState(() {
        channelMessages = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder(
          future: _initFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Text(currentChannel);
            }
            return const Text('定位中...');
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: () => _navigateToChannelSelection(context),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _initFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                Expanded(
                  child: MessageListView(
                      channel: currentChannel,
                      messages: channelMessages), // ✅ 传递 message
                ),
                SafeArea(
                  top: false, // 只处理底部
                  bottom: true,
                  child: DashStyleInputBar(onSend: _addMessage),
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
