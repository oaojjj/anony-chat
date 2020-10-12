import 'package:flutter/material.dart';

const HOST = 'https://unim.chaeft.com';

Map headers = Map<String,String>();

const Color chatPrimaryColor = Color.fromRGBO(81, 17, 243, 1);
const Color chatAccentColor = Color.fromRGBO(100, 70, 245, 1);

class ResponseCode{
  static const SUCCESS_CODE = 1000;                 /// 정상실행
  static const DATA_NOT_FOUND = 1001;                 /// 반환받을 값 없음
  static const ALREADY_SIGN_UP = 1002;                 /// 이미 가입된 사용자 존재
  static const UPLOAD_FAILED = 1003;                 /// 업로드실패

}
