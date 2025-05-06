import 'package:flutter/material.dart';

class ChannelSelectionPage extends StatefulWidget {
  const ChannelSelectionPage({Key? key}) : super(key: key);

  @override
  State<ChannelSelectionPage> createState() => _ChannelSelectionPageState();
}

class _ChannelSelectionPageState extends State<ChannelSelectionPage> {
  final List<Map<String, String>> _channelList = [
    {'channelId': '001', 'channelName': '默认频道'},
    {'channelId': '002', 'channelName': '地铁树洞'},
    {'channelId': '003', 'channelName': '学校墙'},
  ];

  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _createController = TextEditingController();

  List<Map<String, String>> _filteredChannels = [];

  @override
  void initState() {
    super.initState();
    _filteredChannels = List.from(_channelList);
  }

  void _filterChannels(String keyword) {
    setState(() {
      _filteredChannels = _channelList
          .where((channel) => channel['channelName']!.contains(keyword.trim()))
          .toList();
    });
  }

  void _createChannel(String name) {
    if (name.trim().isEmpty || name.trim().length > 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('频道名不能为空，且不能超过10个字')),
      );
      return;
    }

    // 创建一个唯一 channelId（可改为服务端生成）
    final newChannel = {
      'channelId': DateTime.now().millisecondsSinceEpoch.toString(),
      'channelName': name.trim(),
    };

    setState(() {
      _channelList.add(newChannel);
      _filteredChannels.add(newChannel);
    });

    _createController.clear();

    // 自动返回
    Navigator.pop(context, newChannel);
  }

  void _selectChannel(Map<String, String> channel) {
    Navigator.pop(context, channel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('选择频道'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 搜索框
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: '搜索频道',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => _filterChannels(_searchController.text),
                ),
              ),
              onSubmitted: _filterChannels,
            ),
            const SizedBox(height: 16),

            // 列表
            Expanded(
              child: _filteredChannels.isEmpty
                  ? const Center(child: Text('暂无匹配频道'))
                  : ListView.builder(
                      itemCount: _filteredChannels.length,
                      itemBuilder: (context, index) {
                        final channel = _filteredChannels[index];
                        return ListTile(
                          title: Text(channel['channelName']!),
                          onTap: () => _selectChannel(channel),
                        );
                      },
                    ),
            ),

            const Divider(),
            const SizedBox(height: 8),

            // 创建频道
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _createController,
                    decoration: const InputDecoration(
                      hintText: '输入新频道名（≤10字）',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _createChannel(_createController.text),
                  child: const Text('创建'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
