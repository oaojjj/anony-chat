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
  Future<Billings> addCard(customerUid) async {
    final url = '$HOST/api/v1/card/add';
    headers['Content-Type'] = 'application/json; charset=utf-8';

    String json = jsonEncode({
      'customer_uid': customerUid,
    });

    return Billings.fromJson(
        await HttpController.instance.httpPost(url, headers, data: json));
  }
}
