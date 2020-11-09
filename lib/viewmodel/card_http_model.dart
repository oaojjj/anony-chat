import 'dart:convert';

import 'package:anony_chat/controller/http_controller.dart';
import 'package:anony_chat/model/card/card_add.dart';
import 'package:anony_chat/model/card/card_list.dart';
import 'package:anony_chat/utils/utill.dart';

class CardHttpModel {
  // 카드리스트 불러오기
  Future<CardList> getCardList() async {
    final url = '$HOST/api/v1/card/list';
    headers['Content-Type'] = 'application/json; charset=utf-8';

    return CardList.fromJson(
        await HttpController.instance.httpGet(url, headers));
  }

  // 카드정보 추가
  Future<CardAdd> addCard(customerUid) async {
    final url = '$HOST/api/v1/card/add';
    headers['Content-Type'] = 'application/json; charset=utf-8';

    String json = jsonEncode({
      'customer_uid': customerUid,
    });

    return CardAdd.fromJson(
        await HttpController.instance.httpPost(url, headers, data: json));
  }

  // 카드정보(api) 추가
  addImportApiCard({cardNumber, expiry, birth, pwd2Digit, customerUid}) async {
    final token = await getToken();
    print("token:${token.toString()}");
    print('accessToken:${token['response']['access_token']}');
    final url = 'https://api.iamport.kr/subscribe/customers/$customerUid';
    headers['Content-Type'] = 'application/json; charset=utf-8';
    headers['Authorization'] = token['response']['access_token'];

    String json = jsonEncode({
      'card_number': cardNumber,
      'expiry': expiry,
      'birth': birth,
      'pwd_2digit': pwd2Digit,
    });

    return await HttpController.instance.httpPost(url, headers, data: json);
  }

  getToken() async {
    final url = 'https://api.iamport.kr/users/getToken';
    headers['Content-Type'] = 'application/json';

    String json = jsonEncode({
      'imp_key': IMP_KEY,
      'imp_secret': IMP_SECRET,
    });

    return await HttpController.instance.httpPost(url, headers, data: json);
  }
}
