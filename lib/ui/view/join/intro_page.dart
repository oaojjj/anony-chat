import 'dart:async';
import 'dart:io';

import 'package:anony_chat/controller/hive_controller.dart';
import 'package:anony_chat/model/dao/member.dart';
import 'package:anony_chat/provider/auth_provider.dart';
import 'package:anony_chat/provider/register_provider.dart';
import 'package:anony_chat/ui/widget/loading.dart';
import 'package:anony_chat/utils/utill.dart';
import 'package:anony_chat/viewmodel/auth_http_model.dart';
import 'package:anony_chat/viewmodel/member_model.dart';
import 'package:anony_chat/viewmodel/user_http_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  bool _isKakaoTalkInstalled = false;
  bool _loading = false;

  final _memberModel = MemberModel();

  final AuthHttpModel _authHttpModel = AuthHttpModel();
  final UserHttpModel _userHttpModel = UserHttpModel();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      print(HiveController.instance.getFCMToken());
      await _checkKakaoTalkInstalled();
      if (Platform.isIOS) {
        print('ios 기기');
        // login
      } else {
        print('android 기기');
        if (_isKakaoTalkInstalled) {
          // login
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return _loading
        ? Loading()
        : SafeArea(
            child: Scaffold(
              body: Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        height: 120.0,
                        width: 120.0,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Image.asset(
                            'assets/icons/send_messageIcon.png',
                            width: double.infinity,
                          ),
                        )),
                    Text(
                      '익명메신저\n어플',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: chatPrimaryColor),
                    ),
                    SizedBox(height: deviceSize.height * 0.20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        child: RaisedButton(
                          color: Colors.yellow,
                          child: Row(
                            children: [
                              Flexible(
                                fit: FlexFit.tight,
                                flex: 1,
                                child: Image.asset(
                                  'assets/icons/kakao_logo.png',
                                  height: 50,
                                ),
                              ),
                              Flexible(
                                fit: FlexFit.tight,
                                flex: 2,
                                child: Text(
                                  '카카오 계정으로 로그인',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          onPressed: () => _startGuideDialog(context),
                        ),
                      ),
                    ),
                    FlatButton(
                      child: Text('지름길'),
                      onPressed: () {
                        HiveController.instance
                            .saveMemberInfoToLocal(Member.fromJson({
                          'id': 2,
                          'fcmToken': HiveController.instance.getFCMToken(),
                          'gender': "여자",
                          'address': "테스트 도시",
                          'school': "테스트 학교",
                          'department': "테스트 학과",
                          'birth_year': 1999,
                          'num': "010-1111-2222",
                          'studentID': 201812345,
                          'possibleMessageOfSend': 2,
                          'provide': true,
                          'school_matching': false,
                          'department_matching': false,
                        }));
                        Navigator.pushNamed(context, '/main_page');
                      },
                    ),
                    SizedBox(height: deviceSize.height * 0.25)
                  ],
                ),
              ),
            ),
          );
  }

  _startGuideDialog(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Container(
              child: Column(
                children: <Widget>[
                  Text(
                    '잠깐!\n20대가 맞습니까?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: chatPrimaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            //
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  '어플의 특성상\n20대만 이용할 수 있습니다. :-)',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                Text(
                  '관리자 확인 후 20대가 아닐 시\n서비스의 제한이 있습니다.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RaisedButton(
                      color: Colors.white,
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        '아니오',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    RaisedButton(
                      child: Text(
                        '20대 입니다.',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        if (_isKakaoTalkInstalled)
                          _login();
                        else {
                          Fluttertoast.showToast(
                              msg: '카카오톡을 설치하고 다시 시도해주세요.',
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.black,
                              toastLength: Toast.LENGTH_SHORT);
                          Timer(Duration(milliseconds: 500),
                              () => _launchURLKakao());
                        }
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  // 카카오톡 설치 여부 확인 메소드
  _checkKakaoTalkInstalled() async {
    final installed = await isKakaoTalkInstalled();
    print('Kakao install : ' + installed.toString());

    setState(() {
      _isKakaoTalkInstalled = installed;
    });
  }

  _login() async {
    try {
      print('#카카오톡 로그인 시도');
      User user = await _KakaoTalkLogin();
      if (user.id != null) {
        print('#카카오톡 로그인 성공');
        if (user.kakaoAccount.ageRange != AgeRange.TWENTIES ||
            user.kakaoAccount.ageRange == null) {
          _cantRegisterDialog();
        } else {
          setState(() => _loading = true);
          print('#앱 로그인 시도');
          final loginResult =
              await _authHttpModel.requestSingIn('kakao', user.id.toString());
          if (loginResult.code == ResponseCode.SUCCESS_CODE ||
              loginResult.code == ResponseCode.NOT_AUTHORIZED ||
              loginResult.code == ResponseCode.DENIED_AUTHORIZED ||
              loginResult.code == ResponseCode.BANNED_USER) {
            print('#앱 로그인 성공(${loginResult.message})');
            if (loginResult.code == ResponseCode.SUCCESS_CODE) {
              print('jwtToken: ${loginResult.data.item[0]}');
              headers['token'] = loginResult.data.item[0];
            }

            // 사용자 체크하고 로컬db 업데이트
            if (await _fetchAndUpdateUser()) return;

            // 사용자 인증 상태 업데이트
            Provider.of<AuthProvider>(context, listen: false)
                .setAuthState(loginResult.code);
            Navigator.pushNamedAndRemoveUntil(
                context, '/main_page', (route) => false);
          } else if (loginResult.code == ResponseCode.DATA_NOT_FOUND) {
            print('#앱 로그인 실패 -> 회원가입');
            Provider.of<RegisterProvider>(context, listen: false)
                .setMemberInfoWithKakao(user);
            Navigator.pushNamed(context, '/student_card_authorization_page');
          }
        }
      } else {
        print('#카카오톡 로그인 실패');
        Fluttertoast.showToast(
            msg: '카카오톡 로그인에 실패했습니다.',
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black,
            toastLength: Toast.LENGTH_SHORT);
      }
    } catch (e) {
      print('카톡 error: $e');
    }
  }

  Future<bool> _fetchAndUpdateUser() async {
    final userInfo = await _userHttpModel.getUserInfo();
    print(userInfo.toJson());

    if (userInfo.code == ResponseCode.SUCCESS_CODE) {
      await _memberModel.updateFcmToken(
          userInfo.data.item[0]['id'], HiveController.instance.getFCMToken());

      final localUserID = HiveController.instance.getMemberID().toString();
      if (localUserID != userInfo.data.item[0]['id']) {
        await HiveController.instance.fetchMemberInfo(userInfo.data.item[0]);
      }
      return false;
    }
    setState(() => _loading = false);
    return true;
  }

  Future<User> _KakaoTalkLogin() async {
    print('-----카카오톡 로그인 시도-----');
    final code = await AuthCodeClient.instance.requestWithTalk();
    final token = await AuthApi.instance.issueAccessToken(code);
    await AccessTokenStore.instance.toStore(token);
    User user = await UserApi.instance.me();
    print(user.kakaoAccount.toString());
    return user;
  }

  _launchURLKakao() async {
    const url =
        'http://play.google.com/store/apps/details?id=com.kakao.talk&hl=ko';
    if (await canLaunch(url)) {
      await launch(url);
      await _checkKakaoTalkInstalled();
    } else {
      throw 'Could not launch $url';
    }
  }

  _cantRegisterDialog() {
    print('#20대 아니라서 가입 불가');
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SimpleDialog(
            contentPadding: EdgeInsets.all(0),
            title: Container(
              width: 400,
              child: Column(
                children: <Widget>[
                  Text(
                    '가입불가',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: chatPrimaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            children: [
              SizedBox(height: 24),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    '어플의 특성상 20대만 이용할 수 있습니다. :-)\n회원님의 가입은 불가능합니다.',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40),
                  Container(
                    height: 40,
                    child: FlatButton(
                        color: chatPrimaryColor,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        child: Center(
                            child: Text('확인',
                                style: TextStyle(color: Colors.white))),
                        onPressed: () => Navigator.pop(context)),
                  ),
                ],
              ),
            ],
          );
        });
  }
}
