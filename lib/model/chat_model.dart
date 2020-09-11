import 'package:anony_chat/model/dao/chat_room.dart';

import 'dao/message.dart';

class ChatModel {

  // 메시지를 받는 사람 수
  static const int RECEIVER_NUMBER = 1;

  static Future<void> sendMessage({Message message}) async {}

  // 채팅방 만들기 Todo *매칭시스템의 기준이 명확하지 않아서 일단 틀만 갖춤
  static Future<void> createChatRoom({ChatRoom chatRoom}) async {
    switch (chatRoom.type) {
      case ChatType.random:

        break;
      case ChatType.onlyMan:
        break;
      case ChatType.onlyWoman:
        break;
    }
  }
}
