import 'package:anony_chat/ui/widget/bottom_button.dart';
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
    final Size size = MediaQuery.of(context).size;
    final guidanceText = '학생증인증 안내 텍스트\n\n\n\n\n\n\n\n\n\n\n\n\n\n\ 스크롤테스트';
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context)),
          centerTitle: true,
          title: Text('학생증인증하기', style: TextStyle(color: Colors.white))),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(children: [
              SizedBox(height: 40.0),
              Container(
                padding: EdgeInsets.all(8.0),
                width: 320.0,
                height: 200.0,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black26)),
                child: Center(
                    child: SingleChildScrollView(child: Text(guidanceText))),
              ),
              SizedBox(height: 20.0),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('학교', style: TextStyle(fontSize: 24.0)),
                    Container(
                      width: 200.0,
                      child: TextField(
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            isDense: true,
                            border: OutlineInputBorder(),
                            hintText: '학교 입력'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('학번', style: TextStyle(fontSize: 24.0)),
                    Container(
                      width: 200.0,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            isDense: true,
                            border: OutlineInputBorder(),
                            hintText: '학번 입력'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                child: ButtonTheme(
                  buttonColor: Colors.amberAccent,
                  child: RaisedButton(
                      child: Text('학생증 업로드', style: TextStyle(fontSize: 24.0)),
                      onPressed: () {
                        // Todo 파일 선택
                      }),
                ),
              ),
            ]),
            SizedBox(height: 72.0),
            BottomButton(
                onPressed: () {
                  // TODO 인증데이터 콜백
                },
                text: '인증하기'),
            SizedBox(height: size.height * 0.05)
          ],
        ),
      ),
    );
  }
}
