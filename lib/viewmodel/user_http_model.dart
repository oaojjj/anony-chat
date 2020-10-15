import 'dart:convert';

import 'package:anony_chat/controller/http_controller.dart';
import 'package:anony_chat/model/dao/member.dart';
import 'package:anony_chat/model/user/user_info.dart';
import 'package:anony_chat/utils/utill.dart';

class UserHttpModel {
  //로그인 POST
  Future<UserInfo> userEdit(Member member,{int imageCode}) async {
    final url = '$HOST/api/v1/auth/signin';
    headers['Content-Type'] = 'application/json; charset=utf-8';

    String json = jsonEncode({
      'num': member.phoneNumber,
      'address': member.city,
      'school_matching': member.isNotMatchingSameUniversity ? 1 : 0,
      'department_matching': member.isNotMatchingSameDepartment ? 1 : 0,
      'provide': member.isShowMyInfo ? 1 : 0,
    });
    print('requestSingIn: $json');
    return UserInfo.fromJson(
        await HttpController.instance.httpPost(url, headers, data: json));
  }
}
