import 'package:flutter/material.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

class ChatInputBar extends StatefulWidget {
  final Function(String) onSendMessage;

  const ChatInputBar({Key? key, required this.onSendMessage}) : super(key: key);

  @override
  _ChatInputBarState createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  final TextEditingController _controller = TextEditingController();
  bool _isInputValid = false;
  bool _showEmojiPicker = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isInputValid = _controller.text.trim().isNotEmpty; // ✅ 使用 trim()
      });
    });
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      widget.onSendMessage(text);
      _controller.clear();
      _closeEmojiPicker();
      setState(() {
        _isInputValid = false; // ✅ 发送后重置状态
      });
    }
  }

  void _toggleEmojiPicker() {
    setState(() {
      _showEmojiPicker = !_showEmojiPicker;
    });
  }

  void _closeEmojiPicker() {
    setState(() {
      _showEmojiPicker = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(height: 1, color: Colors.grey[300]),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.emoji_emotions),
              onPressed: _toggleEmojiPicker,
            ),
            Expanded(
              child: TextField(
                controller: _controller,
                maxLines: null,
                minLines: 1,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: '说点什么...',
                  border: InputBorder.none,
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: _isInputValid ? _sendMessage : null, // ✅ 统一状态
              color: _isInputValid ? Colors.blue : Colors.grey, // ✅ 同步颜色
            ),
          ],
        ),
        if (_showEmojiPicker)
          Container(
            height: 250,
            child: EmojiPicker(
              onEmojiSelected: (category, emoji) {
                _controller.text += emoji.emoji;
                FocusScope.of(context).requestFocus(FocusNode()); // ✅ 收起软键盘
              },
              onBackspacePressed: () {
                if (_controller.text.isNotEmpty) {
                  _controller.text =
                      _controller.text.characters.skipLast(1).toString();
                }
              },
            ),
          ),
      ],
    );
  }
}
