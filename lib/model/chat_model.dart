import 'package:anony_chat/database/shared_preferences_controller.dart';
import 'package:anony_chat/model/dao/chat_room.dart';
import 'package:anony_chat/model/member_model.dart';
import 'package:anony_chat/ui/widget/chat/chat_room_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

import 'dao/message.dart';

class ChatModel {
  static final FirebaseAuth _mAuth = FirebaseAuth.instance;
  static final FirebaseDatabase _db = FirebaseDatabase.instance;

  // 메시지를 받는 사람 수
  static const int RECEIVER_NUMBER = 1;
  static const String CHAT_ROOM_TABLE = 'chat_room';
  static const String CHAT_LIST_TABLE = 'chat_list';

  static Future<void> sendMessage({Message message}) async {}

  // 채팅방 만들기 Todo *매칭시스템의 기준이 명확하지 않아서 일단 생성하는거만
  // TODO 랜덤으로 상대방을 찾을 때 이미 채팅이 생선된 방은 제외하는 로직 추가해야함
  static Future<void> createChatRoom({ChatRoom chatRoom}) async {
    int totalMember = await MemberModel.getTotalMemberCount();

    switch (chatRoom.type) {
      case ChatType.random:
        int receiver = 2;
        _db
            .reference()
            .child(CHAT_LIST_TABLE)
            .child('${chatRoom.message.senderID}')
            .child('${chatRoom.message.senderID}_$receiver')
            .set(chatRoom.toJson());
        break;
      case ChatType.onlyMan:
        break;
      case ChatType.onlyWoman:
        break;
    }
  }

  static Future<List<ChatRoomPreview>> getChatList() async {
    List<ChatRoomPreview> list = [];
    final chatList = await _db
        .reference()
        .child(CHAT_LIST_TABLE)
        .child('${await SPController.getID()}')
        .once();

    Map test = chatList.value;

    test.forEach((key, value) {
      final time = DateFormat('MM월 dd일 hh:mm aa')
          .format(DateTime.fromMillisecondsSinceEpoch(value['timestamp']))
          .toString();

      list.add(ChatRoomPreview(
        planetName: 'assets/images/${value['planetName']}',
        lastMessage: value['lastMessage'],
        timestamp: time,
        sex: '여성',
      ));
    });

    return list;
  }
}
