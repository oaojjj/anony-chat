import 'package:anony_chat/provider/register_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhoneAuthorizationModel {
  String _verificationID;
  String _phoneNumber;
  int _forceCodeResendToken;
  RegisterProvider _provider;

  static const int _TIME_OUT = 60;
  static const int _KOREAN_NUMBER = 82;
  Stream<int> _time;

  bool _isSucceed = false;

  Stream<int> get time => _time;

  String get phoneNumber => _phoneNumber;

  // 휴대폰 sms 인증
  Future<void> requestSMSCodeAuthorization(
      {@required String phoneNumber}) async {
    _phoneNumber = phoneNumber;
    _provider.onPhoneRequestSMSCode();

    _time = timeoutStart();
    await FirebaseAuth.instance.verifyPhoneNumber(
        timeout: Duration(seconds: _TIME_OUT),
        phoneNumber: '+$_KOREAN_NUMBER$phoneNumber',
        verificationCompleted: (AuthCredential phoneAuthCredential) =>
            _completed(phoneAuthCredential),
        verificationFailed: (FirebaseAuthException authException) =>
            _failed(authException),
        codeSent: (String verificationID, [int forceResendingToken]) {
          // Handle when a code has been sent to the device from Firebase, used to prompt users to enter the code.
          _verificationID = verificationID;
          _forceCodeResendToken = forceResendingToken;
        },
        codeAutoRetrievalTimeout: (id) {});
  }

  // 재전송
  Future<void> resendSMSCodeAuthorization() async {
    if (_phoneNumber == null) {
      return;
    }
    _provider.onPhoneRequestSMSCode();
    _time = timeoutStart();
    await FirebaseAuth.instance.verifyPhoneNumber(
        timeout: Duration(seconds: _TIME_OUT),
        phoneNumber: '+82$_phoneNumber',
        verificationCompleted: (AuthCredential phoneAuthCredential) =>
            _completed(phoneAuthCredential),
        verificationFailed: (FirebaseAuthException authException) =>
            _failed(authException),
        codeSent: (String verificationID, [int forceResendingToken]) {
          _verificationID = verificationID;
          _forceCodeResendToken = forceResendingToken;
        },
        forceResendingToken: _forceCodeResendToken,
        codeAutoRetrievalTimeout: (id) {
          //what is it?
        });
  }

  signInWithPhoneNumberWithSMSCode(String smsCode) async {
    smsCode = smsCode.trim();

    AuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: _verificationID, smsCode: smsCode);

    try {
      await FirebaseAuth.instance.signInWithCredential(authCredential);
      onSucceed();
      _provider.onPhoneAuthSucceed(phoneNumber: _phoneNumber);
    } catch (e) {
      _provider.onPhoneAuthFailed();
      print(e.toString());
    }
  }

  // Automatic handling of the SMS code on Android devices.
  _completed(AuthCredential phoneAuthCredential) {
    print('phoneAuthCredential completed: $phoneAuthCredential');
  }

  // Handle failure events such as invalid phone numbers or whether the SMS quota has been exceeded.
  _failed(FirebaseAuthException authException) {
    print('authException error: ${authException.message}');
  }

  _timeout() => _provider.onPhoneAuthTimeout();

  Stream<int> timeoutStart() async* {
    for (int i = _TIME_OUT; i >= 0; i--) {
      if (_isSucceed) break;
      yield i;
      await Future.delayed(const Duration(seconds: 1));
      if (i == 0) _timeout();
    }
  }

  void onSucceed() => _isSucceed = true;

  void setProvider(RegisterProvider provider) {
    _provider = provider;
    print(_provider.phoneAuthState);
  }
}

// hint -> https://firebase.flutter.dev/docs/auth/phone/
