import 'package:anony_chat/database/hive_controller.dart';
import 'package:anony_chat/model/dao/chat_room.dart';
import 'package:anony_chat/model/dao/message.dart';
import 'package:anony_chat/viewmodel/member_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class ChatModel {
  static final FirebaseAuth _mAuth = FirebaseAuth.instance;
  static final FirebaseDatabase _db = FirebaseDatabase.instance;

  // 메시지를 받는 사람 수
  static const int RECEIVER_NUMBER = 1;
  static const String CHAT_ROOM_TABLE = 'chat_room';
  static const String CHAT_LIST_TABLE = 'chat_list';

  Future<void> sendMessage({Message message}) async {
    String receiverUid = await MemberModel.getMemberUid(message.receiverID);

    _db
        .reference()
        .child(CHAT_ROOM_TABLE)
        .child(_mAuth.currentUser.uid)
        .child('${message.senderID}_${message.receiverID}')
        .update(message.toJson());

    _db
        .reference()
        .child(CHAT_ROOM_TABLE)
        .child(receiverUid)
        .child('${message.receiverID}_${message.senderID}')
        .update(message.toJson());
  }

  // 채팅방 만들기 Todo *매칭시스템의 기준이 명확하지 않아서 일단 생성하는거만
  // TODO 랜덤으로 상대방을 찾을 때 이미 채팅이 생선된 방은 제외하는 로직 추가해야함
  Future<void> createChatRoom({ChatRoom chatRoom}) async {
    int totalMember = await MemberModel.getTotalMemberCount();
    chatRoom.message.senderID = HiveController.getMemberID();

    //TODO 리팩토링은 나중에 하자
    switch (chatRoom.type) {
      case ChatType.random:
        int receiver = 2;
        await _initChatReceiver(chatRoom, receiver);
        String receiverUid =
            await MemberModel.getMemberUid(chatRoom.message.receiverID);

        // 나의 채팅 리스트 만들기
        _createChatList(chatRoom, _mAuth.currentUser.uid, receiverUid);

        // 나의 너의 채팅방 만들기
        _createChatRoom(chatRoom, _mAuth.currentUser.uid, receiverUid);

        break;
      case ChatType.onlyMan:
        break;
      case ChatType.onlyWoman:
        break;
    }
  }

  void _createChatRoom(
      ChatRoom chatRoom, String senderUid, String receiverUid) {
    _db
        .reference()
        .child(CHAT_ROOM_TABLE)
        .child(senderUid)
        .child('${chatRoom.message.senderID}_${chatRoom.message.receiverID}')
        .set(chatRoom.message.toJson());

    _db
        .reference()
        .child(CHAT_ROOM_TABLE)
        .child(receiverUid)
        .child('${chatRoom.message.receiverID}_${chatRoom.message.senderID}')
        .set(chatRoom.message.toJson());
  }

  void _createChatList(ChatRoom chatRoom, String uid, String receiverUid) {
    _db
        .reference()
        .child(CHAT_LIST_TABLE)
        .child(uid)
        .child('${chatRoom.message.senderID}_${chatRoom.message.receiverID}')
        .set(chatRoom.toJson());

    chatRoom.withWho = chatRoom.message.senderID;

    _db
        .reference()
        .child(CHAT_LIST_TABLE)
        .child(receiverUid)
        .child('${chatRoom.message.receiverID}_${chatRoom.message.senderID}')
        .set(chatRoom.toJson());
  }

/*  _swapSenderAndReceiver(ChatRoom chatRoom) {
    int temp = chatRoom.message.receiverID;
    chatRoom.withWho = chatRoom.message.senderID;
    chatRoom.message.receiverID = chatRoom.message.senderID;
    chatRoom.message.senderID = temp;
  } */

  _initChatReceiver(ChatRoom chatRoom, int receiver) async {
    chatRoom.withWho = receiver;
    chatRoom.message.receiverID = receiver;
  }

  Stream<Event> getChatRoomList(String uid) {
    final chatList = _db.reference().child(CHAT_LIST_TABLE).child(uid).onValue;

    return chatList;
  }

  Query getChatMessageList(int receiverID) {
    final senderID = HiveController.getMemberID();

    return _db
        .reference()
        .child(CHAT_ROOM_TABLE)
        .child(_mAuth.currentUser.uid)
        .child('${senderID}_$receiverID')
        .orderByKey();
  }
}
