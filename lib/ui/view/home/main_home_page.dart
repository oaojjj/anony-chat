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
        drawer: Container(
          width: 240.0,
          child: Drawer(
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.account_circle, size: 28.0),
                  title: Text('내 프로필', style: TextStyle(fontSize: 20.0)),
                  dense: true,
                  onTap: () => Navigator.pushNamed(context, '/profile'),
                ),
                ListTile(
                  leading: Icon(Icons.report, size: 28.0),
                  title: Text('신고 내역', style: TextStyle(fontSize: 20.0)),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.store, size: 28.0),
                  title: Text('아이템 상점', style: TextStyle(fontSize: 20.0)),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.settings, size: 28.0),
                  title: Text('서비스 정보', style: TextStyle(fontSize: 20.0)),
                  onTap: () => Navigator.pushNamed(context, '/serviceInfo'),
                )
              ],
            ),
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
                  buttonColor: Colors.white30,
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
                child: Center(
                    child: FlatButton(
                        color: Colors.black26,
                        onPressed: () => Navigator.pushNamed(context, '/chat'),
                        child: Text('메시지'))),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    fit: FlexFit.loose,
                    flex: 1,
                    child: ButtonTheme(
                        child:
                            RaisedButton(child: Text('목록'), onPressed: () {})),
                  ),
                  Flexible(
                    flex: 3,
                    fit: FlexFit.tight,
                    child: ButtonTheme(
                        child:
                            RaisedButton(child: Text('보내기'), onPressed: () {})),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
