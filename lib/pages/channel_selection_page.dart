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
  bool _loading = true;
  List<String> _channelList = [];
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchNearbyChannels();
  }

  Future<void> _fetchNearbyChannels() async {
    setState(() {
      _loading = true;
      _error = null;
      _channelList = [];
    });

    try {
      final position = await _locationService.getCurrentPosition();

      final pos = position ??
          Position(
            latitude: 39.906712,
            longitude: 116.397481,
            timestamp: DateTime.now(),
            accuracy: 1.0,
            altitude: 0.0,
            heading: 0.0,
            speed: 0.0,
            speedAccuracy: 0.0,
            altitudeAccuracy: 0.0,
            headingAccuracy: 0.0,
          );

      final channels = _locationService.getNearbyChannels(pos);

      setState(() {
        _channelList = channels;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = '获取定位失败，请检查权限设置';
        _loading = false;
      });
    }
  }

  void _selectChannel(String channel) {
    Navigator.pop(context, channel); // 返回频道给上级页面
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('选择附近频道'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_error!),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _fetchNearbyChannels,
                        child: const Text('重试'),
                      ),
                    ],
                  ),
                )
              : _channelList.isEmpty
                  ? const Center(child: Text('附近暂无可用频道'))
                  : ListView.separated(
                      itemCount: _channelList.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final channel = _channelList[index];
                        return ListTile(
                          title: Text(channel),
                          trailing:
                              const Icon(Icons.arrow_forward_ios, size: 16),
                          onTap: () => _selectChannel(channel),
                        );
                      },
                    ),
    );
  }
}
