// models/user.dart
import 'package:flutter_chat_types/flutter_chat_types.dart' as ChatTypes;

ChatTypes.User buildUser(String userId, String username) {
  return ChatTypes.User(
    id: userId,
    firstName: username,
    imageUrl: 'https://picsum.photos/200/300?random=$userId',
  );
}
