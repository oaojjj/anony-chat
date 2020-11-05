import 'package:anony_chat/controller/hive_controller.dart';
import 'package:anony_chat/ui/view/chat/chat_room_page.dart';
import 'package:anony_chat/ui/widget/chat/chat_room_preview.dart';
import 'package:anony_chat/utils/utill.dart';
import 'package:anony_chat/viewmodel/chat_firebase_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatListPage extends StatefulWidget {
  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  List<ChatRoomPreview> _chatRooms = [];
  ChatModel _chatModel = ChatModel();

  final _receiverID = [];
  final _chatRoomID = [];
  int userId;

  @override
  void initState() {
    super.initState();
    userId = HiveController.instance.getMemberID();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('채팅목록', style: TextStyle(color: Colors.black)),
          centerTitle: true,
          iconTheme: new IconThemeData(color: Colors.black),
        ),
        body: Container(
          child: StreamBuilder(
            stream: _chatModel.getChatRoomListActivation(userId),
            builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData || snapshot.hasError)
                return Center(child: CircularProgressIndicator());
              else {
                mappingData(snapshot.data.docs);
                return ListView.builder(
                  itemCount: _chatRooms.length,
                  itemBuilder: (_, index) => InkWell(
                      highlightColor: chatAccentColor,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatRoomPage(
                                senderID: userId,
                                receiverID: _receiverID[index],
                                chatRoomID: _chatRoomID[index]),
                          ),
                        );
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

      chatList.forEach((QueryDocumentSnapshot element) {
        _receiverID.add(element['withWho']);
        _chatRoomID.add(element.id);
        _chatRooms.add(ChatRoomPreview(
          chatRoomId:element.id,
          previewIcon: 'assets/icons/messageIcons/${element['imageIcon']}',
          lastMessage: element['lastMessage'],
          timestamp: convertTimeToString(element['lastMessageTime']),
        ));
      });
    }
  }
}
