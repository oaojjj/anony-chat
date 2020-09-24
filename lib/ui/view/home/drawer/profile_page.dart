import 'package:anony_chat/database/hive_controller.dart';
import 'package:anony_chat/model/dao/member.dart';
import 'package:anony_chat/provider/member_auth_provider.dart';
import 'package:anony_chat/ui/widget/bottom_button.dart';
import 'package:anony_chat/ui/widget/loading.dart';
import 'package:anony_chat/utils/utill.dart';
import 'package:anony_chat/viewmodel/member_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static const double CARD_SIZED_BOX_HEIGHT = 4;

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

  bool _isFix = false;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    _isFix = !(_member == _fixProfile);
    print('isFixProfile: $_isFix');
    return loading
        ? Loading()
        : SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  '프로필',
                  style: TextStyle(color: Colors.black),
                ),
                centerTitle: true,
                backgroundColor: CupertinoColors.white,
                iconTheme: IconThemeData(color: Colors.black),
              ),
              body: SingleChildScrollView(child: _profileForm(_fixProfile)),
            ),
          );
  }

  Widget _profileForm(Member member) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 4),
            child: Container(
                width: 30, height: 30, child: Image.asset('$_profileIconPath')),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text('회원번호 ${member.id}',
                  style: TextStyle(color: Colors.white, fontSize: 13)),
            ),
          ),
          SizedBox(height: CARD_SIZED_BOX_HEIGHT),
          Card(
            elevation: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('전화번호'),
                Text(member.phoneNumber),
                ButtonTheme(
                    height: 30,
                    minWidth: 70,
                    buttonColor: Colors.black,
                    child: RaisedButton(
                        child:
                            Text('변경', style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          //TODO 프로필 폰번호 변경 작성
                        }))
              ],
            ),
          ),
          SizedBox(height: CARD_SIZED_BOX_HEIGHT),
          Card(
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
                          color: sexBtnColor ? chatPrimaryColor : Colors.grey,
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
                          color: !sexBtnColor ? chatPrimaryColor : Colors.grey,
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
                            height: 40,
                            child: Card(
                              elevation: 3,
                              child: Row(
                                children: [
                                  Flexible(
                                      fit: FlexFit.tight,
                                      flex: 3,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
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
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
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
                            height: 40,
                            child: Card(
                              elevation: 3,
                              child: Row(
                                children: [
                                  Flexible(
                                      fit: FlexFit.tight,
                                      flex: 3,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
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
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: CARD_SIZED_BOX_HEIGHT),
          Consumer<MemberAuthProvider>(
            builder: (_, sca, __) => Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
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
                          flex: 2,
                          child: Center(
                            child: Text(
                              '${member.university}',
                              style: getStateTextStyle(sca),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 2,
                          child: Text(sca.authorizationStateString()),
                        )
                      ],
                    ),
                    SizedBox(height: 8),
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
                          flex: 2,
                          child: Center(
                            child: Text(
                              '${member.major}',
                              style: getStateTextStyle(sca),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Flexible(
                            fit: FlexFit.tight, flex: 2, child: Container()),
                      ],
                    ),
                    SizedBox(height: 8),
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
                          flex: 2,
                          child: Center(
                            child: Text('${member.studentID}',
                                style: getStateTextStyle(sca)),
                          ),
                        ),
                        Flexible(
                            fit: FlexFit.tight, flex: 2, child: Container()),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Text('같은 학교 학생 안만나기',
                            style: TextStyle(
                                fontSize: 15.0,
                                color: member.isNotMeetingSameUniversity
                                    ? chatPrimaryColor
                                    : null))),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.loose,
                      child: Container(
                        height: 30,
                        child: Switch(
                          activeColor: chatPrimaryColor,
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
                            style: TextStyle(
                                fontSize: 15.0,
                                color: member.isNotMeetingSameMajor
                                    ? chatPrimaryColor
                                    : null))),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.loose,
                      child: Container(
                        height: 30,
                        child: Switch(
                          activeColor: chatPrimaryColor,
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
          SizedBox(height: 24.0),
          BottomButton(
            text: '수정',
            onPressed: _isFix ? () async => await updateProfile() : null,
          ),
          SizedBox(height: 16.0),
        ],
      ),
    );
  }

  Future updateProfile() async {
    try {
      _member = await _memberModel.updateProfile(_fixProfile);
      _fixProfile = Member.fromJson(_member.toJson());
      setState(() => _isFix = false);
      Fluttertoast.showToast(
          msg: '수정되었습니다.',
          fontSize: 15,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          gravity: ToastGravity.CENTER,
          toastLength: Toast.LENGTH_SHORT);
    } catch (e) {
      print('profileUpdateError');
    }
  }

  TextStyle getStateTextStyle(MemberAuthProvider authProvider) {
    return TextStyle(
        fontSize: 16,
        color: authProvider.scaState == StdCardAuthState.authorizations
            ? Colors.black
            : Colors.grey);
  }

  _fetchData() {
    _member = HiveController.loadProfileToLocal();
    _fixProfile = Member.fromJson(_member.toJson());
    sexBtnColor = _member.sex == '남자';
    setState(() => loading = false);
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
                  scrollController: FixedExtentScrollController(
                      initialItem: getInitialItemIndex(item)),
                  itemExtent: 50,
                  childCount: item.length,
                  diameterRatio: 10,
                  squeeze: 1,
                  backgroundColor: Colors.grey[100],
                  onSelectedItemChanged: (index) {
                    setState(() {
                      item == _itemsBirth
                          ? _fixProfile.birthYear = item[index] == '선택'
                              ? null
                              : int.parse(item[index])
                          : _fixProfile.region = item[index];
                    });
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

  int getInitialItemIndex(List<String> item) {
    if (item == _itemsBirth)
      return item.indexOf('${_fixProfile.birthYear}');
    else
      return item.indexOf('${_fixProfile.region}');
  }
}
