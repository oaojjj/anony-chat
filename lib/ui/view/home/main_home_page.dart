import 'package:anony_chat/model/member_info_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int n = 5;
  int nn = 1;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                leading: Icon(Icons.account_circle, size: 28.0),
                title: Text('내 프로필', style: TextStyle(fontSize: 20.0)),
                onTap: () => {Navigator.pushNamed(context, '/profile')},
              ),
              ListTile(
                leading: Icon(Icons.report, size: 28.0),
                title: Text('신고 내역', style: TextStyle(fontSize: 20.0)),
                onTap: () {
                },
              ),
              ListTile(
                leading: Icon(Icons.store, size: 28.0),
                title: Text('아이템 상점', style: TextStyle(fontSize: 20.0)),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.settings, size: 28.0),
                title: Text('서비스 정보', style: TextStyle(fontSize: 20.0)),
                onTap: () {},
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('보낼수 있는 메세지: $n개'),
          centerTitle: true,
          elevation: 0.0,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: ButtonTheme(
                  buttonColor: Colors.amberAccent,
                  minWidth: 72.0,
                  child: RaisedButton(
                      child: Text('광고+1',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      onPressed: () {}),
                ),
              ),
            ),
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: RaisedButton(
                        child: Text('로그아웃'),
                        onPressed: () => FirebaseAuth.instance.signOut()),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ButtonTheme(
                        height: 50.0,
                        minWidth: 50.0,
                        child:
                            RaisedButton(child: Text('목록'), onPressed: () {})),
                    ButtonTheme(
                        height: 50.0,
                        minWidth: 250.0,
                        child:
                            RaisedButton(child: Text('보내기'), onPressed: () {}))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
