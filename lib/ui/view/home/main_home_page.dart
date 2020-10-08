import 'package:anony_chat/controller/hive_controller.dart';
import 'package:anony_chat/provider/register_provider.dart';
import 'package:anony_chat/ui/widget/home/home_drawer.dart';
import 'package:anony_chat/utils/utill.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print(HiveController.instance.getFCMToken());
    print(Provider.of<RegisterProvider>(context).member.studentID);
  }

  @override
  Widget build(BuildContext context) {
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
                        onPressed: () {
                          // TODO 광고 보기 작성
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              child: Stack(
                children: [
                  Center(
                      child: IconButton(
                          iconSize: 80,
                          icon: Image.asset('assets/icons/messageIcon3.png'),
                          onPressed: () {
                            Navigator.pushNamed(context, '/chat_page');
                          }))
                ],
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
                      onPressed: () =>
                          Navigator.pushNamed(context, '/chat_send_page'),
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
