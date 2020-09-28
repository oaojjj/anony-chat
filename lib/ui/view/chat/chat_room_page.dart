import 'package:anony_chat/model/dao/message.dart';
import 'package:anony_chat/ui/widget/chat/chat_message.dart';
import 'package:anony_chat/viewmodel/chat_model.dart';
import 'package:flutter/material.dart';

class ChatRoomPage extends StatefulWidget {
  final receiverID;
  final senderID;

  ChatRoomPage({this.receiverID, this.senderID});

  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final ChatModel _chatModel = ChatModel();
  final List<ChatMessage> _messages = [];
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  final chatAppBarName = '익명의 상대방';

  Future<void> initChatMessages() async {
    final Map chat = await _chatModel.getChatMessageList(widget.receiverID);
    chat.forEach((key, value) {
      print(value);
      ChatMessage message = ChatMessage(
        message: Message(
          time: value['time'],
          content: value['content'],
          senderID: value['senderID'],
          receiverID: value['receiverID'],
        ),
      );
      setState(() => _messages.insert(_messages.length, message));
    });
  }

  @override
  void initState() {
    super.initState();
    initChatMessages();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        endDrawer: _buildEndDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(chatAppBarName, style: TextStyle(color: Colors.black)),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
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
            color: Colors.grey.withOpacity(0.5),
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

    final msg = Message(
        content: text,
        time: DateTime.now().millisecondsSinceEpoch,
        receiverID: widget.receiverID,
        senderID: widget.senderID);

    ChatMessage message = ChatMessage(message: msg,);
    setState(() => _messages.insert(_messages.length, message));

    _focusNode.requestFocus();
    _scrollController.animateTo(_scrollController.position.maxScrollExtent + 56,
        duration: Duration(milliseconds: 100), curve: Curves.easeIn);

    _chatModel.sendMessage(message: msg);
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
      width: 240.0,
      child: Drawer(
        child: ListView(
          children: [
            ListTile(
              dense: true,
              leading: Image.asset(
                'assets/icons/report.png',
                width: 30,
                height: 30,
              ),
              title: Text('신고하기', style: TextStyle(fontSize: 18.0)),
              onTap: () {
                Navigator.pushNamed(context, '/report_chat_page');
              },
            ),
            Divider(
              height: 0,
              color: Colors.black,
            ),
            ListTile(
              dense: true,
              leading: IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {},
              ),
              title: Text('나가기', style: TextStyle(fontSize: 18.0)),
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
