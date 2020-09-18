import 'package:anony_chat/database/shared_preferences_controller.dart';
import 'package:anony_chat/viewmodel/member_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

enum SCAState { authorizations, nonAuthorizations, authorizationsWaiting }

class SCAuthorizationProvider extends ChangeNotifier {
  SCAState _scaState = SCAState.nonAuthorizations;

  SCAState get scaState => _scaState;

  authorizations() {
    _scaState = SCAState.authorizations;
    notifyListeners();
  }

  nonAuthorizations() {
    _scaState = SCAState.nonAuthorizations;
    notifyListeners();
  }

  checkAuthorization() async {
    final auth = await MemberModel.getMemberAuthorization(await SPController.getID());
    print('authState: $auth');

    switch (auth) {
      case 'authorizations':
        _scaState = SCAState.authorizations;
        break;
      case 'authorizationsWaiting':
        _scaState = SCAState.authorizationsWaiting;
        break;
      case 'nonAuthorizations':
        _scaState = SCAState.nonAuthorizations;
        break;
    }
  }

  Stream<Event> getAuthorization(String uid) {
    final authorization = FirebaseDatabase.instance
        .reference()
        .child(MemberModel.USERS_TABLE)
        .child(uid)
        .onValue;

    return authorization;
  }

  String authorizationStateString() {
    switch (_scaState) {
      case SCAState.authorizationsWaiting:
        return '(인증대기중)';
      case SCAState.nonAuthorizations:
        return '(인증거절)';
      default:
        return '';
    }
  }
}
