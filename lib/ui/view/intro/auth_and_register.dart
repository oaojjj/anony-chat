import 'package:anony_chat/ui/view/intro/auth/student_card_certification_tap.dart';
import 'package:anony_chat/ui/widget/bottom_button.dart';
import 'package:flutter/material.dart';

import 'auth/phone_verification_tap.dart';
import 'auth/register_tap.dart';
import 'auth/terms_of_service_tap.dart';

class AuthAndRegisterPage extends StatefulWidget {
  @override
  _AuthAndRegisterPageState createState() => _AuthAndRegisterPageState();
}

class _AuthAndRegisterPageState extends State<AuthAndRegisterPage> {
  List<bool> _isActive = [true, false, false, false];
  List<Step> _steps;
  List<String> _isActiveString = ['전화번호 인증', '이용약관 동의', '회원정보', '학생증 인증'];
  int _currentStep = 0;

  List<Step> makeSteps() {
    _steps = [
      Step(
          title: Container(),
          content: PhoneVerificationTap(),
          isActive: _isActive[0]),
      Step(
          title: Container(),
          content: TermsOfServiceTap(),
          isActive: _isActive[1]),
      Step(title: Container(), content: RegisterTap(), isActive: _isActive[2]),
      Step(title: Container(), content: SCCertificationTap(), isActive: _isActive[3]),
    ];
    return _steps;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          if (_currentStep == 0) {
            return true;
          } else {
            setState(() {
              if (_currentStep > 0) {
                _isActive[_currentStep] = false;
                _currentStep = _currentStep - 1;
                _isActive[_currentStep] = true;
              } else {
                _currentStep = 0;
              }
            });
            return false;
          }
        },
        child: Scaffold(
          appBar: AppBar(
              leading: IconButton(
                  color: Colors.black,
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    onStepCancel();
                  }),
              backgroundColor: Colors.white,
              title: Text(_isActiveString[_currentStep],
                  style: TextStyle(color: Colors.black)),
              elevation: 0,
              centerTitle: true),
          body: Stepper(
            type: StepperType.horizontal,
            currentStep: _currentStep,
            steps: makeSteps(),
            onStepTapped: null,
            onStepContinue: () {
              setState(() {
                if (_currentStep < _steps.length - 1) {
                  _isActive[_currentStep] = false;
                  _isActive[_currentStep + 1] = true;
                  _currentStep = _currentStep + 1;
                } else {
                  _isActive[_currentStep] = false;
                  _currentStep = 0;
                  _isActive[_currentStep] = true;
                }
              });
            },
            controlsBuilder: (context, {onStepCancel, onStepContinue}) {
              return Center(
                  child: BottomButton(
                onPressed: onStepContinue,
                text: '다음',
              ));
            },
          ),
        ),
      ),
    );
  }

  void onStepCancel() {
    if (_currentStep == 0)
      Navigator.pop(context);
    else {
      setState(() {
        if (_currentStep > 0) {
          _isActive[_currentStep] = false;
          _currentStep = _currentStep - 1;
          _isActive[_currentStep] = true;
        } else {
          _currentStep = 0;
        }
      });
    }
  }
}
