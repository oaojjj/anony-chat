import 'package:anony_chat/controller/hive_controller.dart';
import 'package:anony_chat/utils/utill.dart';
import 'package:flutter/material.dart';

// 사용자 인증 상태
enum AuthState {
  /// 정상 인증
  authorizations,

  /// 권한없음/인증대기중
  notAuthorized,

  /// 인증 거절
  deniedAuthorized,

  /// 사용정지
  banned
}

class AuthProvider extends ChangeNotifier {
  AuthState _authState = AuthState.notAuthorized;

  AuthState get authState => _authState;

  authorizations() {
    _authState = AuthState.authorizations;
    notifyListeners();
  }

  nonAuthorizations() {
    _authState = AuthState.notAuthorized;
    notifyListeners();
  }

  String authorizationStateString() {
    switch (_authState) {
      case AuthState.notAuthorized:
        return '(인증대기중)';
      case AuthState.deniedAuthorized:
        return '(인증거절)';
      default:
        return '';
    }
  }

  void setAuthState(num code) {
    switch (code) {
      case ResponseCode.SUCCESS_CODE:
        _authState = AuthState.authorizations;
        break;
      case ResponseCode.NOT_AUTHORIZED:
        _authState = AuthState.notAuthorized;
        break;
      case ResponseCode.DENIED_AUTHORIZED:
        _authState = AuthState.deniedAuthorized;
        break;
      case ResponseCode.BANNED_USER:
        _authState = AuthState.banned;
        break;
    }
    notifyListeners();
    // HiveController.instance.setAuthState();
  }
}
