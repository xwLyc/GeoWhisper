// widgets/chat_message_card.dart
import 'package:flutter/material.dart';
import '../models/chat_detail.dart';

class ChatMessageCard extends StatelessWidget {
  final ChatDetail chatDetail;
  final bool isAuthor; // 是否为楼主
  final bool isSelf; // 是否为自己

  const ChatMessageCard({
    Key? key,
    required this.chatDetail,
    required this.isAuthor,
    required this.isSelf,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Align(
        alignment: isSelf ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSelf ? Colors.blue.withOpacity(0.2) : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(child: Text(chatDetail.username[0])),
                  SizedBox(width: 8),
                  Text(chatDetail.username),
                  if (isAuthor)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Chip(
                        label: Text('楼主'),
                        backgroundColor: Colors.blue.withOpacity(0.3),
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 8),
              Text(chatDetail.text),
              SizedBox(height: 4),
              Text(
                '${chatDetail.timestamp.hour}:${chatDetail.timestamp.minute}',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
