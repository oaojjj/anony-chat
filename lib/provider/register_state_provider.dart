import 'package:flutter/foundation.dart';

enum AuthState { canNotRegister, canRegister }

class RegisterStateProvider extends ChangeNotifier {
  // 학생증 인증 상태
  bool _stdCardCertification = false;
  AuthState _authState = AuthState.canNotRegister;

  bool get stdCardCertification => _stdCardCertification;
  AuthState get authState => _authState;

  void successCertification() {
    _authState=AuthState.canRegister;
    _stdCardCertification = true;
    notifyListeners();
  }


}
