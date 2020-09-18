import 'dart:io';

import 'package:anony_chat/model/dao/chat_room.dart';
import 'package:anony_chat/model/dao/message.dart';
import 'package:anony_chat/ui/widget/bottom_button.dart';
import 'package:anony_chat/viewmodel/chat_model.dart';
import 'package:anony_chat/viewmodel/member_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatSendPage extends StatefulWidget {
  @override
  _ChatSendPageState createState() => _ChatSendPageState();
}

class _ChatSendPageState extends State<ChatSendPage> {
  static const double DIALOG_CONTAINER_HEIGHT = 450;
  final String _messageCountIconPath = 'assets/icons/message_count.png';

  ChatModel _chatModel = ChatModel();
  final _messageController = TextEditingController();

  String _choiceIcon = 'messageIcon1.png';
  ChatType _selectedSendType = ChatType.random;

  bool _flag = false;

  final List<Widget> _icons = [];
  final List<String> _iconName = [
    'messageIcon1.png',
    'messageIcon2.png',
    'messageIcon3.png',
    'messageIcon4.png',
    'messageIcon5.png',
    'messageIcon6.png',
    'messageIcon7.png',
    'messageIcon8.png',
  ];

  @override
  void initState() {
    super.initState();
    // initData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white10,
          title: Text('메시지 보내기', style: TextStyle(color: Colors.black)),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 40.0),
                  Center(
                    child: Container(
                      width: 120,
                      child: Stack(
                        children: [
                          Container(
                              width: 120.0,
                              height: 120.0,
                              child: IconButton(
                                  icon:
                                      Image.asset('assets/icons/$_choiceIcon'),
                                  onPressed: () => _buildImageGridView())),
                          Positioned(
                            top: 8,
                            right: 4,
                            child: CircleAvatar(
                              backgroundColor: Colors.indigo,
                              child: IconButton(
                                  icon: Icon(Icons.autorenew,
                                      color: Colors.white),
                                  onPressed: () => _buildImageGridView()),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40.0),
                  Row(
                    children: [
                      Container(
                          height: 25,
                          child: Image.asset(_messageCountIconPath)),
                      SizedBox(width: 8),
                      FutureBuilder(
                        future: MemberModel.getPossibleMessageOfSend(),
                        builder: (_, snap) {
                          if (!snap.hasData)
                            return Container(
                                width: 25,
                                height: 25,
                                child: CircularProgressIndicator());
                          return Text('${snap.data}',
                              style: TextStyle(
                                  color: Colors.indigo, fontSize: 25));
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Container(
                    color: Colors.white,
                    height: 150,
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextField(
                            controller: _messageController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration:
                                InputDecoration.collapsed(hintText: '메시지 입력')),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.0),
                  BottomButton(
                    text: '보내기',
                    onPressed: () async {
                      //await sendMessage();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> sendMessage() async {
    await _selectSendType();
    if (_flag) {
      _chatModel.createChatRoom(
        chatRoom: ChatRoom(
          planetImageName: _choiceIcon,
          type: _selectedSendType,
          message: Message(
            content: _messageController.text,
            time: DateTime.now().millisecondsSinceEpoch,
          ),
        ),
      );
      Navigator.pop(context);
    }
  }

  Future<void> _selectSendType() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (_) {
        return StatefulBuilder(builder: (_, setState) {
          return AlertDialog(
            title: Text('누구에게 보낼까요?'),
            content: Container(
              height: 170,
              child: Column(
                children: [
                  ListTile(
                    title: const Text('랜덤'),
                    leading: Radio(
                      value: ChatType.random,
                      groupValue: _selectedSendType,
                      onChanged: (value) =>
                          setState(() => _selectedSendType = value),
                    ),
                  ),
                  ListTile(
                    title: const Text('남성'),
                    leading: Radio(
                      value: ChatType.onlyMan,
                      groupValue: _selectedSendType,
                      onChanged: (value) =>
                          setState(() => _selectedSendType = value),
                    ),
                  ),
                  ListTile(
                    title: const Text('여성'),
                    leading: Radio(
                      value: ChatType.onlyWoman,
                      groupValue: _selectedSendType,
                      onChanged: (value) =>
                          setState(() => _selectedSendType = value),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('취소', style: TextStyle(color: Colors.black)),
                onPressed: () {
                  _flag = false;
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('확인', style: TextStyle(color: Colors.black)),
                onPressed: () {
                  _flag = true;
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
      },
    );
  }

  Future<void> _buildImageGridView() async {
    return showDialog(
      context: context,
      builder: (_) => Material(
        type: MaterialType.transparency,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              color: Colors.white,
              width: double.infinity,
              height: DIALOG_CONTAINER_HEIGHT,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text('메시지 아이콘을 선택해 주세요',
                        style: TextStyle(fontSize: 15)),
                  ),
                  Container(
                    height: DIALOG_CONTAINER_HEIGHT - 70,
                    child: GridView.count(
                        padding: EdgeInsets.all(8),
                        crossAxisCount: 3,
                        children: createGridItem()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget createIcon(String path) {
    bool flag = path == _choiceIcon;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ClipOval(
        child: Material(
          color: flag ? Colors.indigo : Colors.white,
          child: InkWell(
            highlightColor: Colors.indigo,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image.asset('assets/icons/$path'),
            ),
            onTap: () {
              Navigator.pop(context);
              setState(() => _choiceIcon = path);
            },
          ),
        ),
      ),
    );
  }

  void initData() {
    _iconName.forEach((element) => _icons.add(createIcon(element)));
  }

  createGridItem() {
    _icons.clear();
    _iconName.forEach((element) => _icons.add(createIcon(element)));
    return _icons;
  }
}
