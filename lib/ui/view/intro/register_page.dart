import 'package:anony_chat/model/member.dart';
import 'package:anony_chat/ui/view/student_card_certification_page.dart';
import 'package:anony_chat/ui/widget/bottom_button.dart';
import 'package:flutter/material.dart';

class MyDropDownMenuItem {
  List<String> list;
  String title;
  String selected;

  MyDropDownMenuItem(this.title, this.list) {
    selected = list[0];
  }
}

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Member newMember;

  // #true남자, #false여자
  bool sexBtnColor;
  bool stdCardCertification;

  // test data
  List<MyDropDownMenuItem> _items = [];
  List<String> _itemsBirth = List<String>.generate(30, (i) {
    if (i == 0)
      return '선택';
    else
      return (i + 1970).toString();
  });
  List<String> _itemsRegion = ['선택', '대구', '부산', '서울'];

  @override
  void initState() {
    newMember = Member();
    sexBtnColor = true;
    stdCardCertification = false;
    _items.add(MyDropDownMenuItem('태어난해', _itemsBirth));
    _items.add(MyDropDownMenuItem('지역', _itemsRegion));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          '회원정보입력',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.amberAccent[100],
            height: 70.0,
            width: double.infinity,
            child: Center(
              child: Text(
                '회원정보는 설정에서\n 언제든 변경가능합니다.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
          SizedBox(height: 32.0),
          Container(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonTheme(
                    minWidth: 120.0,
                    height: 50.0,
                    child: FlatButton(
                      child: Text('남자', style: TextStyle(fontSize: 20.0)),
                      onPressed: () {
                        newMember.sex = '남자';
                        setState(() {
                          sexBtnColor = true;
                        });
                      },
                      color: sexBtnColor ? Colors.amberAccent : Colors.black26,
                    ),
                  ),
                  SizedBox(width: 24.0),
                  ButtonTheme(
                    minWidth: 120.0,
                    height: 50.0,
                    child: FlatButton(
                      child: Text('여자', style: TextStyle(fontSize: 20.0)),
                      onPressed: () {
                        newMember.sex = '여자';
                        setState(() {
                          sexBtnColor = false;
                        });
                      },
                      color: !sexBtnColor ? Colors.amberAccent : Colors.black26,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24.0),
          Expanded(
            child: Center(
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(children: [
                          Text('태어난 해', style: TextStyle(fontSize: 24.0)),
                          SizedBox(height: 16.0),
                          Text('지역', style: TextStyle(fontSize: 24.0))
                        ]),
                        Column(children: [
                          // 객체 자체를 참조해야 setState 에서 참조 가능해서 변경
                          _createDropDownButton(_items[0]),
                          SizedBox(height: 16.0),
                          _createDropDownButton(_items[1])
                        ])
                      ]),
                  SizedBox(height: 80.0),
                  ButtonTheme(
                      buttonColor: Colors.amberAccent,
                      minWidth: 200.0,
                      child: RaisedButton(
                          child:
                              Text('학생증인증하기', style: TextStyle(fontSize: 24.0)),
                          onPressed: stdCardCertification
                              ? null
                              : () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SCCertification()));
                                })),
                  SizedBox(height: 8.0),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text('같은 대학교 학생 안만나기', style: TextStyle(fontSize: 18.0)),
                    SizedBox(width: 8.0),
                    Container(
                        child: Switch(
                            value: newMember.isNotMeetingSameUniversity,
                            onChanged: (value) {
                              setState(() {
                                newMember.isNotMeetingSameUniversity = value;
                              });
                            }))
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text('전화번호 목록 친구 안만나기', style: TextStyle(fontSize: 18.0)),
                    SizedBox(width: 8.0),
                    Container(
                      child: Switch(
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
          BottomButton(
              onPressed: isCanRegister() ? () => {
                        // TODO 가입하기 버튼
                      } : null,
              text: '가입하기'),
          SizedBox(height: size.height * 0.05),
        ],
      ),
    );
  }

  Widget _createDropDownButton(MyDropDownMenuItem item) {
    return Container(
      height: 40.0,
      width: 100.0,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(4.0))),
      child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
              value: item.selected,
              items: item.list.map<DropdownMenuItem<String>>((value) {
                return DropdownMenuItem(value: value, child: Text(value));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  item.selected = value;
                });
                item.title == '지역'
                    ? newMember.birthYear = value
                    : newMember.region = value;
              })),
    );
  }

  bool isCanRegister() {
    if (newMember.birthYear == '선택' || newMember.region == '선택') return false;
    if (stdCardCertification != true) return false;
    return true;
  }
}
