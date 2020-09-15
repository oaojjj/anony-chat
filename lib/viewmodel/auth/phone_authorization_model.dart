import 'package:firebase_auth/firebase_auth.dart';

class PhoneAuthorizationModel {
  String _verificationID;
  String _phoneNumber;
  int _forceCodeResendToken;
  static const int _TIME_OUT = 120;

  Future<void> requestSMSCodeAuthorization({String phoneNumber}) async {
    phoneNumber = '+82$phoneNumber';
    _phoneNumber = phoneNumber;

    print(phoneNumber);
    await FirebaseAuth.instance.verifyPhoneNumber(
        timeout: Duration(seconds: _TIME_OUT),
        phoneNumber: phoneNumber,
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

  Future<void> resendSMSCodeAuthorization() async {
    if (_phoneNumber == null) {
      return;
    }

    await FirebaseAuth.instance.verifyPhoneNumber(
        timeout: Duration(seconds: _TIME_OUT),
        phoneNumber: _phoneNumber,
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
    print('authCredential:$authCredential');

    try {
      await FirebaseAuth.instance.signInWithCredential(authCredential);
      return true;
    } catch (e) {
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
      yield i;
      await Future.delayed(const Duration(seconds: 1));
    }
  }
}
