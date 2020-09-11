import 'package:anony_chat/model/chat_model.dart';
import 'package:anony_chat/ui/widget/chat/chat_room_preview.dart';
import 'file:///C:/Users/Oseong/AndroidStudioProjects/anony_chat/lib/ui/widget/home/home_drawer.dart';
import 'package:flutter/material.dart';

class ChatListPage extends StatefulWidget {
  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  List<ChatRoomPreview> _chatRooms = [];

  @override
  Widget build(BuildContext context) {
    getChatList();
    return SafeArea(
        child: Scaffold(
      drawer: HomeDrawer(),
      appBar: AppBar(
        title: Text('채팅 목록', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Colors.black87,
        child: ListView.builder(
          itemBuilder: (_, index) => FutureBuilder(
              future: getChatList(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(child: CircularProgressIndicator());
                else {
                  return InkWell(onTap: () {}, child: _chatRooms[index]);
                }
              }),
          itemCount: _chatRooms.length,
        ),
      ),
    ));
  }

  Future<List<ChatRoomPreview>> getChatList() async {
    _chatRooms = await ChatModel.getChatList();
    return _chatRooms;
  }
}
