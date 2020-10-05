import 'package:anony_chat/provider/register_provider.dart';
import 'package:anony_chat/utils/utill.dart';
import 'package:anony_chat/viewmodel/auth/phone_authorization_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PhoneVerificationTap extends StatefulWidget {
  final List<FocusNode> _focusNode;

  PhoneVerificationTap(this._focusNode);

  @override
  _PhoneVerificationTapState createState() => _PhoneVerificationTapState();
}

class _PhoneVerificationTapState extends State<PhoneVerificationTap> {
  final _formKey = GlobalKey<FormState>();
  final _phoneNumberController = TextEditingController();
  final _smsCodeController = TextEditingController();

  final PhoneAuthorizationModel fam = PhoneAuthorizationModel();

  // 인증번호 전송 여부
  bool _isRequested = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fam.setProvider(Provider.of<RegisterProvider>(context));
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: Provider.of<RegisterProvider>(context).phoneAuthState ==
              PhoneAuthState.succeed
          ? true
          : false,
      child: Container(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 16.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, bottom: 4.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "전화번호",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                flex: 2,
                                fit: FlexFit.tight,
                                child: TextFormField(
                                  focusNode: widget._focusNode[0],
                                  controller: _phoneNumberController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                                      border: OutlineInputBorder(),
                                      hintText: '전화번호'),
                                  validator: (value) {
                                    RegExp regExp = RegExp(
                                        r'^[+-]?([0-9]+([.][0-9]*)?|[.][0-9]+)$');
                                    if (value.isEmpty)
                                      return '전화번호를 입력하세요.';
                                    else if (!regExp.hasMatch(value))
                                      return '숫자만 입력하세요';
                                    else if (value.length != 11) {
                                      return '전화번호를 다시 확인해주세요.';
                                    } else
                                      return null;
                                  },
                                ),
                              ),
                              SizedBox(width: 4.0),
                              Flexible(
                                flex: 1,
                                fit: FlexFit.loose,
                                child: RaisedButton(
                                    child: Text(_isRequested ? '재전송' : '인증번호',
                                        style: TextStyle(color: Colors.white)),
                                    onPressed: () {
                                      if (_checkedValidate()) return;
                                      _requestPhoneAuth();
                                    }),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          _isRequested
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      fit: FlexFit.tight,
                                      flex: 2,
                                      child: Stack(
                                        children: [
                                          TextFormField(
                                            focusNode: widget._focusNode[1],
                                            controller: _smsCodeController,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        10.0, 0, 10.0, 0),
                                                border: OutlineInputBorder(),
                                                hintText: '인증번호'),
                                          ),
                                          Positioned(
                                            right: 8,
                                            top: 16,
                                            bottom: 16,
                                            child: StreamBuilder(
                                              stream: fam.time,
                                              builder: (_, snap) {
                                                if (snap.hasData) {
                                                  if (Provider.of<RegisterProvider>(
                                                              context)
                                                          .phoneAuthState ==
                                                      PhoneAuthState.timeout)
                                                    toast(
                                                        '인증 제한시간이 지났습니다.\n재전송 부탁드립니다.');
                                                  return Text(
                                                    DateFormat('mm:ss').format(DateTime
                                                        .fromMillisecondsSinceEpoch(
                                                            Duration(
                                                                    seconds: snap
                                                                        .data)
                                                                .inMilliseconds)),
                                                    style: TextStyle(
                                                        color:
                                                            chatPrimaryColor),
                                                  );
                                                } else if (snap.hasError)
                                                  return Text('error');
                                                else
                                                  return Text('loading..');
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 4.0),
                                    Flexible(
                                      fit: FlexFit.loose,
                                      flex: 1,
                                      child: ButtonTheme(
                                        buttonColor: Colors.grey[800],
                                        child: RaisedButton(
                                            child: Text('확인',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            onPressed: () {
                                              fam.signInWithPhoneNumberWithSMSCode(
                                                  _smsCodeController.text);
                                              print(
                                                  Provider.of<RegisterProvider>(
                                                          context,
                                                          listen: false)
                                                      .phoneAuthState);
                                            }),
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 4.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  Provider.of<RegisterProvider>(context)
                      .stringAccordingToAuthState(),
                  style: TextStyle(
                      color: chatPrimaryColor, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _requestPhoneAuth() {
    switch (
        Provider.of<RegisterProvider>(context, listen: false).phoneAuthState) {
      case PhoneAuthState.none:
        toast('인증번호를 전송 하였습니다.');
        fam.requestSMSCodeAuthorization(
            phoneNumber: _phoneNumberController.text);
        break;
      case PhoneAuthState.succeed:
        // TODO 인증성공
        break;
      default:
        // 타임아웃, 인증실패, 재전송
        toast('인증번호를 재전송 하였습니다.');
        fam.resendSMSCodeAuthorization();
        break;
    }
    setState(() => _isRequested = true);
  }

  void toast(String text) {
    Fluttertoast.showToast(
        msg: text,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        toastLength: Toast.LENGTH_SHORT);
  }

  bool _checkedValidate() {
    if (_formKey.currentState.validate()) {
      // success
      return false;
    } else {
      // fail
      return true;
    }
  }
}
