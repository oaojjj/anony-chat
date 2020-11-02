import 'package:anony_chat/controller/notification_controller.dart';
import 'package:anony_chat/model/dao/chat_room.dart';
import 'package:anony_chat/model/dao/message.dart';
import 'package:anony_chat/viewmodel/chat_http_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'member_model.dart';

class ChatModel {
  static final FirebaseFirestore _fdb = FirebaseFirestore.instance;
  final _chatHttpModel = ChatHttpModel();

  static const String CHAT_ROOM_COLLECTION = 'chat_room';
  static const String CHAT_LIST_COLLECTION = 'chat_list';
  static const String CHAT_MESSAGES = 'messages';

  Future<void> sendMessage({String chatRoomId, Message message}) async {
    final senderID = message.senderID;
    final receiverID = message.receiverID;

    print('$senderID,$receiverID');
    // 메세지 전송 추가
    _fdb
        .collection(CHAT_ROOM_COLLECTION)
        .doc('$chatRoomId')
        .collection(CHAT_MESSAGES)
        .doc(message.time.toString())
        .set(message.toJson());

    // 알림 보내기
    final peerUserToken = await getFcmToken(message.receiverID);
    NotificationController.instance.sendNotificationToPeerUser(
        text: message.content,
        myID: message.senderID,
        messageType: message.type,
        peerUserToken: peerUserToken);

    // 최근 메시지 업데이트
    _fdb
        .collection(MemberModel.USERS_COLLECTION)
        .doc('$senderID')
        .collection(CHAT_LIST_COLLECTION)
        .doc('$chatRoomId')
        .update({
      'lastMessage': message.type == 'photo' ? '(사진)' : message.content,
      'lastMessageTime': message.time
    });

    _fdb
        .collection(MemberModel.USERS_COLLECTION)
        .doc('$receiverID')
        .collection(CHAT_LIST_COLLECTION)
        .doc('$chatRoomId')
        .update({
      'lastMessage': message.type == 'photo' ? '(사진)' : message.content,
      'lastMessageTime': message.time
    });
  }

  Future<int> createChatRoom(ChatRoom chatRoom) async {
    // api 이용해서 상대방 id 가져오기
    //final matchingResult = await _chatHttpModel.matching();
    //print("#메세지보내기: ${matchingResult.toJson()}");
    //matchingResult.data.item[0]['id'] = 10;

    //if (matchingResult.code == ResponseCode.SUCCESS_CODE) {
    // final receiver = matchingResult.data.item[0]['id'];
    chatRoom.message.receiverID = 10;
    chatRoom.withWho = 10;
    chatRoom.chatRoomID =
        '${chatRoom.message.senderID}_${chatRoom.message.receiverID}';

    // 채팅 리스트 만들기
    _createChatList(chatRoom);

    // 채팅방 만들기
    _createChatRoom(chatRoom);

    // 알림 보내기
    final peerUserToken = await getFcmToken(chatRoom.message.receiverID);
    NotificationController.instance
        .sendNotificationToPeerUser(mode: 0, peerUserToken: peerUserToken);
    // }
    // return matchingResult.code;
    return 1000;
  }

  void _createChatRoom(ChatRoom chatRoom) {
    _fdb
        .collection(CHAT_ROOM_COLLECTION)
        .doc(chatRoom.chatRoomID)
        .collection(CHAT_MESSAGES)
        .doc(chatRoom.message.time.toString())
        .set(chatRoom.message.toJson());
  }

  void _createChatList(ChatRoom chatRoom) {
    _fdb
        .collection(MemberModel.USERS_COLLECTION)
        .doc('${chatRoom.message.senderID}')
        .collection(CHAT_LIST_COLLECTION)
        .doc(chatRoom.chatRoomID)
        .set(chatRoom.toJson());

    chatRoom.withWho = chatRoom.message.senderID;

    _fdb
        .collection(MemberModel.USERS_COLLECTION)
        .doc('${chatRoom.message.receiverID}')
        .collection(CHAT_LIST_COLLECTION)
        .doc(chatRoom.chatRoomID)
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

  getFcmToken(int id) async {
    final data = await _fdb
        .collection(MemberModel.USERS_COLLECTION)
        .doc(id.toString())
        .get();
    return data['fcmToken'];
  }
}