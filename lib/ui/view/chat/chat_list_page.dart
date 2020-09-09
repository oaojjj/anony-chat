import 'package:anony_chat/ui/widget/chat/chat_room_preview.dart';
import 'package:anony_chat/ui/widget/home_drawer.dart';
import 'package:flutter/material.dart';

class ChatListPage extends StatefulWidget {
  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  final List<ChatRoomPreview> _chatRooms = [
    ChatRoomPreview(
        title: '오늘 뭐하세요?',
        sex: '여성',
        date: '9월 9일',
        imagePath: 'assets/images/moon.png'),
    ChatRoomPreview(
        title: '같이 롤 할래요?',
        sex: '여성',
        date: '9월 6일',
        imagePath: 'assets/images/planet1.png'),
    ChatRoomPreview(
        title: '싸움 잘하세요?',
        sex: '남성',
        date: '2019년 12월 11일',
        imagePath: 'assets/images/planet2.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      drawer: HomeDrawer(),
      appBar: AppBar(
        title: Text('채팅 목록', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: new IconThemeData(color: Colors.white),
        actions: [
          IconButton(
              icon: Icon(Icons.home), onPressed: () => Navigator.pop(context))
        ],
      ),
      body: Container(
        color: Colors.black87,
        child: ListView.builder(
          padding: EdgeInsets.only(top: 8.0),
          itemBuilder: (_, index) => _chatRooms[index],
          itemCount: _chatRooms.length,
        ),
      ),
    ));
  }
}
