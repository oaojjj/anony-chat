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
  static final _focusNode = [FocusNode(), FocusNode()];
  final _memberModel = MemberModel();

  bool _loading = false;

  // 휴대폰 인증, 약관동의, 회원정보입력, 학생증 인증
  List<Step> _steps = [];
  final _tapList = [
    PhoneVerificationTap(_focusNode),
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<RegisterProvider>(context, listen: false).reset();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Loading()
        : SafeArea(
            child: WillPopScope(
              onWillPop: () => onBackPressed(),
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
                      if (!rp.canRegister) {
                        rp.onContinueStep();
                      } else {
                        setState(() => _loading = true);
                        await _register(rp, context);
                      }
                    },
                    controlsBuilder: (context, {onStepCancel, onStepContinue}) {
                      return Center(
                        child: BottomButton(
                          onPressed: rp.canNextStep ? onStepContinue : null,
                          text: rp.currentStep != _steps.length - 1
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

  // TODO 모든 예외처리 하기
  Future _register(RegisterProvider rp, BuildContext context) async {
    await _memberModel.register(rp.member).then((value) => Navigator.of(context)
        .pushNamedAndRemoveUntil('/main', (route) => false));
  }

  onBackPressed() {
    final rsp = Provider.of<RegisterProvider>(context, listen: false);
    if (rsp.currentStep <= 2) {
      _focusNode[0].unfocus();
      _focusNode[1].unfocus();
      _showDialogAllDataDelete();
    } else {
      rsp.onPrevStep();
    }
  }

  // 첫 페이지에서 뒤로가기 하면 모든 데이터가 삭제된다고 알림 띄우기
  Future<void> _showDialogAllDataDelete() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (_) {
        return AlertDialog(
          title: Text('주의'),
          content: Text('처음부터 다시 작성하셔야 합니다. \n그래도 뒤로가겠습니까?'),
          actions: <Widget>[
            FlatButton(
              child: Text('취소', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('확인', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.popUntil(
                    context, ModalRoute.withName(Navigator.defaultRouteName));
              },
            ),
          ],
        );
      },
    );
  }
}
