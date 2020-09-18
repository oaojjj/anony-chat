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

  List<Step> _steps = [];
  final tapList = [
    PhoneVerificationTap(),
    TermsOfServiceTap(),
    RegisterTap(),
    SCAuthorizationTap()
  ];

  makeSteps() {
    _steps.clear();
    final rsp = Provider.of<RegisterProvider>(context, listen: false);

    for (int i = 0; i < tapList.length; i++) {
      _steps.add(Step(
          title: rsp.stepState[i] == StepState.editing
              ? Text(rsp.isActiveString[i], style: TextStyle(fontSize: 16))
              : Container(),
          content: tapList[i],
          isActive: rsp.isActive[i],
          state: rsp.stepState[i]));
    }
    return _steps;
  }

  @override
  void initState() {
    super.initState();
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
                  builder: (_, value, __) => Stepper(
                    type: StepperType.horizontal,
                    currentStep: value.currentStep,
                    steps: makeSteps(),
                    onStepTapped: null,
                    onStepContinue: () async {
                      if (!value.canRegister) value.onContinueStep();
                      else {
                        setState(() => _loading = true);
                        await _memberModel.register(value.member).then(
                            (value) => Navigator.of(context)
                                .pushNamedAndRemoveUntil(
                                    '/main', (route) => false));
                      }
                    },
                    controlsBuilder: (context, {onStepCancel, onStepContinue}) {
                      return Center(
                        child: BottomButton(
                          onPressed: value.canNextStep ? onStepContinue : null,
                          text: value.currentStep != _steps.length - 1
                              ? '다음'
                              : '가입하기',
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
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
