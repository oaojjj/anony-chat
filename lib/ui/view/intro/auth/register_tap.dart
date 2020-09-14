import 'dart:io';

import 'package:anony_chat/model/dao/member.dart';
import 'package:anony_chat/model/member_model.dart';
import 'package:anony_chat/ui/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'student_card_certification_tap.dart';

class MyDropDownMenuItem {
  List<String> list;
  String title;
  String selected;

  MyDropDownMenuItem(this.title, this.list) {
    selected = list[0];
  }
}

class RegisterTap extends StatefulWidget {
  @override
  _RegisterTapState createState() => _RegisterTapState();
}

class _RegisterTapState extends State<RegisterTap> {
  MemberModel _memberModel = MemberModel();
  Member newMember = Member();

  List<MyDropDownMenuItem> _items = [];

  File _stdCardImage;

  // true#남성 false#여성
  bool sexBtnColor = true;
  bool loading = false;

  // test data
  List<String> _itemsBirth = List<String>.generate(30, (i) {
    if (i == 0)
      return '선택';
    else
      return (i + 1970).toString();
  });

  List<String> _itemsRegion = [
    '선택',
    '서울',
    '부산',
    '대구',
    '인천',
    '광주',
    '대전',
    '울산',
    '세종',
    '경기',
    '강원',
    '충북',
    '충남',
    '전북',
    '전남',
    '경북',
    '경남',
    '제주',
  ];

  @override
  void initState() {
    _items.add(MyDropDownMenuItem('태어난해', _itemsBirth));
    _items.add(MyDropDownMenuItem('지역', _itemsRegion));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Container(
            height: 300,
            child: Column(
              children: [
                Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Align(
                          child: Text('성별', style: TextStyle(fontSize: 18)),
                          alignment: Alignment.centerLeft,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: RaisedButton(
                                child: Text('남성',
                                    style: TextStyle(
                                        fontSize: 20.0, color: Colors.white)),
                                onPressed: () {
                                  newMember.sex = '남성';
                                  setState(() => sexBtnColor = true);
                                },
                                color:
                                    sexBtnColor ? Colors.indigo : Colors.grey,
                              ),
                            ),
                            SizedBox(width: 8),
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: RaisedButton(
                                child: Text('여성',
                                    style: TextStyle(
                                        fontSize: 20.0, color: Colors.white)),
                                onPressed: () {
                                  newMember.sex = '여성';
                                  setState(() => sexBtnColor = false);
                                },
                                color:
                                    !sexBtnColor ? Colors.indigo : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Text('태어난 해',
                                    style: TextStyle(fontSize: 18.0))),
                            Flexible(
                                flex: 2,
                                fit: FlexFit.tight,
                                child: _buildDropDownButton(_items[0])),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Text('지역',
                                    style: TextStyle(fontSize: 18.0))),
                            Flexible(
                                flex: 2,
                                fit: FlexFit.tight,
                                child: _buildDropDownButton(_items[1])),
                          ],
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.error),
                    SizedBox(width: 4),
                    Text('회원 정보는 설정에서 언제든 변경 가능합니다.',style: TextStyle(fontSize: 15))
                  ],
                )
              ],
            ),
          );
  }

  _navigateStdCardCertification(BuildContext context) async {
    List<dynamic> result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => SCCertificationTap()));

    print(result);

    // result != null => 인증에 성공한 경우
    if (result != null) {
      newMember.university = result[0];
      newMember.studentID = int.parse(result[1]);
      _stdCardImage = result[2];
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
            return DropdownMenuItem(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(value),
                ));
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
    // 예외 처리를 뷰에서 해주는게 맞나?
    if ((newMember.region == '선택' || newMember.region == null) ||
        (newMember.university == '선택' || newMember.university == null)) {
      Fluttertoast.showToast(
          fontSize: 20.0,
          textColor: Colors.black,
          msg: '공란을 채워주세요.',
          backgroundColor: Colors.white,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER);
      return;
    }

    // 최종 가입을 할 수 있는 상태
    setState(() => loading = true);
    await _memberModel
        .register(newMember, _stdCardImage)
        .whenComplete(() => Navigator.of(context)
            .pushNamedAndRemoveUntil('/main', (route) => false))
        .catchError((onError) {
      print('register error');
    });
  }

// TODO 시간나면 고치기
// 학생증 인증하고나서 버튼을 누르면 아래의 오류가 뜨는데 왜뜨는지 모르겠음
// A RenderFlex overflowed by 159 pixels on the bottom.
}
