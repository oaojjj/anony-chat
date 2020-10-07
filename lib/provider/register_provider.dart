import 'package:anony_chat/model/dao/member.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum RegisterState { canNotRegister, canRegister }

class RegisterProvider extends ChangeNotifier {
  Member member = Member();

  // 최종 회원가입 상태
  bool canRegister = false;

  void onCanRegister() {
    canRegister = true;
    notifyListeners();
  }

  void onCantRegister() {
    canRegister = false;
    notifyListeners();
  }

  void reset() {
    print('register provider reset');
    canRegister = false;
    member = Member();
  }
}
