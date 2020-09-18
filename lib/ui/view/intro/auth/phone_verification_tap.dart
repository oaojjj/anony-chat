import 'package:anony_chat/provider/register_provider.dart';
import 'package:anony_chat/viewmodel/auth/phone_authorization_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PhoneVerificationTap extends StatefulWidget {
  @override
  _PhoneVerificationTapState createState() => _PhoneVerificationTapState();
}

class _PhoneVerificationTapState extends State<PhoneVerificationTap> {
  final _formKey = GlobalKey<FormState>();
  final _phoneNumberController = TextEditingController();
  final _smsCodeController = TextEditingController();
  final PhoneAuthorizationModel fam = PhoneAuthorizationModel();

  bool _isRequested = false;

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
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 4.0),
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
                                  controller: _phoneNumberController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                                      border: OutlineInputBorder(),
                                      hintText: '전화번호'),
                                  validator: (value) {
                                    if (value.isEmpty)
                                      return '전화번호를 입력하세요.';
                                    else if (value.contains('-'))
                                      return '숫자만 입력하세요';
                                    else
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
                                      if (checkedValidate()) return;
                                      requestPhoneAuth();
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
                                                if (snap.hasData)
                                                  return Text(
                                                    DateFormat('mm:ss').format(DateTime
                                                        .fromMillisecondsSinceEpoch(
                                                            Duration(
                                                                    seconds: snap
                                                                        .data)
                                                                .inMilliseconds)),
                                                    style: TextStyle(
                                                        color: Colors.indigo),
                                                  );
                                                else if (snap.hasError)
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
                                              checkPhoneSMSCode();
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
                child: Consumer(
                  builder: (_, RegisterProvider value, __) => Text(
                    value.stringAccordingToAuthState(),
                    style: TextStyle(
                        color: Colors.indigo, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void requestPhoneAuth() {
    switch (
        Provider.of<RegisterProvider>(context, listen: false).phoneAuthState) {
      case PhoneAuthState.none:
        fam.requestSMSCodeAuthorization(phoneNumber: _phoneNumberController.text);
        break;
      case PhoneAuthState.failed:
        fam.resendSMSCodeAuthorization();
        Fluttertoast.showToast(
            msg: '인증번호를 재전송 하였습니다.',
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.grey[800],
            toastLength: Toast.LENGTH_SHORT);
        break;
      default:
        break;
    }
    setState(() => _isRequested = true);
  }

  checkPhoneSMSCode() async {
    final rp = Provider.of<RegisterProvider>(context, listen: false);
    final result = await fam.signInWithPhoneNumberAndSMSCode(_smsCodeController.text);

    if (result) {
      print('checkPhoneSucceed');
      rp.onPhoneAuthSucceed(phoneNumber: fam.phoneNumber);
    } else {
      print('checkPhoneFailed');
      rp.onPhoneAuthFailed();
    }
  }

  bool checkedValidate() {
    if (_formKey.currentState.validate()) {
      return false;
    } else {
      return true;
    }
  }
}
