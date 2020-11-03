import 'dart:async';

import 'package:anony_chat/controller/firebase_controller.dart';
import 'package:anony_chat/controller/pick_image_controller.dart';
import 'package:anony_chat/model/dao/member.dart';
import 'package:anony_chat/model/dao/message.dart';
import 'package:anony_chat/provider/auth_provider.dart';
import 'package:anony_chat/ui/widget/always_disabled_focus_node.dart';
import 'package:anony_chat/ui/widget/chat/chat_message.dart';
import 'package:anony_chat/utils/utill.dart';
import 'package:anony_chat/viewmodel/chat_firebase_model.dart';
import 'package:anony_chat/viewmodel/chat_http_model.dart';
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

  final _chatHttpModel = ChatHttpModel();

  AuthState _authState;
  Member member = Member();

  IconData floatingIcon = Icons.person;

  int limit = 20;
  double _animatedHeight = 60.0;
  bool clickFlag = false;
  bool infoFlag = false;

  String timeLine;

  List _elements = [];

  @override
  void initState() {
    super.initState();
    _authState = Provider.of<AuthProvider>(context, listen: false).authState;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final infoResult =
          await _chatHttpModel.getMatchingUserInfo(widget.receiverID);
      print('#채팅유저인포 결과:${infoResult.toJson()}');
      if (infoResult.code == ResponseCode.SUCCESS_CODE) {
        member.birthYear = infoResult.data.item[0]['birth_year'];
        member.gender = infoResult.data.item[0]['gender'];
        member.university = infoResult.data.item[0]['school'];
        member.department = infoResult.data.item[0]['department'];
        infoFlag = true;
      } else {
        infoFlag = false;
      }
    });
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
                child: Stack(
                  children: [
                    StreamBuilder(
                      stream: _chatModel.getChatMessageList(
                          widget.chatRoomID, limit),
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
                                    receiverID: value['receiverID'],
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
                            floatingHeader: false,
                            order: StickyGroupedListOrder.DESC,
                            reverse: true,
                          );
                        }
                      },
                    ),
                    Positioned(
                      right: 30,
                      top: infoFlag ? 24 : 36,
                      child: Container(
                        child: AnimatedContainer(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 1,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          duration: const Duration(milliseconds: 200),
                          child: buildContainerInfo(),
                          height: _animatedHeight,
                          width: infoFlag ? 150 : 130,
                        ),
                      ),
                    ),
                    Positioned(
                        right: 4,
                        top: 16,
                        child: Container(
                          height: 44,
                          child: FloatingActionButton(
                            onPressed: () {
                              setState(() {
                                if (clickFlag) {
                                  floatingIcon = Icons.person;
                                  _animatedHeight = 0.0;
                                } else {
                                  floatingIcon = Icons.close;
                                  _animatedHeight = infoFlag ? 60.0 : 35.0;
                                }
                              });
                              clickFlag = !clickFlag;
                            },
                            backgroundColor: Colors.white,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            child: Icon(
                              floatingIcon,
                              size: 32,
                              color: chatPrimaryColor,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              Container(
                color: Colors.black,
                height: 50,
                width: double.infinity,
                child: Center(
                  child: Text(
                    '광고배너',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              _buildTextComposer(),
            ],
          ),
        ),
      ),
    );
  }

  Container buildContainerInfo({textColor = chatPrimaryColor}) {
    return new Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: infoFlag
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      text: '${member.birthYear}살',
                      style: TextStyle(color: textColor),
                      children: <TextSpan>[
                        TextSpan(text: ' · '),
                        TextSpan(text: member.gender),
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      text: member.university,
                      style: TextStyle(color: textColor),
                      children: <TextSpan>[
                        TextSpan(text: ' · '),
                        TextSpan(text: member.department),
                      ],
                    ),
                  )
                ],
              )
            : Text('회원정보 비공개'),
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
                onPressed: () => sendImageFile()),
          ),
          Flexible(
            child: _authState == AuthState.authorizations
                ? TextField(
                    controller: _messageController,
                    onSubmitted: _handleSubmitted,
                    decoration: InputDecoration.collapsed(hintText: '채팅 작성'),
                    focusNode: _focusNode,
                  )
                : TextField(
                    enableInteractiveSelection: false,
                    enabled: false,
                    decoration:
                        InputDecoration.collapsed(hintText: '서비스가 제한됩니다.'),
                    focusNode: AlwaysDisabledFocusNode(),
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
    if (_authState != AuthState.authorizations) return;
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
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        contentPadding: EdgeInsets.all(0),
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '주의',
                          style:
                              TextStyle(color: chatPrimaryColor, fontSize: 24),
                        ),
                      ),
                    ),
                    Text('채팅방을 나가면'),
                    Text('더이상 대화를 할 수없습니다.'),
                    SizedBox(height: 16.0),
                    Text('채팅방을 나가시겠습니까?'),
                    SizedBox(height: 24.0),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        color: Colors.black,
                        height: 45,
                        child: Center(
                          child: Text(
                            '취소',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () => exitChatRoom(context),
                      child: Container(
                        color: chatPrimaryColor,
                        height: 45,
                        child: Center(
                          child: Text(
                            '나가기',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void exitChatRoom(BuildContext context) {
    Navigator.popUntil(context, ModalRoute.withName('/chat_list_page'));
    // TODO 채팅 나갔을 때 이벤트들
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
                      Navigator.pushNamed(context, '/chat_report_page',
                          arguments: widget.receiverID);
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
              onTap: () => _showMyDialog(),
            )
          ],
        ),
      ),
    );
  }

  showInfo() {}
}
