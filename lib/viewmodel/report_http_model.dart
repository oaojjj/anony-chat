import 'dart:convert';

import 'package:anony_chat/controller/http_controller.dart';
import 'package:anony_chat/model/report/report_type.dart';
import 'package:anony_chat/utils/utill.dart';

class ReportHttpModel{

  Future<ReportType> requestReportType() async {
    final url = '$HOST/api/v1/common/report_type';
    headers['Content-Type'] = 'application/json; charset=utf-8';

    return ReportType.fromJson(
        await HttpController.instance.httpGet(url, headers));
  }

}