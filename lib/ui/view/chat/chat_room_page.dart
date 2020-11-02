import 'dart:async';

import 'package:anony_chat/controller/firebase_controller.dart';
import 'package:anony_chat/controller/pick_image_controller.dart';
import 'package:anony_chat/model/dao/message.dart';
import 'package:anony_chat/provider/auth_provider.dart';
import 'package:anony_chat/ui/widget/chat/chat_message.dart';
import 'package:anony_chat/viewmodel/chat_firebase_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

class ChatRoomPage extends StatefulWidget {
  final receiverID;
  final senderID;
  final chatRoomID;

  ChatRoomPage({this.receiverID, this.senderID, this.chatRoomID});

  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final ChatModel _chatModel = ChatModel();
  final FocusNode _focusNode = FocusNode();

  final _messageController = TextEditingController();
  final _scrollController = ScrollController();

  final chatAppBarName = '익명의 상대방';

  int limit = 20;
  bool _isSubmit = true;

  AuthState _authState;

  bool flag = false;
  String timeLine;

  List _elements = [];

  @override
  void initState() {
    super.initState();
    _authState = Provider.of<AuthProvider>(context, listen: false).authState;
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
          elevation: 2,
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
                child: StreamBuilder(
                  stream:
                      _chatModel.getChatMessageList(widget.chatRoomID, limit),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      // isRead -> true
                      updateReadMsg(snapshot);

                      _elements.clear();
                      snapshot.data.documents.forEach((element) {
                        final value = element.data();
                        print('msg: $value');
                        _elements.add({
                          'item': ChatMessage(
                            message: Message(
                                senderID: value['senderID'],
                                content: value['content'],
                                time: value['time'],
                                type: value['type'],
                                isRead: value['isRead']),
                          ),
                          'date': value['time'],
                          'group': DateFormat('yyyy.MM.d').format(
                              DateTime.fromMillisecondsSinceEpoch(
                                  value['time']))
                        });
                      });
                      return StickyGroupedListView<dynamic, String>(
                        elements: _elements,
                        groupBy: (element) => element['group'],
                        groupSeparatorBuilder: (dynamic element) =>
                            _buildDivider(element['group']),
                        itemBuilder: (context, dynamic element) =>
                            element['item'],
                        itemComparator: (item1, item2) =>
                            item1['date'].compareTo(item2['date']),
                        floatingHeader: true,
                        order: StickyGroupedListOrder.DESC,
                        reverse: true,
                      );
                    }
                  },
                ),
              ),
              _buildTextComposer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider(String groupByValue) {
    return Row(children: <Widget>[
      Expanded(
          child: Divider(
        color: Colors.black,
        thickness: 0.5,
        indent: 8,
      )),
      Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Text(groupByValue),
      ),
      Expanded(
          child: Divider(
        color: Colors.black,
        thickness: 0.5,
        endIndent: 8,
      )),
    ]);
  }

  void updateReadMsg(snapshot) {
    for (var data in snapshot.data.documents) {
      if (data['receiverID'] == widget.senderID && data['isRead'] == false) {
        if (data.reference != null) {
          FirebaseFirestore.instance.runTransaction((transaction) async =>
              transaction.update(data.reference, {'isRead': true}));
        }
      }
    }
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
                onPressed: () => sendImageFile()),
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
                onPressed: () => _handleSubmitted(_messageController.text)),
          ),
        ],
      ),
    );
  }

  void sendImageFile() {
    PickImageController.instance.cropImageFromFile().then((croppedFile) {
      if (croppedFile != null) {
        _saveImageToFirebaseStorage(croppedFile);
      }
    });
  }

  Future<void> _saveImageToFirebaseStorage(croppedFile) async {
    try {
      String imageURL = await FirebaseController.instance
          .sendImageToUserInChatRoom(croppedFile, widget.chatRoomID);
      _handleSubmitted(imageURL, type: 'photo');
    } catch (e) {
      print(e.toString());
    }
  }

  void _handleSubmitted(String content, {String type = 'text'}) {
    if (content.isEmpty) return;
    _messageController.clear();

    final msg = Message(
        content: content,
        type: type,
        time: DateTime.now().millisecondsSinceEpoch,
        receiverID: widget.receiverID,
        senderID: widget.senderID);

    _chatModel.sendMessage(chatRoomId: widget.chatRoomID, message: msg);
    _focusNode.requestFocus();
    _scrollController.animateTo(0.0,
        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
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
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/icons/report.png',
                  width: 30,
                  height: 24,
                ),
              ),
              title: Text('신고하기',
                  style: TextStyle(
                      fontSize: 18.0,
                      color: _authState == AuthState.authorizations
                          ? Colors.black
                          : Colors.grey)),
              onTap: _authState == AuthState.authorizations
                  ? () {
                      Navigator.pushNamed(context, '/report_chat_page');
                    }
                  : null,
            ),
            Divider(
              height: 0,
              color: Colors.black,
            ),
            ListTile(
              dense: true,
              leading: IconButton(
                icon: Icon(Icons.exit_to_app, size: 30),
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
