import 'dart:convert';

import 'package:anony_chat/controller/http_controller.dart';
import 'package:anony_chat/model/dao/member.dart';
import 'package:anony_chat/model/user/user_info.dart';
import 'package:anony_chat/model/user/user_info_edit.dart';
import 'package:anony_chat/utils/utill.dart';

class UserHttpModel {
  // 유저 정보 변경 POST
  Future<UserInfoEdit> userEdit(Member member, {int imageCode}) async {
    final url = '$HOST/api/v1/users/edit';
    headers['Content-Type'] = 'application/json; charset=utf-8';

    print(headers['Content-Type']);
    print(headers['token']);

    String json = jsonEncode({
      'num': member.phoneNumber,
      'address': member.city,
      'school_matching': member.isNotMatchingSameUniversity ? 1 : 0,
      'img': imageCode,
      'department_matching': member.isNotMatchingSameDepartment ? 1 : 0,
      'provide': member.isShowMyInfo ? 0 : 1,
    });
    print('requestUserEdit: $json');
    return UserInfoEdit.fromJson(
        await HttpController.instance.httpPost(url, headers, data: json));
  }

  // 유저 정보 가져오기
  Future<UserInfo> getUserInfo() async {
    final url = '$HOST/api/v1/users/item';
    headers['Content-Type'] = 'application/json; charset=utf-8';

    print('requestUserInfo: $json');
    return UserInfo.fromJson(
        await HttpController.instance.httpGet(url, headers));
  }
}
