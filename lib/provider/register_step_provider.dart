import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterStepProvider extends ChangeNotifier {
  int _stepLength = 4;
  List<bool> _isActive = [true, false, false, false];
  List<String> _isActiveString = ['전화번호 인증', '이용약관 동의', '회원정보', '학생증 인증'];
  List<StepState> _stepState = [
    StepState.editing,
    StepState.disabled,
    StepState.disabled,
    StepState.disabled
  ];

  int _currentStep = 0;


  void onNextStep() {
    if (_currentStep < _stepLength - 1) {
      _stepState[_currentStep] = StepState.complete;
      _stepState[_currentStep + 1] = StepState.editing;
      _isActive[_currentStep] = false;
      _isActive[_currentStep + 1] = true;
      _currentStep = _currentStep + 1;
    } else {
      _stepState[_currentStep] = StepState.complete;
    }
    notifyListeners();
  }

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

  List<bool> get isActive => _isActive;

  List<String> get isActiveString => _isActiveString;

  List<StepState> get stepState => _stepState;

  int get currentStep => _currentStep;
}
