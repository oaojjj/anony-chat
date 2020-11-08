import 'dart:async';
import 'dart:io';

import 'package:anony_chat/viewmodel/chat_firebase_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class MessageProvider extends ChangeNotifier {
  ChatModel _chatModel;
  List<QueryDocumentSnapshot> documentList;
  var messageController;

  MessageProvider() {
    _chatModel = ChatModel();
    messageController = BehaviorSubject<List<DocumentSnapshot>>();
  }

  get messageStream => messageController.stream;

  Future fetchFirstList(String chatRoomID, limit) async {
    try {
      documentList = await _chatModel.fetchFirstMessageList(chatRoomID, limit);
      print("fetchFirstList:$documentList");

      messageController.sink.add(documentList);
      try {
        if (documentList.length == 0) {
          messageController.sink.addError("No Data Available");
        }
      } catch (e) {}
    } on SocketException {
      messageController.sink
          .addError(SocketException("No Internet Connection"));
    } catch (e) {
      print(e.toString());
      messageController.sink.addError(e);
    }
  }

  fetchNextMovies(String chatRoomID, limit) async {
    try {
      final newDocumentList = await _chatModel.fetchNextMessageList(
          documentList, chatRoomID, limit);
      documentList.addAll(newDocumentList);
      messageController.sink.add(documentList);
      try {
        if (documentList.length == 0) {
          messageController.sink.addError("No Data Available");
        }
      } catch (e) {
        print(e.toString());
      }
    } on SocketException {
      messageController.sink
          .addError(SocketException("No Internet Connection"));
    } catch (e) {
      print(e.toString());
      messageController.sink.addError(e);
    }
  }

  // ignore: must_call_super
  void dispose() => messageController.close();

  Future<void> requestMessages(chatRoomID, time) async {
    try {
      final newDocumentList =
          await _chatModel.fetchNewMessage(chatRoomID, time);
      documentList.insert(0, newDocumentList[0]);
      messageController.sink.add(documentList);
      try {
        if (documentList.length == 0) {
          messageController.sink.addError("No Data Available");
        }
      } catch (e) {
        print(e.toString());
      }
    } on SocketException {
      messageController.sink
          .addError(SocketException("No Internet Connection"));
    } catch (e) {
      print(e.toString());
      messageController.sink.addError(e);
    }
  }
}
