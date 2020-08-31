import 'package:anony_chat/style/style.dart';
import 'package:flutter/material.dart';

class SCCertification extends StatefulWidget {
  @override
  _SCCertificationState createState() => _SCCertificationState();
}

class _SCCertificationState extends State<SCCertification> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          '학생증인증하기',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.amber[700],
      ),
      backgroundColor: Colors.amber,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(children: [
                SizedBox(height: 40.0),
                Container(
                  padding: EdgeInsets.all(8.0),
                  width: 320.0,
                  height: 200.0,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54, width: 1.0),
                      color: Colors.white),
                  child: Center(child: Text('학생증인증 안내 텍스트')),
                ),
                SizedBox(height: 40.0),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('학교',
                          style:
                              TextStyle(fontSize: 24.0, color: Colors.white)),
                      Container(
                        width: 200.0,
                        child: TextField(
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                isDense: true,
                                border: InputBorder.none,
                                hintText: '학교 입력')),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('학번',
                          style:
                              TextStyle(fontSize: 24.0, color: Colors.white)),
                      Container(
                        width: 200.0,
                        child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                isDense: true,
                                border: InputBorder.none,
                                hintText: '학번 입력')),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  child: ButtonTheme(
                    minWidth: 240.0,
                    buttonColor: Colors.amberAccent,
                    child: RaisedButton(
                        child:
                            Text('학생증 업로드', style: TextStyle(fontSize: 20.0)),
                        onPressed: () {
                          // Todo 파일 선택
                        }),
                  ),
                ),
                SizedBox(height: 72.0),
                Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.0),
                    child: ButtonTheme(
                      minWidth: double.infinity,
                      height: 50.0,
                      buttonColor: Colors.amberAccent,
                      child: RaisedButton(
                          child: Text('인증하기', style: TextStyle(fontSize: 28)),
                          onPressed: () {
                            // TODO 인증된 데이터 콜백
                          }),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
