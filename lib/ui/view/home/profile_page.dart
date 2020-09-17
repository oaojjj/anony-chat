import 'package:anony_chat/database/shared_preferences_controller.dart';
import 'package:anony_chat/model/dao/member.dart';
import 'package:anony_chat/provider/student_card_authorization_provider.dart';
import 'package:anony_chat/ui/widget/bottom_button.dart';
import 'package:anony_chat/viewmodel/member_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String _profileIconPath = 'assets/icons/profile2.png';
  MemberModel _memberModel = MemberModel();
  Member _member;
  Member _fixProfile;

  // true#남성 false#여성
  bool sexBtnColor = true;
  bool loading = true;

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

  bool _fixColor = false;

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _fixColor = !(_member == _fixProfile);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('프로필'), centerTitle: true),
        body: _profileForm(_fixProfile),
      ),
    );
  }

  Widget _profileForm(Member member) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 4),
          child: Container(
              width: 30, height: 30, child: Image.asset('$_profileIconPath')),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 4.0, horizontal: 24.0),
            child: Text('회원번호 ${member.id}',
                style: TextStyle(color: Colors.white)),
          ),
        ),
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Align(
                    child: Text('성별', style: TextStyle(fontSize: 16)),
                    alignment: Alignment.centerLeft,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: RaisedButton(
                          child: Text('남자',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white)),
                          onPressed: () {
                            member.sex = '남자';
                            setState(() => sexBtnColor = true);
                          },
                          color: sexBtnColor ? Colors.indigo : Colors.grey,
                        ),
                      ),
                      SizedBox(width: 8),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: RaisedButton(
                          child: Text('여자',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white)),
                          onPressed: () {
                            member.sex = '여자';
                            setState(() => sexBtnColor = false);
                          },
                          color: !sexBtnColor ? Colors.indigo : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child:
                              Text('태어난 해', style: TextStyle(fontSize: 16.0))),
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: GestureDetector(
                          onTap: () => showPicker(context, _itemsBirth),
                          child: Container(
                            height: 40.0,
                            width: 100.0,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.black, width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0))),
                            child: Row(
                              children: [
                                Flexible(
                                    fit: FlexFit.tight,
                                    flex: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(member.birthYear == null
                                          ? "선택"
                                          : member.birthYear.toString()),
                                    )),
                                Flexible(
                                    fit: FlexFit.tight,
                                    flex: 1,
                                    child: Icon(Icons.arrow_drop_down))
                              ],
                            ),
                          ),
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
                          child: Text('지역', style: TextStyle(fontSize: 16.0))),
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: GestureDetector(
                          onTap: () {
                            showPicker(context, _itemsRegion);
                          },
                          child: Container(
                            height: 40.0,
                            width: 100.0,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.black, width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0))),
                            child: Row(
                              children: [
                                Flexible(
                                    fit: FlexFit.tight,
                                    flex: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(member.region == null
                                          ? "선택"
                                          : member.region),
                                    )),
                                Flexible(
                                    fit: FlexFit.tight,
                                    flex: 1,
                                    child: Icon(Icons.arrow_drop_down))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
          child: Consumer<SCAuthorizationProvider>(
            builder: (_, sca, __) => Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 1,
                          child: Center(
                            child: Text('학교', style: getStateTextStyle(sca)),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 1,
                          child: Center(
                            child: Text('${member.university}',
                                style: getStateTextStyle(sca)),
                          ),
                        ),
                        Flexible(
                            fit: FlexFit.tight,
                            flex: 1,
                            child: Text(sca.authorizationStateString()))
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 1,
                          child: Center(
                            child: Text('학과', style: getStateTextStyle(sca)),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 1,
                          child: Center(
                            child: Text('${member.major}',
                                style: getStateTextStyle(sca)),
                          ),
                        ),
                        Flexible(
                            fit: FlexFit.tight, flex: 1, child: Container()),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 1,
                          child: Center(
                            child: Text('학번', style: getStateTextStyle(sca)),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 1,
                          child: Center(
                            child: Text('${member.studentID}',
                                style: getStateTextStyle(sca)),
                          ),
                        ),
                        Flexible(
                            fit: FlexFit.tight, flex: 1, child: Container()),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32.0),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Text('같은 학교 학생 안만나기',
                          style: TextStyle(fontSize: 16.0))),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.loose,
                    child: Container(
                      height: 30,
                      child: Switch(
                        value: member.isNotMeetingSameUniversity,
                        onChanged: (value) => setState(
                            () => member.isNotMeetingSameUniversity = value),
                      ),
                    ),
                  ),
                  Flexible(flex: 1, fit: FlexFit.tight, child: Container()),
                ],
              ),
              Row(
                children: [
                  Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Text('같은 학과 학생 안만나기',
                          style: TextStyle(fontSize: 16.0))),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.loose,
                    child: Container(
                      height: 30,
                      child: Switch(
                        value: member.isNotMeetingSameMajor,
                        onChanged: (value) => setState(
                            () => member.isNotMeetingSameMajor = value),
                      ),
                    ),
                  ),
                  Flexible(flex: 1, fit: FlexFit.tight, child: Container()),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: BottomButton(
            text: '수정',
            onPressed: () {},
          ),
        )
      ],
    );
  }

  TextStyle getStateTextStyle(SCAuthorizationProvider sca) {
    return TextStyle(
        fontSize: 16,
        color: sca.scaState == SCAState.authorizations
            ? Colors.black
            : Colors.grey);
  }

  // TODO 수정 성공시 토스트메시지 띄우기
  _fetchData() async {
    _member = await SPController.loadProfile();
    _fixProfile = Member.fromJson(_member.toJson());
    _initUI();
    setState(() => loading = false);
  }

  _initUI() {
    sexBtnColor = _member.sex == '남성';
  }

  showPicker(
    context,
    List<String> item,
  ) {
    return showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 300,
            color: Colors.white,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: CupertinoPicker.builder(
                  itemExtent: 50,
                  childCount: item.length,
                  diameterRatio: 10,
                  squeeze: 1,
                  backgroundColor: Colors.grey[100],
                  onSelectedItemChanged: (index) {
//                    setState(() {
//                      item == _itemsBirth
//                          ? member.birthYear = item[index] == '선택'
//                              ? null
//                              : int.parse(item[index])
//                          : member.region = item[index];
//                    });
                  },
                  itemBuilder: (_, index) => Center(
                    child: Text(item[index],
                        style: TextStyle(color: Colors.black)),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
