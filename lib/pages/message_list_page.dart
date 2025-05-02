// lib/pages/message_list_page.dart
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart'; // ✅ 正确导入 geolocator
import '../services/location_service.dart';
import '../services/mock_messages.dart'; // 模拟消息数据
import '../widgets/message_list_view.dart';

class MessageListPage extends StatefulWidget {
  const MessageListPage({Key? key}) : super(key: key);

  @override
  State<MessageListPage> createState() => _MessageListPageState();
}

class _MessageListPageState extends State<MessageListPage> {
  String currentChannel = '定位中...';
  late Future<void> _initFuture;
  final LocationService _locationService = LocationService();

  @override
  void initState() {
    super.initState();
    _initFuture = _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    try {
      // ✅ 使用 await 获取 Position 对象
      final position = await _locationService.getCurrentPosition();
      if (position != null) {
        final channels = _locationService.getNearbyChannels(position);
        setState(() {
          currentChannel = channels.isNotEmpty ? channels.first : '暂无附近频道';
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
            return MessageListView(channel: currentChannel);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
