import 'package:anony_chat/ui/widget/chat/chat_room_preview.dart';
import 'package:anony_chat/viewmodel/chat_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatListPage extends StatefulWidget {
  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  List<ChatRoomPreview> _chatRooms = [];
  ChatModel _chatModel = ChatModel();

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
            stream:
                _chatModel.getChatList(FirebaseAuth.instance.currentUser.uid),
            builder: (_, AsyncSnapshot<Event> snap) {
              if (!snap.hasData || snap.hasError)
                return Center(child: CircularProgressIndicator());
              else {
                mappingData(snap.data.snapshot.value);
                return ListView.builder(
                  itemCount: _chatRooms.length,
                  itemBuilder: (_, index) => InkWell(
                      highlightColor: Colors.amber,
                      onTap: () {

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

  void mappingData(Map data) {
    if (data != null) {
      _chatRooms.clear();
      data.forEach((key, value) {
        final time = DateFormat('MM월 dd일 hh:mm aa')
            .format(DateTime.fromMillisecondsSinceEpoch(value['lastMessageTime']))
            .toString();

        _chatRooms.add(ChatRoomPreview(
          previewIcon: 'assets/icons/${value['imageIcon']}',
          lastMessage: value['lastMessage'],
          timestamp: time,
        ));
      });
    }
  }
}
