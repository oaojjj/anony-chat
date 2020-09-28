import 'package:anony_chat/provider/register_provider.dart';
import 'package:anony_chat/ui/view/intro/auth/student_card_authorization_tap.dart';
import 'package:anony_chat/ui/widget/bottom_button.dart';
import 'package:anony_chat/ui/widget/loading.dart';
import 'package:anony_chat/viewmodel/member_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth/phone_verification_tap.dart';
import 'auth/register_tap.dart';
import 'auth/terms_of_service_tap.dart';

class AuthAndRegisterPage extends StatefulWidget {
  @override
  _AuthAndRegisterPageState createState() => _AuthAndRegisterPageState();
}

class _AuthAndRegisterPageState extends State<AuthAndRegisterPage> {
  final _memberModel = MemberModel();

  bool _loading = false;

  // 휴대폰 인증, 약관동의, 회원정보입력, 학생증 인증
  List<Step> _steps = [];
  final _tapList = [
    PhoneVerificationTap(),
    TermsOfServiceTap(),
    RegisterTap(),
    SCAuthorizationTap()
  ];

  _makeSteps() {
    _steps.clear();
    final rsp = Provider.of<RegisterProvider>(context, listen: false);

    for (int i = 0; i < _tapList.length; i++) {
      _steps.add(Step(
          title: rsp.stepState[i] == StepState.editing
              ? Text(rsp.isActiveString[i], style: TextStyle(fontSize: 16))
              : Container(),
          content: _tapList[i],
          isActive: rsp.isActive[i],
          state: rsp.stepState[i]));
    }
    return _steps;
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Loading()
        : SafeArea(
            child: WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    color: Colors.black,
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => onBackPressed(),
                  ),
                  backgroundColor: Colors.white10,
                  title: Text('회원가입', style: TextStyle(color: Colors.black)),
                  elevation: 0,
                  centerTitle: true,
                ),
                body: Consumer<RegisterProvider>(
                  builder: (_, rp, __) => Stepper(
                    type: StepperType.horizontal,
                    currentStep: rp.currentStep,
                    steps: _makeSteps(),
                    onStepTapped: null,
                    onStepContinue: () async {
                      if (!rp.canRegister)
                        rp.onContinueStep();
                      else {
                        setState(() => _loading = true);
                        await _register(rp, context);
                      }
                    },
                    controlsBuilder: (context, {onStepCancel, onStepContinue}) {
                      return Center(
                        child: BottomButton(
                          onPressed: rp.canNextStep ? onStepContinue : null,
                          text: rp.currentStep != _steps.length - 1 ? '다음' : '가입하기',
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
  }

  // TODO 모든 예외처리 하기
  Future _register(RegisterProvider rp, BuildContext context) async {
    await _memberModel.register(rp.member).then((value) =>
        Navigator.of(context).pushNamedAndRemoveUntil('/main', (route) => false));
  }

  bool onBackPressed() {
    final rsp = Provider.of<RegisterProvider>(context, listen: false);
    if (rsp.currentStep == 0) {
      Navigator.pop(context);
      return true;
    } else {
      rsp.onPrevStep();
      return false;
    }
  }
}
