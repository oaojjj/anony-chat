import 'package:anony_chat/controller/hive_controller.dart';
import 'package:anony_chat/utils/utill.dart';
import 'package:anony_chat/viewmodel/payment_http_model.dart';
import 'package:flutter/material.dart';

/* 아임포트 결제 모듈을 불러옵니다. */
import 'package:iamport_flutter/iamport_payment.dart';
/* 아임포트 결제 데이터 모델을 불러옵니다. */
import 'package:iamport_flutter/model/payment_data.dart';

/* 상용모드는 따로 설정 필요
* example: https://github.com/iamport/iamport-manual/blob/master/%EB%B9%84%EC%9D%B8%EC%A6%9D%EA%B2%B0%EC%A0%9C/example/kakaopay-request-billing-key.md
*/
class Payment extends StatelessWidget {
  Payment({this.pg, this.customerUid});

  final _paymentHttpModel = PaymentHttpModel();
  final pg;
  final amount =1;
  final customerUid;
  static const USER_CODE = 'imp50062885';
  final _member = HiveController.instance.loadMemberInfoToLocal();

  @override
  Widget build(BuildContext context) {
    print('$pg+$customerUid');
    return IamportPayment(
      /* 웹뷰 로딩 컴포넌트 */
      initialChild: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/iamport-logo.png'),
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                child: Text('잠시만 기다려주세요...', style: TextStyle(fontSize: 20.0)),
              ),
            ],
          ),
        ),
      ),
      /* [필수입력] 가맹점 식별코드 */
      userCode: USER_CODE,
      /* [필수입력] 결제 데이터 */
      data: PaymentData.fromJson({
        'pg': pg, // PG사
        'payMethod': 'card', // 결제수단
        'name': '월구독 정기결제', // 주문명
        'merchantUid': 'mid_${DateTime.now().millisecondsSinceEpoch}', // 주문번호
        'amount': amount, // 결제금액
        'buyerName': '${_member.userID}', // 구매자 이름
        'buyerTel': '${_member.phoneNumber}', // 구매자 연락처
        'appScheme': 'example',
        'customerUid': customerUid,
        'display': {
          'cardQuota': [2, 3] //결제창 UI 내 할부개월수 제한
        }
      }),
      /* [필수입력] 콜백 함수 */
      callback: (Map<String, String> result) async {
        print('payment callback: $result');
        if (result['imp_success'] == 'false') {
          Navigator.pop(context);
          showToast('월구독 결제에 실패했습니다.');
        } else {
          print('payment:true');
          final paymentResult =
              await _paymentHttpModel.paymentBillings(amount, customerUid);
          if (paymentResult.code == ResponseCode.SUCCESS_CODE) {
            Navigator.popUntil(context, ModalRoute.withName('/main_page'));
            showToast('월구독 결제가 완료되었습니다.');
          } else {
            Navigator.pop(context);
            showToast('월구독 결제에 실패했습니다.');
          }
        }
      },
    );
  }
}
