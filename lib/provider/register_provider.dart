import 'package:anony_chat/model/dao/member.dart';
import 'package:flutter/foundation.dart';

enum RegisterState { canNotRegister, canRegister }
enum PhoneAuthState { none, failed, succeed }

class RegisterProvider extends ChangeNotifier {
  Member member = Member();
  RegisterState registerState = RegisterState.canNotRegister;
  PhoneAuthState _phoneAuthState = PhoneAuthState.none;
  bool stepState = false;

  PhoneAuthState get phoneAuthState => _phoneAuthState;

  void onSucceedStep() => stepState = true;

  void onEditingStep() => stepState = false;

  void onPhoneAuthSucceed() {
    _phoneAuthState = PhoneAuthState.succeed;
    onSucceedStep();
    notifyListeners();
  }

  void onPhoneAuthFailed() {
    _phoneAuthState = PhoneAuthState.failed;
    notifyListeners();
  }
}
