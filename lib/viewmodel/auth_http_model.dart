import 'dart:convert';

import 'package:anony_chat/controller/http_controller.dart';
import 'package:anony_chat/model/auth/auth_sign_in.dart';
import 'package:anony_chat/utils/utill.dart';

class AuthHttpModel {
  //로그인 POST
  Future<AuthSignIn> requestSingIn(String provider, String authId) async {
    final url = '$HOST/api/v1/auth/signin';

    String json = jsonEncode({'provider': provider, 'auth_id': authId});
    print('requestSingIn: $json');
    return AuthSignIn.fromJson(
        await HttpController.instance.httpPost(url, headers, data: json));
  }
}
