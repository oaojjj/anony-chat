import 'dart:io';

import 'package:anony_chat/database/shared_preferences_controller.dart';
import 'package:anony_chat/model/chat_model.dart';
import 'package:anony_chat/model/dao/chat_room.dart';
import 'package:anony_chat/model/dao/message.dart';
import 'package:anony_chat/model/member_model.dart';
import 'package:anony_chat/ui/widget/bottom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatSendPage extends StatefulWidget {
  @override
  _ChatSendPageState createState() => _ChatSendPageState();
}

class _ChatSendPageState extends State<ChatSendPage> {
  final _messageController = TextEditingController();

  String _choiceImage = 'earth.png';
  ChatType _selectedSendType = ChatType.random;
  File _photo;

  final List<Widget> _images = [];
  final List<String> _planetName = [
    'earth.png',
    'moon.png',
    'planet1.png',
    'planet2.png',
    'planet3.png',
    'planet4.png',
    'planet5.png',
    'planet6.png',
  ];

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text('메시지 보내기', style: TextStyle(color: Colors.white)),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            iconTheme: IconThemeData(color: Colors.white)),
        backgroundColor: Colors.grey[900],
        body: Container(
          child: SingleChildScrollView(
            child: Container(
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
                            child: GestureDetector(
                              onTap: () => _choicePlanet(),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image(
                                    image: AssetImage(
                                        'assets/images/$_choiceImage')),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: IconButton(
                                  icon: Icon(Icons.settings,
                                      color: Colors.grey[700]),
                                  onPressed: () => _choicePlanet()),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Container(
                      color: Colors.white,
                      height: 240,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                            controller: _messageController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration:
                                InputDecoration.collapsed(hintText: '메시지 입력')),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Row(
                      children: [
                        RaisedButton(
                            child: Text('사진'), onPressed: () => uploadImage()),
                        Spacer(),
                        StreamBuilder(
                            stream: MemberModel.getPossibleMessageOfSend(),
                            builder: (_, AsyncSnapshot<Event> snap) {
                              if (!snap.hasData)
                                return Row(children: [
                                  Text('오늘 보낼 수 있는 메시지:',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white)),
                                  CircularProgressIndicator()
                                ]);
                              return Text(
                                  '오늘 보낼 수 있는 메시지: ${snap.data.snapshot.value.toString()}개',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white));
                            }),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  BottomButton(
                    text: '보내기',
                    onPressed: () async {
                      await sendMessage();
                      Navigator.pop(context);
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
    return ChatModel.createChatRoom(
      chatRoom: ChatRoom(
        planetName: _choiceImage,
        type: _selectedSendType,
        message: Message(
          senderID: await SPController.getID(),
          content: _messageController.text,
          photo: _photo,
          time: DateTime.now().millisecondsSinceEpoch,
        ),
      ),
    );
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
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text('확인', style: TextStyle(color: Colors.black)),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        });
      },
    );
  }

  Future<void> _choicePlanet() async {
    return showDialog(
      context: context,
      builder: (_) => Material(
        type: MaterialType.transparency,
        child: Center(
          child: Container(
              color: Colors.white30,
              padding: EdgeInsets.all(32),
              child: GridView.count(crossAxisCount: 3, children: _images)),
        ),
      ),
    );
  }

  Widget createPlanet(String path) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        setState(() => _choiceImage = path);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image(image: AssetImage('assets/images/$path')),
      ),
    );
  }

  void initData() {
    _planetName.forEach((element) {
      _images.add(createPlanet(element));
    });
  }

  Future uploadImage() async {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);
    _photo = File(image.path);
  }
}
