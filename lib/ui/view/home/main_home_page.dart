import 'package:anony_chat/ui/view/chat/chat_list_page.dart';
import 'package:anony_chat/ui/view/chat/chat_send_page.dart';
import 'package:anony_chat/ui/widget/home/home_page.dart';
import 'package:anony_chat/ui/widget/home/notification_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> _navigationPage = [
    HomePage(),
    ChatListPage(),
    Container(),
    NotificationPage()
  ];

  int _selectedBottom = 0;

  void _onItemTapped(int index) {
    setState(() => _selectedBottom = index);
    if (_selectedBottom == 2) {
      Navigator.pushNamed(context, '/chat_send');
      _selectedBottom = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _navigationPage[_selectedBottom],
        bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('홈')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.chat), title: Text('채팅')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.send), title: Text('보내기')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.notifications), title: Text('알림')),
            ],
            currentIndex: _selectedBottom,
            onTap: _onItemTapped,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey),
      ),
    );
  }
}
