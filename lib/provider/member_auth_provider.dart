import 'package:anony_chat/controller//hive_controller.dart';
import 'package:anony_chat/viewmodel/member_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'member_auth_provider.g.dart';

// 학생증 인증 완료, 거부, 대기 상태
enum StdCardAuthState {
  authorizations,
  nonAuthorizations,
  authorizationsWaiting
}

@HiveType(typeId: 1)
enum AuthStatus {
  @HiveField(0)
  registered,
  @HiveField(1)
  nonRegistered
}

/* 사용자 상태 정리

 # 학생증 인증 상태
 1. 회원가입시 인증 대기 상태
 2. 학생증 인증 성공 상태
 3. 학생증 인증 실패 상태

 # 사용자 신고 상태
 1. 정상적인 이용이 가능한 상태
 2. 신고를 당해 이용정지 상태

*/

class MemberAuthProvider extends ChangeNotifier {
  // 학생증 인증 여부
  StdCardAuthState _scaState = StdCardAuthState.nonAuthorizations;

  StdCardAuthState get scaState => _scaState;

  authorizations() {
    _scaState = StdCardAuthState.authorizations;
    notifyListeners();
  }

  nonAuthorizations() {
    _scaState = StdCardAuthState.nonAuthorizations;
    notifyListeners();
  }

  checkAuthorization() async {
    final stdCardAuth =
        await MemberModel.getMemberAuthorization(HiveController.instance.getMemberID());
    print('stdCardAuth: $stdCardAuth');

    switch (stdCardAuth) {
      case 'authorizations':
        _scaState = StdCardAuthState.authorizations;
        break;
      case 'authorizationsWaiting':
        _scaState = StdCardAuthState.authorizationsWaiting;
        break;
      case 'nonAuthorizations':
        _scaState = StdCardAuthState.nonAuthorizations;
        break;
    }
  }

  String authorizationStateString() {
    switch (_scaState) {
      case StdCardAuthState.authorizationsWaiting:
        return '(인증대기중)';
      case StdCardAuthState.nonAuthorizations:
        return '(인증거절)';
      default:
        return '';
    }
  }

  AuthStatus onStartUp() {
    final status = HiveController.instance.getAuthStatus();

    if (status == AuthStatus.registered) {}
    return status;
  }
}
