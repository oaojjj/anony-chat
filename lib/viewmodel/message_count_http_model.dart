import 'dart:convert';

import 'package:anony_chat/controller/http_controller.dart';
import 'package:anony_chat/model/message/message_count.dart';
import 'package:anony_chat/utils/utill.dart';

class MessageCountHttpModel {
  // 현재 남은 매칭횟수
  Future<MessageCount> getMsgCount() async {
    final url = '$HOST/api/v1/msg_count';
    headers['Content-Type'] = 'application/json; charset=utf-8';

    return MessageCount.fromJson(
        await HttpController.instance.httpGet(url, headers));
  }

  // 광고 시청 후 횟수 증가
  Future<MessageAdd> addMsgCount() async {
    final url = '$HOST/api/v1/msg_count/add';
    headers['Content-Type'] = 'application/json; charset=utf-8';

    return MessageAdd.fromJson(
        await HttpController.instance.httpGet(url, headers));
  }
}
