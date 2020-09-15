import 'package:anony_chat/provider/register_provider.dart';
import 'package:anony_chat/provider/register_step_provider.dart';
import 'package:anony_chat/ui/view/intro/auth/student_card_authorization_tap.dart';
import 'package:anony_chat/ui/widget/bottom_button.dart';
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
  List<Step> _steps;

  List<Step> makeSteps() {
    final rsp = Provider.of<RegisterStepProvider>(context);
    _steps = [
      Step(
          title: Container(),
          content: PhoneVerificationTap(),
          isActive: rsp.isActive[0],
          state: rsp.stepState[0]),
      Step(
          title: Container(),
          content: TermsOfServiceTap(),
          isActive: rsp.isActive[1],
          state: rsp.stepState[1]),
      Step(
          title: Container(),
          content: RegisterTap(),
          isActive: rsp.isActive[2],
          state: rsp.stepState[2]),
      Step(
          title: Container(),
          content: SCAuthorizationTap(),
          isActive: rsp.isActive[3],
          state: rsp.stepState[3]),
    ];
    return _steps;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async => onBackPressed(),
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              color: Colors.black,
              icon: Icon(Icons.arrow_back),
              onPressed: () => onBackPressed(),
            ),
            backgroundColor: Colors.white,
            title: Consumer<RegisterStepProvider>(
              builder: (context, RegisterStepProvider value, _) => Text(
                value.isActiveString[value.currentStep],
                style: TextStyle(color: Colors.black),
              ),
            ),
            elevation: 0,
            centerTitle: true,
          ),
          body: Stepper(
            type: StepperType.horizontal,
            currentStep: Provider.of<RegisterStepProvider>(context).currentStep,
            steps: makeSteps(),
            onStepTapped: null,
            onStepContinue: () =>
                Provider.of<RegisterStepProvider>(context, listen: false)
                    .onNextStep(),
            controlsBuilder: (context, {onStepCancel, onStepContinue}) {
              return Center(
                  child: Consumer<RegisterProvider>(
                builder: (context, RegisterProvider value, child) =>
                    BottomButton(
                  onPressed: value.stepState ? onStepContinue : null,
                  text:
                      Provider.of<RegisterStepProvider>(context).currentStep !=
                              _steps.length - 1
                          ? '다음'
                          : '가입하기',
                ),
              ));
            },
          ),
        ),
      ),
    );
  }

  bool onBackPressed() {
    final rsp = Provider.of<RegisterStepProvider>(context, listen: false);
    if (rsp.currentStep == 0) {
      Navigator.pop(context);
      return true;
    } else {
      rsp.onPrevStep();
      return false;
    }
  }
}
