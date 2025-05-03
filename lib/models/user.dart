// models/user.dart
import 'package:dash_chat_2/dash_chat_2.dart';

ChatUser buildUser(String userId, String username) {
  return ChatUser(
    id: userId,
    firstName: username,
    profileImage: 'https://picsum.photos/200/300?random=$userId',
  );
}
