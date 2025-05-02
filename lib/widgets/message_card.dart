// lib/widgets/message_card.dart
import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget {
  final String content;
  final int likes;
  final int replies;

  const MessageCard({
    Key? key,
    required this.content,
    this.likes = 0,
    this.replies = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(content),
            Row(
              children: [
                IconButton(
                    icon: const Icon(Icons.favorite_border), onPressed: () {}),
                Text('$likes'),
                IconButton(icon: const Icon(Icons.reply), onPressed: () {}),
                Text('+1 ($replies人)'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
