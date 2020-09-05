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
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ButtonTheme(
                        height: 50.0,
                        minWidth: 100.0,
                        child:
                            RaisedButton(child: Text('메뉴'), onPressed: () {})),
                    Stack(
                      textDirection: TextDirection.ltr,
                      children: [
                        // 글씨를 도저히 왼쪽으로 못보내겠음
                        ButtonTheme(
                          height: 50.0,
                          minWidth: 250.0,
                            child: RaisedButton(
                            onPressed: () {},
                            child: Text('보낼 수 있는 메시지: $n개',
                                textAlign: TextAlign.left),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: Material(
                            child: InkWell(
                              onTap: () {},
                              child: Text('광고+$nn'),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
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
                        minWidth: 100.0,
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
