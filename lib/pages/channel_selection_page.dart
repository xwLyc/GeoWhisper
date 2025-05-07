// lib/pages/channel_selection_page.dart
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class ChannelSelectionPage extends StatefulWidget {
  const ChannelSelectionPage({Key? key}) : super(key: key);

  @override
  State<ChannelSelectionPage> createState() => _ChannelSelectionPageState();
}

class _ChannelSelectionPageState extends State<ChannelSelectionPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> hotChannels = [
    '校园树洞',
    '地铁闲聊',
    '早八吐槽',
    '考研专区',
    '恋爱互助',
    '失恋互助会',
    '考公冲刺',
    '毕业季感慨'
  ];

  List<String> searchResults = [];
  String keyword = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      keyword = _searchController.text.trim();
      _updateSearchResults();
    });
  }

  void _updateSearchResults() {
    if (keyword.isEmpty) {
      searchResults = [];
    } else {
      final lowerKeyword = keyword.toLowerCase();
      searchResults = hotChannels
          .where((c) => c.toLowerCase().contains(lowerKeyword))
          .toList();
    }
  }

  void _selectChannel(String name) {
    final trimmedName = name.length > 10 ? name.substring(0, 10) : name;
    final channelId = trimmedName.hashCode.toString(); // 示例 ID
    Navigator.pop(context, {
      'channelId': channelId,
      'channelName': trimmedName,
    });
  }

  Widget _buildHotChannels() {
    return ListView.builder(
      itemCount: hotChannels.length,
      itemBuilder: (context, index) {
        final channel = hotChannels[index];
        return ListTile(
          title: Text(channel),
          onTap: () => _selectChannel(channel),
        );
      },
    );
  }

  Widget _buildSearchResults() {
    return Column(
      children: [
        Expanded(
          child: searchResults.isNotEmpty
              ? ListView.builder(
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    final channel = searchResults[index];
                    return ListTile(
                      title: Text(channel),
                      onTap: () => _selectChannel(channel),
                    );
                  },
                )
              : const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text('没有找到相关频道'),
                ),
        ),
        if (searchResults.isEmpty)
          Padding(
            padding: const EdgeInsets.all(12),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: Text(
                  '创建频道：${keyword.length > 10 ? keyword.substring(0, 10) : keyword}'),
              onPressed: () => _selectChannel(keyword),
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final showSearchResults = keyword.isNotEmpty;

    return Scaffold(
      appBar: AppBar(title: const Text('选择频道')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              maxLength: 12,
              maxLengthEnforcement: MaxLengthEnforcement.none,
              decoration: InputDecoration(
                hintText: '搜索频道名称（最多12个字）',
                prefixIcon: Icon(Icons.search),
                suffixIcon: keyword.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () => _searchController.clear(),
                      )
                    : null,
              ),
            ),
          ),
          Expanded(
            child:
                showSearchResults ? _buildSearchResults() : _buildHotChannels(),
          ),
        ],
      ),
    );
  }
}
