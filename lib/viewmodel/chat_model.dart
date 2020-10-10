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
  static const String CHAT_MESSAGES = 'messages';

  Future<void> sendMessage({Message message}) async {
    final senderID = 2;
    final receiverID = 1;

    // 메세지 전송 추가
    _fdb
        .collection(CHAT_ROOM_COLLECTION)
        .doc('${senderID}_$receiverID')
        .collection(CHAT_MESSAGES)
        .doc(message.time.toString())
        .set(message.toJson());

    _fdb
        .collection(CHAT_ROOM_COLLECTION)
        .doc('${receiverID}_$senderID')
        .collection(CHAT_MESSAGES)
        .doc(message.time.toString())
        .set(message.toJson());

    // 최근 메시지 업데이트
    _fdb
        .collection(MemberModel.USERS_COLLECTION)
        .doc('$senderID')
        .collection(CHAT_LIST_COLLECTION)
        .doc('${senderID}_$receiverID')
        .update(
            {'lastMessage': message.content, 'lastMessageTime': message.time});

    _fdb
        .collection(MemberModel.USERS_COLLECTION)
        .doc('$receiverID')
        .collection(CHAT_LIST_COLLECTION)
        .doc('${receiverID}_$senderID')
        .update(
            {'lastMessage': message.content, 'lastMessageTime': message.time});
  }

  // TODO 매칭시스템 만들기
  createChatRoom({ChatRoom chatRoom}) async {
    // chatRoom.message.senderID = HiveController.instance.getMemberID();

    int receiver = 1;
    chatRoom.message.senderID = 2;
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
        .collection(CHAT_MESSAGES)
        .doc(chatRoom.message.time.toString())
        .set(chatRoom.message.toJson());
  }

  void _createChatList(ChatRoom chatRoom) {
    _fdb
        .collection(MemberModel.USERS_COLLECTION)
        .doc('${chatRoom.message.senderID}')
        .collection(CHAT_LIST_COLLECTION)
        .doc('${chatRoom.message.senderID}_${chatRoom.message.receiverID}')
        .set(chatRoom.toJson());

    chatRoom.withWho = chatRoom.message.senderID;

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
        .collection(CHAT_LIST_COLLECTION)
        .snapshots();
  }

  getChatMessageList(String chatRoomID, int limit) {
    return _fdb
        .collection(CHAT_ROOM_COLLECTION)
        .doc(chatRoomID)
        .collection(CHAT_MESSAGES)
        .orderBy('time', descending: true)
        .limit(limit)
        .snapshots();
  }
}
