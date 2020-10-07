import 'package:anony_chat/controller/hive_controller.dart';
import 'package:anony_chat/ui/view/chat/chat_room_page.dart';
import 'package:anony_chat/ui/widget/chat/chat_room_preview.dart';
import 'package:anony_chat/utils/utill.dart';
import 'package:anony_chat/viewmodel/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ChatListPage extends StatefulWidget {
  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  List<ChatRoomPreview> _chatRooms = [];
  ChatModel _chatModel = ChatModel();

  final receiverID = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('채팅', style: TextStyle(color: Colors.black)),
          centerTitle: true,
          iconTheme: new IconThemeData(color: Colors.black),
        ),
        body: Container(
          child: StreamBuilder(
            stream: _chatModel.getChatRoomList(1),
            builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData || snapshot.hasError)
                return Center(child: CircularProgressIndicator());
              else {
                snapshot.data.docs.forEach((element) {
                  print(element.data());
                });
                //mappingData(snapshot.data.docs);
                return ListView.builder(
                  itemCount: _chatRooms.length,
                  itemBuilder: (_, index) => InkWell(
                      highlightColor: chatAccentColor,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatRoomPage(
                                    senderID:
                                        HiveController.instance.getMemberID(),
                                    receiverID: receiverID[index])));
                      },
                      child: _chatRooms[index]),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  void mappingData(chatList) {
    if (chatList != null) {
      _chatRooms.clear();
      chatList.forEach((key, value) {
        print(value);
        final time =
            DateTime.fromMillisecondsSinceEpoch(value['lastMessageTime']);
        receiverID.add(value['withWho']);
        _chatRooms.add(ChatRoomPreview(
          previewIcon: 'assets/icons/${value['imageIcon']}',
          lastMessage: value['lastMessage'],
          timestamp: time.toString(),
        ));
      });
    }
  }
}
