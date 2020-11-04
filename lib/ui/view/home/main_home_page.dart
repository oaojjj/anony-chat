import 'package:anony_chat/controller/hive_controller.dart';
import 'package:anony_chat/provider/auth_provider.dart';
import 'package:anony_chat/ui/widget/home/home_drawer.dart';
import 'package:anony_chat/ui/widget/home/stack_item.dart';
import 'package:anony_chat/utils/utill.dart';
import 'package:anony_chat/viewmodel/chat_firebase_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final String _messageCountIconPath = 'assets/icons/message_count.png';
  final String _menuIconPath = 'assets/icons/menu.png';
  final String _adIconPath = 'assets/icons/ad_plus_chat.png';
  final String _sendMsgIconPath = 'assets/icons/send_messageIcon.png';
  final String _chatListIconPath = 'assets/icons/chat_list.png';

  final _chatModel = ChatModel();

  final List<Widget> stackItems = [];

  final int userId = HiveController.instance.getMemberID();
  Size deviceSize;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var status = await Permission.storage.status;
      if (status.isUndetermined) {
        Permission.storage.request();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: HomeDrawer(),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 35,
                  child: IconButton(
                    icon: Image.asset(_menuIconPath),
                    onPressed: () => _scaffoldKey.currentState.openDrawer(),
                  ),
                ),
                Row(
                  children: [
                    Container(
                        height: 25, child: Image.asset(_messageCountIconPath)),
                    Text(
                        HiveController.instance
                            .getPossibleMessageOfSend()
                            .toString(),
                        style:
                            TextStyle(color: chatPrimaryColor, fontSize: 25)),
                    SizedBox(width: 16),
                    Container(
                      width: 60,
                      child: IconButton(
                        icon: Image.asset(_adIconPath),
                        onPressed: () =>
                            Navigator.pushNamed(context, '/ad_watching_page'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              child: StreamBuilder(
                stream: _chatModel.getChatRoomListNonActivation(userId),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    stackItems.clear();
                    snapshot.data.docs.forEach((element) {
                      stackItems.add(StackItem(
                        chatRoom: element,
                        deviceX: deviceSize.width - 100,
                        minDY: 150,
                        maxDY: deviceSize.width - 150,
                      ));
                    });
                    return Stack(
                      children: stackItems,
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: Stack(
                children: [
                  Center(
                    child: IconButton(
                      iconSize: 56,
                      // 크기때문에 아이콘 버튼보다는 container 로 감싸는게 나은듯?
                      icon: Image.asset(_sendMsgIconPath),
                      onPressed: () {
                        final myAuthState =
                            Provider.of<AuthProvider>(context, listen: false)
                                .authState;
                        if (myAuthState == AuthState.authorizations)
                          Navigator.pushNamed(context, '/chat_send_page');
                        else
                          showToast('서비스가 제한되어 사용이 불가능합니다.');
                      },
                    ),
                  ),
                  Positioned(
                    right: 4,
                    bottom: 0,
                    child: IconButton(
                      iconSize: 40,
                      // 크기때문에 아이콘 버튼보다는 container 로 감싸는게 나은듯?
                      icon: Image.asset(_chatListIconPath),
                      onPressed: () {
                        Navigator.pushNamed(context, '/chat_list_page');
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
