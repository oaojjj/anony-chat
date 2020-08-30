import 'package:anony_chat/model/member.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class MyDropDownMenuItem {
  List<String> list;
  String selected;

  MyDropDownMenuItem(this.list) {
    selected = list[0];
  }
}

class _RegisterPageState extends State<RegisterPage> {
  Member newMember;

  // #true남자, #false여자
  bool sexBtnColor;
  bool isCanRegister;

  // data
  List<MyDropDownMenuItem> _items = [];
  List<String> _itemsBirth =
      List<String>.generate(30, (i) => (i + 1970).toString() + '년생');
  List<String> _itemsRegion = ['대구', '부산', '서울'];

  @override
  void initState() {
    newMember = Member();
    isCanRegister = false;
    sexBtnColor = true;

    _items.add(MyDropDownMenuItem(_itemsBirth));
    _items.add(MyDropDownMenuItem(_itemsRegion));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.amber[700],
        centerTitle: true,
        title: Text(
          '회원정보입력',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.amber,
      body: Column(
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.all(8.0),
              color: Colors.amberAccent[100],
              height: 70.0,
              width: double.infinity,
              child: Text(
                '회원정보는 설정에서\n 언제든 변경가능합니다.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Container(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonTheme(
                    shape: sexBtnColor
                        ? RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0))
                        : null,
                    minWidth: 120.0,
                    height: 50.0,
                    child: FlatButton(
                      child: Text('남자', style: TextStyle(fontSize: 20.0)),
                      onPressed: () {
                        setState(() {
                          sexBtnColor = true;
                        });
                        newMember.sex = '남자';
                      },
                      color: sexBtnColor ? Colors.amberAccent : Colors.black26,
                      textColor: Colors.black,
                    ),
                  ),
                  SizedBox(width: 24.0),
                  ButtonTheme(
                    shape: sexBtnColor
                        ? null
                        : RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0)),
                    minWidth: 120.0,
                    height: 50.0,
                    child: FlatButton(
                      child: Text('여자', style: TextStyle(fontSize: 20.0)),
                      onPressed: () {
                        setState(() {
                          sexBtnColor = false;
                        });
                        newMember.sex = '여자';
                      },
                      color: sexBtnColor ? Colors.black26 : Colors.amberAccent,
                      textColor: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Expanded(
            child: Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text('태어난 해',
                              style: TextStyle(
                                  fontSize: 24.0, color: Colors.white)),
                          SizedBox(height: 16.0),
                          Text('지역',
                              style: TextStyle(
                                  fontSize: 24.0, color: Colors.white))
                        ],
                      ),
                      Column(
                        children: [
                          // 객체 자체를 참조해야 setState 에서 참조 가능해서 변경
                          createDropDownButton(_items[0]),
                          SizedBox(height: 16.0),
                          createDropDownButton(_items[1]),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 60.0),
                  ButtonTheme(
                    buttonColor: Colors.amberAccent,
                    minWidth: 240.0,
                    height: 40.0,
                    child: RaisedButton(
                        child:
                            Text('학생증인증하기', style: TextStyle(fontSize: 24.0)),
                        onPressed: () {
                          // TODO 학생증 인증 페이지
                        }),
                  ),
                  SizedBox(height: 8.0),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text('같은 대학교 학생 안만나기',
                        style: TextStyle(fontSize: 20.0, color: Colors.white)),
                    SizedBox(width: 16.0),
                    Container(
                      width: 60.0,
                      child: Switch(
                          activeColor: Colors.white,
                          value: newMember.isNotMeetingSameUniversity,
                          onChanged: (value) {
                            setState(() {
                              newMember.isNotMeetingSameUniversity = value;
                            });
                          }),
                    )
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text('전화번호 목록 친구 안만나기',
                        style: TextStyle(fontSize: 20.0, color: Colors.white)),
                    SizedBox(width: 16.0),
                    Container(
                      width: 60.0,
                      child: Switch(
                          activeColor: Colors.white,
                          value: newMember.isNotMeetingPhoneList,
                          onChanged: (value) {
                            setState(() {
                              newMember.isNotMeetingPhoneList = value;
                            });
                          }),
                    )
                  ]),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 24.0),
            child: ButtonTheme(
              minWidth: 160.0,
              height: 40.0,
              buttonColor: Colors.amberAccent,
              child: RaisedButton(
                  child: Text(
                    '가입하기',
                    style: TextStyle(fontSize: 24.0),
                  ),
                  onPressed: !isCanRegister
                      ? () => {
                            // TODO 가입하기 버튼
                          }
                      : null),
            ),
          )
        ],
      ),
    );
  }

  Widget createDropDownButton(MyDropDownMenuItem item) {
    return Container(
      height: 40.0,
      width: 100.0,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: Center(
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
              value: item.selected,
              items: item.list.map<DropdownMenuItem<String>>((value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newItem) {
                setState(() {
                  item.selected = newItem;
                });
              }),
        ),
      ),
    );
  }
}
