import 'package:anony_chat/ui/widget/home_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

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
        drawer: HomeDrawer(),
        appBar: AppBar(
          title: Text('남은 메세지: $n개', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          elevation: 0.0,
          iconTheme: new IconThemeData(color: Colors.white),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: ButtonTheme(
                  buttonColor: Colors.white,
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
          color: Colors.black87,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Center(
                  child: Container(
                      width: 64.0,
                      height: 64.0,
                      child: InkWell(
                        child: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/moon.png')),
                        onTap: () => Navigator.pushNamed(context, '/chat'),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        width: 64.0,
                        child: ButtonTheme(
                            buttonColor: Colors.amberAccent,
                            child: RaisedButton(
                                child: Text('목록'),
                                onPressed: () =>
                                    Navigator.pushNamed(context, '/chat_list'))),
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      fit: FlexFit.tight,
                      child: ButtonTheme(
                          buttonColor: Colors.amberAccent,
                          child: RaisedButton(
                              child: Text('보내기'), onPressed: () {})),
                    )
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
