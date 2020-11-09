import 'dart:convert';

import 'package:anony_chat/controller/http_controller.dart';
import 'package:anony_chat/model/card/card_add.dart';
import 'package:anony_chat/model/payment/payment_state.dart';
import 'package:anony_chat/model/payment/payment_unschedule.dart';
import 'package:anony_chat/utils/utill.dart';

class PaymentHttpModel {
  // 결제 요청
  Future<CardAdd> paymentBillings(amount, customerUid) async {
    final url = '$HOST/api/v1/payment/billings';
    headers['Content-Type'] = 'application/json; charset=utf-8';

    String json = jsonEncode({
      'amount': amount,
      'customer_uid': customerUid,
    });

    print('json:${json.toString()}');

    return CardAdd.fromJson(
        await HttpController.instance.httpPost(url, headers, data: json));
  }

  // 결제 요청 이슈
  Future<CardAdd> issueBillings(amount, customerUid) async {
    final url = '$HOST/api/v1/payment/billings';
    headers['Content-Type'] = 'application/json; charset=utf-8';

    String json = jsonEncode({
      'amount': amount,
      'customer_uid': customerUid,
    });

    print('json:${json.toString()}');

    return CardAdd.fromJson(
        await HttpController.instance.httpPost(url, headers, data: json));
  }

  // 결제 예약 취소
  Future<PaymentUnSchedule> paymentUnSchedule(customerUid) async {
    final url = '$HOST/api/v1/payment/unschedule';
    headers['Content-Type'] = 'application/json; charset=utf-8';

    String json = jsonEncode({
      'customer_uid': customerUid,
    });

    print('json:${json.toString()}');

    return PaymentUnSchedule.fromJson(
        await HttpController.instance.httpPost(url, headers, data: json));
  }

  // 결제 상태
  Future<PaymentState> getPaymentState() async {
    final url = '$HOST/api/v1/payment';
    headers['Content-Type'] = 'application/json; charset=utf-8';

    return PaymentState.fromJson(
        await HttpController.instance.httpGet(url, headers));
  }
}
