import 'package:anony_chat/controller/hive_controller.dart';
import 'package:anony_chat/model/dao/chat_room.dart';
import 'package:anony_chat/model/dao/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart' as fd;

import 'member_model.dart';

class ChatModel {
  static final FirebaseAuth _mAuth = FirebaseAuth.instance;
  static final fd.FirebaseDatabase _db = fd.FirebaseDatabase.instance;
  static final FirebaseFirestore _fdb = FirebaseFirestore.instance;

  // 메시지를 받는 사람 수
  static const int RECEIVER_NUMBER = 1;
  static const String CHAT_ROOM_COLLECTION = 'chat_room';
  static const String CHAT_LIST_COLLECTION = 'chat_list';

  Future<void> sendMessage({Message message}) async {
    String receiverUid = await MemberModel.getMemberUid(message.receiverID);

    _db
        .reference()
        .child(CHAT_ROOM_COLLECTION)
        .child(_mAuth.currentUser.uid)
        .child('${message.senderID}_${message.receiverID}')
        .update(message.toJson());

    _db
        .reference()
        .child(CHAT_ROOM_COLLECTION)
        .child(receiverUid)
        .child('${message.receiverID}_${message.senderID}')
        .update(message.toJson());
  }

  // 채팅방 만들기 Todo *매칭시스템의 기준이 명확하지 않아서 일단 생성하는거만
  // TODO 랜덤으로 상대방을 찾을 때 이미 채팅이 생선된 방은 제외하는 로직 추가해야함
  createChatRoom({ChatRoom chatRoom}) async {
    // chatRoom.message.senderID = HiveController.instance.getMemberID();

    int receiver = 2;
    chatRoom.message.senderID = 1;
    chatRoom.message.receiverID = receiver;
    chatRoom.withWho = receiver;

    // 채팅 리스트 만들기
    _createChatList(chatRoom);

    // 나의 너의 채팅방 만들기
    _createChatRoom(chatRoom);
  }

  void _createChatRoom(ChatRoom chatRoom) {
    _fdb
        .collection(CHAT_ROOM_COLLECTION)
        .doc('${chatRoom.message.senderID}_${chatRoom.message.receiverID}')
        .set(chatRoom.message.toJson());

    chatRoom.withWho = chatRoom.message.senderID;

    _fdb
        .collection(CHAT_ROOM_COLLECTION)
        .doc('${chatRoom.message.receiverID}_${chatRoom.message.senderID}')
        .set(chatRoom.message.toJson());
  }

  void _createChatList(ChatRoom chatRoom) {
    _fdb
        .collection(MemberModel.USERS_COLLECTION)
        .doc('${chatRoom.message.senderID}')
        .collection(CHAT_LIST_COLLECTION)
        .doc('${chatRoom.message.senderID}_${chatRoom.message.receiverID}')
        .set(chatRoom.toJson());

    _fdb
        .collection(MemberModel.USERS_COLLECTION)
        .doc('${chatRoom.message.receiverID}')
        .collection(CHAT_LIST_COLLECTION)
        .doc('${chatRoom.message.receiverID}_${chatRoom.message.senderID}')
        .set(chatRoom.toJson());
  }

  getChatRoomList(int id) {
    return _fdb
        .collection(MemberModel.USERS_COLLECTION)
        .doc('$id')
        .collection(CHAT_ROOM_COLLECTION)
        .snapshots();
  }

  fd.Query getChatMessageList(int receiverID) {
    final senderID = HiveController.instance.getMemberID();

    return _db
        .reference()
        .child(CHAT_ROOM_COLLECTION)
        .child(_mAuth.currentUser.uid)
        .child('${senderID}_$receiverID')
        .orderByKey()
        .limitToLast(10);
  }
}
