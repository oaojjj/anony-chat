import 'package:anony_chat/controller/hive_controller.dart';
import 'package:anony_chat/model/dao/chat_room.dart';
import 'package:anony_chat/model/dao/message.dart';
import 'package:anony_chat/ui/widget/bottom_button.dart';
import 'package:anony_chat/utils/utill.dart';
import 'package:anony_chat/viewmodel/chat_firebase_model.dart';
import 'package:anony_chat/viewmodel/member_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChatSendPage extends StatefulWidget {
  @override
  _ChatSendPageState createState() => _ChatSendPageState();
}

class _ChatSendPageState extends State<ChatSendPage> {
  static const double DIALOG_CONTAINER_HEIGHT = 450;
  final _focusNode = FocusNode();
  final String _messageCountIconPath = 'assets/icons/message_count.png';

  ChatModel _chatModel = ChatModel();
  final _messageController = TextEditingController();

  String _choiceIcon = 'messageIcon1.png';

  int possibleMessageOfSend;

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
    possibleMessageOfSend = HiveController.instance.getPossibleMessageOfSend();
    print(HiveController.instance.loadMemberInfoToLocal());
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
        body: GestureDetector(
          onTap: () => _focusNode.unfocus(),
          child: Container(
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
                                    icon: Image.asset(
                                        'assets/icons/$_choiceIcon'),
                                    onPressed: () => _buildImageGridView())),
                            Positioned(
                              top: 8,
                              right: 4,
                              child: CircleAvatar(
                                backgroundColor: chatPrimaryColor,
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
                        Text(
                          possibleMessageOfSend.toString(),
                          style:
                              TextStyle(color: chatPrimaryColor, fontSize: 25),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Container(
                      height: 150,
                      child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextField(
                              focusNode: _focusNode,
                              controller: _messageController,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration.collapsed(
                                  hintText: '메시지 입력')),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.0),
                    BottomButton(
                      text: '보내기',
                      onPressed: () async {
                        if (_messageController.text.length <= 0) {
                          showToast('메세지를 입력해주세요!!');
                          return;
                        }
                        final response = await _sendMessage();

                        if (response == ResponseCode.RUN_OUT) {
                          showToast('보낼 수 있는 메시지가 없습니다.\n아이템을 구매해 주세요.');
                        } else if (response == ResponseCode.SUCCESS_CODE) {
                          showToast('메세지를 보냈습니다.');
                          Navigator.pop(context);
                        } else if (response ==
                            ResponseCode.THERE_ARE_NO_USERS) {
                          showToast('매칭가능한 유저가 없습니다.\n죄송합니다.');
                        } else {
                          showToast('알수없는 에러입니다.\n관리자에게 문의해주세요.');
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<int> _sendMessage() async {
    final chatResult = await _chatModel.createChatRoom(
      ChatRoom(
        imageIcon: _choiceIcon,
        message: Message(
          senderID: HiveController.instance.getMemberID(),
          content: _messageController.text,
          time: DateTime.now().millisecondsSinceEpoch,
        ),
      ),
    );
    return chatResult;
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
                        children: _buildGridItem()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _createIcon(String path) {
    bool flag = path == _choiceIcon;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ClipOval(
        child: Material(
          color: flag ? chatPrimaryColor : Colors.white,
          child: InkWell(
            highlightColor: chatPrimaryColor,
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

  _buildGridItem() {
    _icons.clear();
    _iconName.forEach((element) => _icons.add(_createIcon(element)));
    return _icons;
  }
}
