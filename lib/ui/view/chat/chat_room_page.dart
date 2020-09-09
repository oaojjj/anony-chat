import 'file:///C:/Users/Oseong/AndroidStudioProjects/anony_chat/lib/ui/widget/chat/chat_message.dart';
import 'package:flutter/material.dart';

class ChatRoomPage extends StatefulWidget {
  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final List<ChatMessage> _messages = [];
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        endDrawer: _buildEndDrawer(),
        appBar: AppBar(
          title: Text('채팅방', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
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
          color: Colors.black87,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
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
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 1,
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
    if (text.isEmpty) return;
    _messageController.clear();
    ChatMessage message = ChatMessage(text: text);
    setState(() => _messages.insert(_messages.length, message));
    _focusNode.requestFocus();
    _scrollController.animateTo(_scrollController.position.maxScrollExtent + 56,
        duration: Duration(milliseconds: 100), curve: Curves.easeIn);
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (_) {
        return AlertDialog(
          title: Text('나가기'),
          content: Text('채팅방을 나가면 더이상 대화를 할 수 없습니다.'),
          actions: <Widget>[
            FlatButton(
              child: Text('취소', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('나가기', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.popUntil(
                    context, ModalRoute.withName(Navigator.defaultRouteName));
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildEndDrawer() {
    return Container(
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
              onTap: () {
                _showMyDialog();
              },
            )
          ],
        ),
      ),
    );
  }
}
