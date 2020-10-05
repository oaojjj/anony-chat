import 'package:anony_chat/model/dao/member.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum RegisterState { canNotRegister, canRegister }
enum PhoneAuthState { none, requested, timeout, failed, succeed }

/* 회원가입 단계 수
   1. 폰인증
   2. 약관동의
   3. 회원정보입력
   4. 학생증 인증
   */
class RegisterProvider extends ChangeNotifier {
  Member member = Member();

  int _stepLength = 4;

  // 회원가입 진행 상황
  List<String> _isActiveString = ['전화번호 인증', '이용약관 동의', '회원정보', '학생증 인증'];
  List<bool> _isActive = [true, false, false, false];
  List<StepState> _stepState = [
    StepState.editing,
    StepState.disabled,
    StepState.disabled,
    StepState.disabled
  ];

  // 폰 인증 상태
  PhoneAuthState _phoneAuthState = PhoneAuthState.none;

  // 최종 회원가입 상태
  bool canRegister = false;

  // 다음 단계로 넘어갈 수 있는지 상태
  bool canNextStep = false;

  // 회원가입 단계 체크
  int _currentStep = 0;

  // 다음 단계로 넘어가는 메소드
  Future<void> onContinueStep() async {
    if (_currentStep < _stepLength - 1) {
      _stepState[_currentStep] = StepState.complete;
      _stepState[_currentStep + 1] = StepState.editing;
      _isActive[_currentStep + 1] = true;
      _currentStep = _currentStep + 1;
    }
    onEditingStep();
    notifyListeners();
  }

  // 이전 단계로 가는 메소드
  void onPrevStep() {
    if (_currentStep > 0) {
      _stepState[_currentStep] = StepState.disabled;
      _isActive[_currentStep] = false;
      _currentStep = _currentStep - 1;
      _stepState[_currentStep] = StepState.editing;
      _isActive[_currentStep] = true;
    } else {
      _stepState[_currentStep] = StepState.editing;
      _currentStep = 0;
    }
    notifyListeners();
  }

  PhoneAuthState get phoneAuthState => _phoneAuthState;

  List<bool> get isActive => _isActive;

  List<String> get isActiveString => _isActiveString;

  List<StepState> get stepState => _stepState;

  int get currentStep => _currentStep;

  void onSucceedStep() => canNextStep = true;

  void onEditingStep() => canNextStep = false;

  String stringAccordingToAuthState() {
    switch (_phoneAuthState) {
      case PhoneAuthState.none:
      case PhoneAuthState.requested:
      case PhoneAuthState.timeout:
        return '';
      case PhoneAuthState.succeed:
        return '인증이 성공했습니다.';
      case PhoneAuthState.failed:
        return '인증번호가 일치하지 않습니다.';
      default:
        return 'error';
    }
  }

  void onPhoneAuthSucceed({@required String phoneNumber}) {
    member.phoneNumber = phoneNumber;
    _phoneAuthState = PhoneAuthState.succeed;
    onSucceedStep();
    notifyListeners();
  }

  void onPhoneAuthFailed() {
    _phoneAuthState = PhoneAuthState.failed;
    notifyListeners();
  }

  void onPhoneAuthTimeout() {
    _phoneAuthState = PhoneAuthState.timeout;
    notifyListeners();
  }

  void onPhoneRequestSMSCode() {
    _phoneAuthState = PhoneAuthState.requested;
    notifyListeners();
  }

  void onNextStep() {
    onSucceedStep();
    notifyListeners();
  }

  void onCantNextStep() {
    if (canRegister) canRegister = false;
    onEditingStep();
    notifyListeners();
  }

  void onRegisterReady() {
    canRegister = true;
    onNextStep();
  }

  void reset() {
    print('register provider reset');
    _isActive = [true, false, false, false];
    _stepState = [
      StepState.editing,
      StepState.disabled,
      StepState.disabled,
      StepState.disabled
    ];
    _currentStep = 0;
    _phoneAuthState = PhoneAuthState.none;
    canRegister = false;
    canNextStep = false;
    canRegister = false;
    member = Member();
  }
}
