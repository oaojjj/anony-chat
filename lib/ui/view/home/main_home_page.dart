import 'package:anony_chat/ui/view/chat/chat_list_page.dart';
import 'package:anony_chat/ui/widget/home/home_drawer.dart';
import 'package:anony_chat/ui/widget/home/home_page.dart';
import 'package:anony_chat/ui/widget/home/notification_page.dart';
import 'package:anony_chat/viewmodel/member_model.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final String _messageCountImagePath = 'assets/icons/message_count.png';
  final String _menuImagePath = 'assets/icons/menu.png';
  final String _adImagePath = 'assets/icons/adPlusChat.png';

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
                    icon: Image.asset('$_menuImagePath'),
                    onPressed: () => _scaffoldKey.currentState.openDrawer(),
                  ),
                ),
                Row(
                  children: [
                    Container(
                        height: 25,
                        child: Image.asset('$_messageCountImagePath')),
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
                        }),
                    SizedBox(width: 16),
                    Container(
                      width: 60,
                      child: IconButton(
                        icon: Image.asset('$_adImagePath'),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
