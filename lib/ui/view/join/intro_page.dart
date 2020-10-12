import 'dart:async';
import 'dart:io';

import 'package:anony_chat/model/auth/auth_sign_in.dart';
import 'package:anony_chat/provider/register_provider.dart';
import 'package:anony_chat/utils/utill.dart';
import 'package:anony_chat/viewmodel/auth_http_model.dart';
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
  bool loading = false;

  AuthHttpModel _authHttpModel = AuthHttpModel();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _checkKakaoTalkInstalled();
      // 여기서 인증확인
      if (Platform.isIOS) {
        print('ios 기기');
        // 자동로그인 같은거 구현하면 쓰면될듯
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
    return SafeArea(
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
                    onPressed: () => startGuideDialog(context),
                  ),
                ),
              ),
              FlatButton(
                child: Text('지름길'),
                onPressed: () => Navigator.pushNamed(
                    context, '/student_card_authorization_page'),
              ),
              SizedBox(height: deviceSize.height * 0.25)
            ],
          ),
        ),
      ),
    );
  }

  startGuideDialog(context) {
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
                          login();
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

  login() async {
    try {
      User user = await KakaoTalkLogin();

      if (user.id != null) {
        print('#카카오톡 로그인 성공');
        if (user.kakaoAccount.ageRange != AgeRange.TWENTIES)
          cantRegisterDialog();
        else {
          print('-----앱 로그인 시도-----');
          AuthSignIn loginResult =
              await _authHttpModel.requestSingIn('kakao', user.id.toString());
          print('로그인 결과 ${loginResult.toJson()}');

          if (loginResult.code == ResponseCode.SUCCESS_CODE) {
            print('#앱 로그인 성공');

            headers.forEach((key, value) => print('헤더 $key // $value'));
            print('토큰 ${loginResult.data.item[0]}');
            headers['token'] = loginResult.data.item[0];
            /*await PushNotificationManager()
                .firebaseMessaging
                .getToken()
                .then((token) async {
              print('파이어베이스 token:' + token);
              await userHttpModel.modUserInfo(msgToken: token);
              print('토큰 업뎃함');
            });*/
            Navigator.pushNamed(context, '/main_page');
          } else if (loginResult.code == ResponseCode.DATA_NOT_FOUND) {
            print('#앱 로그인 실패 -> 회원가입');
            Provider.of<RegisterProvider>(context, listen: false)
                .setMemberInfoWithKakao(user.kakaoAccount);
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

  Future<User> KakaoTalkLogin() async {
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

  cantRegisterDialog() {
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
