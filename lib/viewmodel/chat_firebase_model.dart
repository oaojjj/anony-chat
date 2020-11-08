import 'package:anony_chat/controller/hive_controller.dart';
import 'package:anony_chat/controller/notification_controller.dart';
import 'package:anony_chat/model/dao/chat_room.dart';
import 'package:anony_chat/model/dao/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'member_model.dart';

class ChatModel {
  static final FirebaseFirestore _fdb = FirebaseFirestore.instance;

  static const String CHAT_ROOM_COLLECTION = 'chat_room';
  static const String CHAT_LIST_COLLECTION = 'chat_list';
  static const String CHAT_MESSAGES = 'messages';

  Future<void> sendMessage({String chatRoomId, Message message}) async {
    // 메세지 전송 추가
    _fdb
        .collection(CHAT_ROOM_COLLECTION)
        .doc('$chatRoomId')
        .collection(CHAT_MESSAGES)
        .doc(message.time.toString())
        .set(message.toJson());

    // 최근 메시지 업데이트
    updateChatList(message.receiverID, chatRoomId, message, false);
    updateChatList(message.senderID, chatRoomId, message, true);

    // 알림 보내기
    final peerUserToken = await getFcmToken(message.receiverID);
    NotificationController.instance.sendNotificationToPeerUser(
        text: message.content,
        myID: message.senderID,
        messageType: message.type,
        unReadMSGCount: await getUnReadMsgCountFuture(chatRoomId),
        peerUserToken: peerUserToken);
  }

  Future<void> updateChatList(
      int senderID, String chatRoomId, Message message, bool isSender) async {
    await _fdb
        .collection(MemberModel.USERS_COLLECTION)
        .doc('$senderID')
        .collection(CHAT_LIST_COLLECTION)
        .doc('$chatRoomId')
        .update({
      'lastMessage': message.type == 'photo' ? '(사진)' : message.content,
      'lastMessageTime': message.time,
      'unReadMsgCount':
          isSender ? FieldValue.increment(0) : FieldValue.increment(1),
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
    NotificationController.instance.sendNotificationToPeerUser(
        mode: 0,
        peerUserToken: peerUserToken,
        unReadMSGCount: await getUnReadMsgCountFuture(chatRoom.chatRoomID));
    // }
    // return matchingResult.code;
    return 1000;
  }

  Future<void> _createChatRoom(ChatRoom chatRoom) async {
    await _fdb
        .collection(CHAT_ROOM_COLLECTION)
        .doc(chatRoom.chatRoomID)
        .set({'activation': true}).then((value) async => await _fdb
            .collection(CHAT_ROOM_COLLECTION)
            .doc(chatRoom.chatRoomID)
            .collection(CHAT_MESSAGES)
            .doc(chatRoom.message.time.toString())
            .set(chatRoom.message.toJson()));
  }

  Future<void> _createChatList(ChatRoom chatRoom) async {
    await _fdb
        .collection(MemberModel.USERS_COLLECTION)
        .doc('${chatRoom.message.senderID}')
        .collection(CHAT_LIST_COLLECTION)
        .doc(chatRoom.chatRoomID)
        .set(chatRoom.toJson());

    chatRoom.withWho = chatRoom.message.senderID;
    chatRoom.activation = false;
    chatRoom.unReadMsgCount = 1;

    await _fdb
        .collection(MemberModel.USERS_COLLECTION)
        .doc('${chatRoom.message.receiverID}')
        .collection(CHAT_LIST_COLLECTION)
        .doc(chatRoom.chatRoomID)
        .set(chatRoom.toJson());
  }

  getChatRoomListActivation(int id) {
    return _fdb
        .collection(MemberModel.USERS_COLLECTION)
        .doc('$id')
        .collection(CHAT_LIST_COLLECTION)
        .where('activation', isEqualTo: true)
        .snapshots();
  }

  getChatRoomListNonActivation(int id) {
    return _fdb
        .collection(MemberModel.USERS_COLLECTION)
        .doc('$id')
        .collection(CHAT_LIST_COLLECTION)
        .where('activation', isEqualTo: false)
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

  fetchFirstMessageList(chatRoomID, limit) async {
    return (await _fdb
            .collection(CHAT_ROOM_COLLECTION)
            .doc(chatRoomID)
            .collection(CHAT_MESSAGES)
            .orderBy('time', descending: true)
            .limit(limit)
            .get())
        .docs;
  }

  fetchNextMessageList(
      List<DocumentSnapshot> documentList, chatRoomID, limit) async {
    return (await _fdb
            .collection(CHAT_ROOM_COLLECTION)
            .doc(chatRoomID)
            .collection(CHAT_MESSAGES)
            .orderBy('time', descending: true)
            .startAfterDocument(documentList[documentList.length - 1])
            .limit(limit)
            .get())
        .docs;
  }

  fetchNewMessage(chatRoomID) async {
    return (await _fdb
            .collection(CHAT_ROOM_COLLECTION)
            .doc(chatRoomID)
            .collection(CHAT_MESSAGES)
            .orderBy('time', descending: true)
            .limit(1)
            .get())
        .docs;
  }

  getFcmToken(int id) async {
    final data = await _fdb
        .collection(MemberModel.USERS_COLLECTION)
        .doc(id.toString())
        .get();
    return data['fcmToken'];
  }

  Future<void> setChatActivation(int id, String chatRoomID, bool b) async {
    await _fdb
        .collection(MemberModel.USERS_COLLECTION)
        .doc('$id')
        .collection(CHAT_LIST_COLLECTION)
        .doc('$chatRoomID')
        .update({'activation': b}).then((value) async => await _fdb
            .collection(CHAT_ROOM_COLLECTION)
            .doc('$chatRoomID')
            .set({'activation': b}));
  }

  checkChatActivation(chatRoomID) =>
      _fdb.collection(CHAT_ROOM_COLLECTION).doc(chatRoomID).snapshots();

  exitChatRoom(id, chatRoomID) {
    setChatActivation(id, chatRoomID, false);
    _fdb
        .collection(MemberModel.USERS_COLLECTION)
        .doc('$id')
        .collection(CHAT_LIST_COLLECTION)
        .doc('$chatRoomID')
        .delete();
  }

  void updateReadMsg(snapshot, id, chatRoomId) async {
    for (var data in snapshot.data) {
      if (data['receiverID'] == id && data['isRead'] == false) {
        if (data.reference != null) {
          FirebaseFirestore.instance.runTransaction((transaction) async =>
              transaction.update(data.reference, {'isRead': true}));
        }
      }
    }

    await _fdb
        .collection(MemberModel.USERS_COLLECTION)
        .doc('$id')
        .collection(CHAT_LIST_COLLECTION)
        .doc('$chatRoomId')
        .update({
      'unReadMsgCount': 0,
    });
  }

  getUnReadMsgCountStream(String chatRoomId) => _fdb
      .collection(MemberModel.USERS_COLLECTION)
      .doc('${HiveController.instance.getMemberID()}')
      .collection(CHAT_LIST_COLLECTION)
      .doc('$chatRoomId')
      .snapshots();

  getUnReadMsgCountFuture(String chatRoomId) {
    final result = _fdb
        .collection(MemberModel.USERS_COLLECTION)
        .doc('${HiveController.instance.getMemberID()}')
        .collection(CHAT_LIST_COLLECTION)
        .doc('$chatRoomId')
        .get();
    result.then((value) => print(value['unReadMsgCount']));
  }
}
