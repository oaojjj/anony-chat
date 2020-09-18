import 'package:firebase_auth/firebase_auth.dart';

class PhoneAuthorizationModel {
  String _verificationID;
  String _phoneNumber;
  int _forceCodeResendToken;

  static const int _TIME_OUT = 120;
  Stream<int> _time;

  bool _isSucceed = false;

  Stream<int> get time => _time;

  String get phoneNumber => _phoneNumber;

  // 휴대폰 sms 인증
  Future<void> requestSMSCodeAuthorization({String phoneNumber}) async {
    _phoneNumber = phoneNumber;

    _time = timeOutStart();
    await FirebaseAuth.instance.verifyPhoneNumber(
        timeout: Duration(seconds: _TIME_OUT),
        phoneNumber: '+82$phoneNumber',
        verificationCompleted: (AuthCredential phoneAuthCredential) =>
            _completed(phoneAuthCredential),
        verificationFailed: (FirebaseAuthException authException) =>
            _failed(authException),
        codeSent: (String verificationID, [int forceResendingToken]) {
          _verificationID = verificationID;
          _forceCodeResendToken = forceResendingToken;
        },
        codeAutoRetrievalTimeout: (id) => _timeOut(id));
  }

  // 재전송
  Future<void> resendSMSCodeAuthorization() async {
    if (_phoneNumber == null) {
      return;
    }

    _time = timeOutStart();
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
        codeAutoRetrievalTimeout: (id) => _timeOut(id));
  }

  Future<bool> signInWithPhoneNumberAndSMSCode(String smsCode) async {
    smsCode = smsCode.trim();

    AuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: _verificationID, smsCode: smsCode);

    try {
      await FirebaseAuth.instance.signInWithCredential(authCredential);
      onSucceed();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  _completed(AuthCredential phoneAuthCredential) {}

  _failed(FirebaseAuthException authException) {
    print('error: ${authException.message}');
  }

  _timeOut(String id) {
    print('timeout: $id');
  }

  Stream<int> timeOutStart() async* {
    for (int i = _TIME_OUT; i >= 0; i--) {
      if (_isSucceed) break;
      yield i;
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  void onSucceed() => _isSucceed = true;
}
