import 'package:anony_chat/ui/widget/chat_message.dart';
import 'package:flutter/material.dart';

class ChatRoomPage extends StatefulWidget {
  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final List<ChatMessage> _messages = [];
  final _messageController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        endDrawer: Container(
          width: 200.0,
          child: Drawer(
            child: ListView(
              children: [
                ListTile(
                  dense: true,
                  title: Text('신고하기', style: TextStyle(fontSize: 18.0)),
                  onTap: () {},
                ),
                Divider(
                  height: 0,
                  color: Colors.black,
                ),
                ListTile(
                  dense: true,
                  title: Text('채팅방 나가기', style: TextStyle(fontSize: 18.0)),
                  onTap: () {},
                )
              ],
            ),
          ),
        ),
        appBar: AppBar(
          title: Text('채팅방'),
          centerTitle: true,
          actions: [
            // hint => https://www.freewebmentor.com/questions/how-to-change-the-enddrawer-icon-in-flutter
            // endDrawer 아이콘 바꾸기
            Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
              ),
            ),
          ],
        ),
        body: Container(
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  itemBuilder: (_, index) => _messages[index],
                  itemCount: _messages.length,
                ),
              ),
              _buildTextComposer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextComposer() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.amberAccent,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56.0,
            height: 48.0,
            child: FlatButton(
                child: Icon(Icons.photo, size: 24.0),
                //Text('사진', style: TextStyle(fontWeight: FontWeight.bold)),
                onPressed: () {}),
          ),
          Flexible(
            child: TextField(
              controller: _messageController,
              onSubmitted: _handleSubmitted,
              decoration: InputDecoration.collapsed(hintText: '채팅 작성'),
              focusNode: _focusNode,
            ),
          ),
          Container(
            width: 56.0,
            height: 48.0,
            child: FlatButton(
                child: Icon(Icons.send, size: 24.0),
                //Text('사진', style: TextStyle(fontWeight: FontWeight.bold)),
                onPressed: () => _handleSubmitted(_messageController.text)),
          ),
        ],
      ),
    );
  }

  void _handleSubmitted(String text) {
    if(text.isEmpty)
      return;
    _messageController.clear();
    ChatMessage message = ChatMessage(text: text);
    setState(() => _messages.insert(_messages.length, message));
    _focusNode.requestFocus();
  }
}
