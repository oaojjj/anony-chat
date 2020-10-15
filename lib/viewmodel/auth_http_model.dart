import 'dart:convert';

import 'package:anony_chat/controller/http_controller.dart';
import 'package:anony_chat/model/auth/auth_sign_in.dart';
import 'package:anony_chat/model/auth/auth_sign_up.dart';
import 'package:anony_chat/model/dao/member.dart';
import 'package:anony_chat/utils/utill.dart';

class AuthHttpModel {
  //로그인 POST
  Future<AuthSignIn> requestSingIn(String provider, String authId) async {
    final url = '$HOST/api/v1/auth/signin';
    headers['Content-Type'] = 'application/json; charset=utf-8';

    String json = jsonEncode({'provider': provider, 'auth_id': authId});
    print('requestSingIn: $json');
    return AuthSignIn.fromJson(
        await HttpController.instance.httpPost(url, headers, data: json));
  }

  //회원가입 POST
  Future<AuthSignUp> requestSingUp(String provider, Member member) async {
    final url = '$HOST/api/v1/auth/signup';
    headers['Content-Type'] = 'application/json; charset=utf-8';

    String json = jsonEncode({
      'provider': provider,
      'auth_id': member.authID ?? "null",
      'num': member.phoneNumber ?? "null",
      'gender': member.gender == '남자' ? 1 : 2,
      'birth_year': member.birthYear ?? -1,
      'address': member.city ?? "null",
      'school': member.university ?? "null",
      'department': member.department ?? "null",
      'student_id': member.studentID ?? -1,
      'school_matching': member.isNotMatchingSameUniversity ? 1 : 0,
      'department_matching': member.isNotMatchingSameDepartment ? 1 : 0,
      'provide': member.isShowMyInfo ? 1 : 0,
    });

    print('requestSingUp $json');
    return AuthSignUp.fromJson(
        await HttpController.instance.httpPost(url, headers, data: json));
  }
}
