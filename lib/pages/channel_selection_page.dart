// lib/pages/channel_selection_page.dart
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../services/location_service.dart';

class ChannelSelectionPage extends StatefulWidget {
  const ChannelSelectionPage({Key? key}) : super(key: key);

  @override
  State<ChannelSelectionPage> createState() => _ChannelSelectionPageState();
}

class _ChannelSelectionPageState extends State<ChannelSelectionPage> {
  final LocationService _locationService = LocationService();
  late Future<List<String>> _channelsFuture;

  @override
  void initState() {
    super.initState();
    _channelsFuture = _loadChannels();
  }

  Future<List<String>> _loadChannels() async {
    final position = await _locationService.getCurrentPosition();
    if (position == null) {
      throw Exception('定位失败或权限被拒绝');
    }
    return _locationService.getNearbyChannels(position);
  }

  void _selectChannel(String channel, BuildContext context) {
    Navigator.pop(context, channel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('附近频道')),
      body: FutureBuilder<List<String>>(
        future: _channelsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final channel = snapshot.data![index];
                return ListTile(
                  title: Text(channel),
                  trailing: const Icon(Icons.location_on, color: Colors.blue),
                  onTap: () => _selectChannel(channel, context),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('错误：${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
