import 'package:anony_chat/controller/hive_controller.dart';
import 'package:anony_chat/model/dao/member.dart';
import 'package:anony_chat/provider/auth_provider.dart';
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
  static const double HORIZONTAL_PADDING = 16;

  final String _profileIconPath = 'assets/icons/profile2.png';
  MemberModel _memberModel = MemberModel();
  Member _member;
  Member _fixProfile;

  // true#남성 false#여성
  bool loading = true;

  List<String> _cityList = [
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
  String _selectedCity;

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 2),
          child: Container(
              width: 30, height: 30, child: Image.asset('$_profileIconPath')),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text('회원번호 ${member.userID}',
                style: TextStyle(color: Colors.white, fontSize: 13)),
          ),
        ),
        SizedBox(height: CARD_SIZED_BOX_HEIGHT),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: HORIZONTAL_PADDING),
          child: Card(
            elevation: 3,
            child: Row(
              children: [
                Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: Center(child: Text('전화번호'))),
                Flexible(
                    fit: FlexFit.tight,
                    flex: 2,
                    child: Center(child: Text(member.phoneNumber))),
                Flexible(
                  fit: FlexFit.loose,
                  flex: 1,
                  child: Center(
                    child: ButtonTheme(
                      height: 30,
                      minWidth: 60,
                      buttonColor: Colors.black,
                      child: RaisedButton(
                        child:
                            Text('변경', style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          //TODO 휴대폰 번호 변경
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: CARD_SIZED_BOX_HEIGHT),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: HORIZONTAL_PADDING),
          child: Card(
            elevation: 3,
            child: Row(
              children: [
                Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: Center(child: Text('내지역'))),
                Flexible(
                    fit: FlexFit.tight,
                    flex: 2,
                    child: Center(child: Text(member.city))),
                Flexible(
                  fit: FlexFit.loose,
                  flex: 1,
                  child: Center(
                    child: ButtonTheme(
                      height: 30,
                      minWidth: 60,
                      buttonColor: Colors.black,
                      child: RaisedButton(
                        child:
                            Text('변경', style: TextStyle(color: Colors.white)),
                        onPressed: () => showPicker(context),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: CARD_SIZED_BOX_HEIGHT),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: HORIZONTAL_PADDING),
          child: Card(
            elevation: 3,
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                            fit: FlexFit.tight,
                            flex: 1,
                            child: Center(child: Text('성별'))),
                        Flexible(
                            fit: FlexFit.tight,
                            flex: 2,
                            child: Center(child: Text(member.gender))),
                        Flexible(
                            fit: FlexFit.tight, flex: 1, child: Container())
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Flexible(
                            fit: FlexFit.tight,
                            flex: 1,
                            child: Center(child: Text('나이'))),
                        Flexible(
                            fit: FlexFit.tight,
                            flex: 2,
                            child: Center(
                                child: Text(member.birthYear.toString()))),
                        Flexible(
                            fit: FlexFit.tight, flex: 1, child: Container())
                      ],
                    )
                  ],
                )),
          ),
        ),
        SizedBox(height: CARD_SIZED_BOX_HEIGHT),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: HORIZONTAL_PADDING),
          child: Consumer<AuthProvider>(
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
                          flex: 1,
                          child: Center(
                              child: Text(sca.authorizationStateString())),
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
                              '${member.department}',
                              style: getStateTextStyle(sca),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Flexible(
                            fit: FlexFit.tight, flex: 1, child: Container()),
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
                            fit: FlexFit.tight, flex: 1, child: Container()),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, top: 4.0, bottom: 4.0),
                child: Row(
                  children: [
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () => setState(
                          () => member.isShowMyInfo = !member.isShowMyInfo),
                      child: Row(
                        children: [
                          Icon(Icons.check,
                              color: member.isShowMyInfo
                                  ? chatPrimaryColor
                                  : Colors.grey),
                          SizedBox(
                            width: 24,
                          ),
                          Text('회원정보 공개',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: member.isShowMyInfo
                                      ? chatPrimaryColor
                                      : Colors.black))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.error,
                      size: 20,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        '회원님과 상대방 모두 공개일때만 회원정보가 공개됩니다',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Divider(thickness: 0.5, color: Colors.grey),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, top: 4.0, bottom: 4.0),
                child: Row(
                  children: [
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () => setState(() =>
                          member.isNotMatchingSameUniversity =
                              !member.isNotMatchingSameUniversity),
                      child: Row(
                        children: [
                          Icon(Icons.check,
                              color: member.isNotMatchingSameUniversity
                                  ? chatPrimaryColor
                                  : Colors.grey),
                          SizedBox(
                            width: 24,
                          ),
                          Text(
                            '같은 학교 학생 안만나기',
                            style: TextStyle(
                                fontSize: 16,
                                color: member.isNotMatchingSameUniversity
                                    ? chatPrimaryColor
                                    : Colors.black),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, top: 4.0, bottom: 4.0),
                child: Row(
                  children: [
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () => setState(() =>
                          member.isNotMatchingSameDepartment =
                              !member.isNotMatchingSameDepartment),
                      child: Row(
                        children: [
                          Icon(Icons.check,
                              color: member.isNotMatchingSameDepartment
                                  ? chatPrimaryColor
                                  : Colors.grey),
                          SizedBox(
                            width: 24,
                          ),
                          Text(
                            '같은 학교의 같은 학과 학생 안만나기',
                            style: TextStyle(
                                fontSize: 16,
                                color: member.isNotMatchingSameDepartment
                                    ? chatPrimaryColor
                                    : Colors.black),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: HORIZONTAL_PADDING),
          child: BottomButton(
              text: '수정',
              onPressed: _isFix ? () async => await updateProfile() : null),
        ),
        SizedBox(height: 16.0),
      ],
    );
  }

  Future updateProfile() async {
    try {
      final result = await _memberModel.updateProfile(_fixProfile);
      if (result) {
        _member = _fixProfile;
        Fluttertoast.showToast(
            msg: '수정되었습니다.',
            fontSize: 15,
            backgroundColor: Colors.black87,
            textColor: Colors.white,
            gravity: ToastGravity.CENTER,
            toastLength: Toast.LENGTH_SHORT);
      } else {
        _fixProfile = _member;
        Fluttertoast.showToast(
            msg: '수정에 실패했습니다.',
            fontSize: 15,
            backgroundColor: Colors.black87,
            textColor: Colors.white,
            gravity: ToastGravity.CENTER,
            toastLength: Toast.LENGTH_SHORT);
        return;
      }
      setState(() => _isFix = false);
    } catch (e) {
      print('profileUpdateError');
    }
  }

  TextStyle getStateTextStyle(AuthProvider authProvider) {
    return TextStyle(
        fontSize: 16,
        color: authProvider.authState == AuthState.authorizations
            ? Colors.black
            : Colors.grey);
  }

  _fetchData() {
    _member = HiveController.instance.loadProfileToLocal();
    _fixProfile = Member.fromJson(_member.toJson());
    _selectedCity = _fixProfile.city;
    setState(() => loading = false);
  }

  showPicker(context) {
    return showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 300,
            color: Colors.white,
            child: GestureDetector(
              onTap: () {
                setState(() => _fixProfile.city = _selectedCity);
                Navigator.pop(context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: CupertinoPicker.builder(
                  scrollController: FixedExtentScrollController(
                      initialItem: _cityList.indexOf('${_fixProfile.city}')),
                  itemExtent: 50,
                  childCount: _cityList.length,
                  diameterRatio: 10,
                  squeeze: 1,
                  backgroundColor: Colors.grey[100],
                  onSelectedItemChanged: (index) {
                    setState(() => _selectedCity = _cityList[index]);
                  },
                  itemBuilder: (_, index) => Center(
                    child: Text(_cityList[index],
                        style: TextStyle(color: Colors.black)),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
