import 'package:flutter/material.dart';
import '../../models/channel.dart';

class ChannelItem extends StatelessWidget {
  final Channel channel;
  final VoidCallback onTap;

  const ChannelItem({
    Key? key,
    required this.channel,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.location_on),
      title: Text(channel.name),
      // subtitle: Text('距离：${channel.distance}m'),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}
