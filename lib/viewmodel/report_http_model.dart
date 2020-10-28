import 'dart:convert';

import 'package:anony_chat/controller/http_controller.dart';
import 'package:anony_chat/model/report/report_list.dart';
import 'package:anony_chat/model/report/report_type.dart';
import 'package:anony_chat/model/report/reported_list.dart';
import 'package:anony_chat/model/report/user_report.dart';
import 'package:anony_chat/utils/utill.dart';

class ReportHttpModel {
  // 신고타입 가져오기
  Future<ReportType> requestReportType() async {
    final url = '$HOST/api/v1/common/report_type';
    headers['Content-Type'] = 'application/json; charset=utf-8';

    return ReportType.fromJson(
        await HttpController.instance.httpGet(url, headers));
  }

  // 신고하기
  Future<UserReport> report(String reportType, int id) async {
    final url = '$HOST/api/v1/report';
    headers['Content-Type'] = 'application/json; charset=utf-8';

    String json = jsonEncode({"report_type": reportType, "user_id": id});

    print('requestReport $json');
    return UserReport.fromJson(
        await HttpController.instance.httpPost(url, headers, data: json));
  }

  // 신고한 내역 가져오기
  Future<ReportList> getReportList({int page, int limit}) async {
    final url = '$HOST/api/v1/report/sue_list?page=$page';
    headers['Content-Type'] = 'application/json; charset=utf-8';

    print('requestReportList $json');
    return ReportList.fromJson(
        await HttpController.instance.httpGet(url, headers));
  }

  // 신고당한 내역 가져오기
  Future<ReportedList> getReportedList({int page, int limit}) async {
    final url = '$HOST/api/v1/report/be_sued_list?page$page';
    headers['Content-Type'] = 'application/json; charset=utf-8';

    print('requestReportedList $json');
    return ReportedList.fromJson(
        await HttpController.instance.httpGet(url, headers));
  }
}
