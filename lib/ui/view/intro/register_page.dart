import 'package:anony_chat/model/dao/member.dart';
import 'package:anony_chat/model/member_model.dart';
import 'package:anony_chat/provider/register_state_provider.dart';
import 'package:anony_chat/ui/view/intro/student_card_certification_page.dart';
import 'package:anony_chat/ui/widget/bottom_button.dart';
import 'package:anony_chat/ui/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  MemberModel _memberModel;
  Member newMember = Member();

  List<MyDropDownMenuItem> _items = [];

  // true#남자 false#여자
  bool sexBtnColor = true;

  // 회원가입 요청시 데이터 처리 로딩
  bool loading = false;

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
    _items.add(MyDropDownMenuItem('태어난해', _itemsBirth));
    _items.add(MyDropDownMenuItem('지역', _itemsRegion));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return loading
        ? Loading()
        : SafeArea(
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
                              child:
                                  Text('남자', style: TextStyle(fontSize: 20.0)),
                              onPressed: () {
                                newMember.sex = '남자';
                                setState(() => sexBtnColor = true);
                              },
                              color: sexBtnColor
                                  ? Colors.amberAccent
                                  : Colors.black26,
                            ),
                          ),
                          SizedBox(width: 24.0),
                          ButtonTheme(
                            minWidth: 120.0,
                            height: 50.0,
                            child: FlatButton(
                              child:
                                  Text('여자', style: TextStyle(fontSize: 20.0)),
                              onPressed: () {
                                newMember.sex = '여자';
                                setState(() => sexBtnColor = false);
                              },
                              color: !sexBtnColor
                                  ? Colors.amberAccent
                                  : Colors.black26,
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
                            _buildDropDownButton(_items[0]),
                            SizedBox(height: 16.0),
                            _buildDropDownButton(_items[1])
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
                            child: Text('학생증인증하기',
                                style: TextStyle(fontSize: 24.0)),
                            onPressed:
                                Provider.of<RegisterStateProvider>(context)
                                        .stdCardCertification
                                    ? null
                                    : () =>
                                        _navigateStdCardCertification(context)),
                      ),
                      SizedBox(height: 8.0),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('같은 대학교 학생 안만나기',
                                style: TextStyle(fontSize: 18.0)),
                            SizedBox(width: 8.0),
                            Container(
                                child: Switch(
                                    value: newMember.isNotMeetingSameUniversity,
                                    onChanged: (value) => setState(() =>
                                        newMember.isNotMeetingSameUniversity =
                                            value))),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('전화번호 목록 친구 안만나기',
                                style: TextStyle(fontSize: 18.0)),
                            SizedBox(width: 8.0),
                            Container(
                              child: Switch(
                                  value: newMember.isNotMeetingPhoneList,
                                  onChanged: (value) => setState(() =>
                                      newMember.isNotMeetingPhoneList = value)),
                            ),
                          ]),
                    ],
                  ),
                  SizedBox(height: 24.0),
                  BottomButton(
                      onPressed: Provider.of<RegisterStateProvider>(context).authState ==
                              AuthState.canRegister
                          ? () => {_registerAndLogin()}
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
      newMember.university = result[0];
      newMember.studentID = int.parse(result[1]);
      // newUser.studentCardImage=
      // result[2]에 File의 형태로 학생증 이미지 넘어옴
    }
  }

  Widget _buildDropDownButton(MyDropDownMenuItem item) {
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
            setState(() => item.selected = value);
            _setDropDownValue(item.title, value);
          },
        ),
      ),
    );
  }

  void _setDropDownValue(String title, value) {
    switch (title) {
      case '지역':
        newMember.region = value;
        break;
      case '태어난해':
        newMember.birthYear = value;
        break;
      default:
        throw Exception('set drop_down_value error');
        break;
    }
  }

  Future<void> _registerAndLogin() async {
    if (newMember.region == '선택' || newMember.university == '선택') {
      Fluttertoast.showToast(
          msg: '공란을 채워주세요.',
          backgroundColor: Colors.black,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER);
      return;
    }
    setState(() => loading = true);
    _memberModel = MemberModel();
    await _memberModel.register(newMember).whenComplete(() =>
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/main', (route) => false));
  }

// TODO 시간나면 고치기
// 학생증 인증하고나서 버튼을 누르면 아래의 오류가 뜨는데 왜뜨는지 모르겠음
// A RenderFlex overflowed by 159 pixels on the bottom.
}
