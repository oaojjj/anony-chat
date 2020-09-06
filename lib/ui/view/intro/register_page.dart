import 'package:anony_chat/model/dao/user.dart' as my;
import 'package:anony_chat/provider/register_state_provider.dart';
import 'package:anony_chat/ui/view/intro/student_card_certification_page.dart';
import 'package:anony_chat/ui/widget/bottom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  my.User newUser;

  // #true남자, #false여자
  bool sexBtnColor;
  List<MyDropDownMenuItem> _items = [];

  // test data
  List<String> _itemsBirth = List<String>.generate(30, (i) {
    if (i == 0)
      return '선택';
    else
      return (i + 1970).toString();
  });
  List<String> _itemsRegion = ['선택', '대구', '부산', '서울'];

  @override
  void initState() {
    newUser = my.User();
    sexBtnColor = true;
    _items.add(MyDropDownMenuItem('태어난해', _itemsBirth));
    _items.add(MyDropDownMenuItem('지역', _itemsRegion));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          title: Text(
            '회원정보입력',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
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
            SizedBox(height: 24.0),
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
                          newUser.sex = '남자';
                          setState(() => sexBtnColor = true);
                        },
                        color:
                            sexBtnColor ? Colors.amberAccent : Colors.black26,
                      ),
                    ),
                    SizedBox(width: 24.0),
                    ButtonTheme(
                      minWidth: 120.0,
                      height: 50.0,
                      child: FlatButton(
                        child: Text('여자', style: TextStyle(fontSize: 20.0)),
                        onPressed: () {
                          newUser.sex = '여자';
                          setState(() => sexBtnColor = false);
                        },
                        color:
                            !sexBtnColor ? Colors.amberAccent : Colors.black26,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24.0),
            Column(
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
                  ],
                ),
              ],
            ),
            Spacer(),
            Column(
              children: [
                ButtonTheme(
                  minWidth: 200.0,
                  child: RaisedButton(
                      color: Colors.amberAccent,
                      child: Text('학생증인증하기', style: TextStyle(fontSize: 24.0)),
                      onPressed: Provider.of<RegisterStateProvider>(context)
                              .stdCardCertification
                          ? null
                          : () => _navigateStdCardCertification(context)),
                ),
                SizedBox(height: 8.0),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text('같은 대학교 학생 안만나기', style: TextStyle(fontSize: 18.0)),
                  SizedBox(width: 8.0),
                  Container(
                      child: Switch(
                          value: newUser.isNotMeetingSameUniversity,
                          onChanged: (value) {
                            setState(() =>
                                newUser.isNotMeetingSameUniversity = value);
                          }))
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text('전화번호 목록 친구 안만나기', style: TextStyle(fontSize: 18.0)),
                  SizedBox(width: 8.0),
                  Container(
                    child: Switch(
                        value: newUser.isNotMeetingPhoneList,
                        onChanged: (value) {
                          setState(() => newUser.isNotMeetingPhoneList = value);
                        }),
                  )
                ]),
              ],
            ),
            SizedBox(height: 24.0),
            BottomButton(
                onPressed:
                    Provider.of<RegisterStateProvider>(context).authState ==
                            AuthState.canRegister
                        ? () => { _registerAndLogin()}
                        : null,
                text: '가입하기'),
            SizedBox(height: size.height * 0.05),
          ],
        ),
      ),
    );
  }

  _navigateStdCardCertification(BuildContext context) async {
    List<dynamic> result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => SCCertification()));

    print(result);

    // result!=null => 인증에 성공한 경우
    if (result != null) {
      Provider.of<RegisterStateProvider>(context, listen: false)
          .successCertification();
      newUser.university = result[0];
      newUser.studentID = int.parse(result[1]);
      // newUser.studentCardImage=
      // result[2]에 File의 형태로 학생증 이미지 넘어옴

      // TODO 가입 로직 짜기
      // 가입(newUser);
    }
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
            _setDropDownValue(item.title, value);
          },
        ),
      ),
    );
  }

  void _setDropDownValue(String title, value) {
    switch (title) {
      case '지역':
        newUser.region = value;
        break;
      case '태어난해':
        newUser.birthYear = value;
        break;
      default:
        break;
    }
  }

  Future<void> _registerAndLogin() async {
    await FirebaseAuth.instance.signInAnonymously();
    Navigator.of(context).pushNamedAndRemoveUntil('/main', (route) => false);
  }
}
