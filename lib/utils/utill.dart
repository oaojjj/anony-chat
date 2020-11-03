import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

const HOST = 'https://unim.chaeft.com';

Map headers = Map<String, String>();

const Color chatPrimaryColor = Color.fromRGBO(81, 17, 243, 1);
const Color chatAccentColor = Color.fromRGBO(100, 70, 245, 1);

convertTimeToString(int time) {
  final now = DateTime.now();
  final tf = DateTime.fromMillisecondsSinceEpoch(time); // 오늘

  if (now.difference(tf).inHours > 24) {
    if (now.day - tf.day == 1) return '어제';
    if (now.year - tf.year != 0)
      return '${tf.year}년${tf.month}월${tf.day}일';
    else
      return '${tf.month}월${tf.day}일';
  } else {
    return '${tf.hour < 12 ? '오전' : '오후'} ${DateFormat('h:mm').format(tf)}';
  }
}

int convertBirthYearToAge(int birthYear) => DateTime.now().year - birthYear + 1;

void showToast(text, {gravity = ToastGravity.BOTTOM}) {
  Fluttertoast.showToast(
      msg: text,
      gravity: gravity,
      backgroundColor: Colors.black,
      toastLength: Toast.LENGTH_SHORT);
}

class ResponseCode {
  /// 정상실행
  static const SUCCESS_CODE = 1000;

  /// 반환받을 값 없음
  static const DATA_NOT_FOUND = 1001;

  /// 이미 가입된 사용자 존재
  static const ALREADY_SIGN_UP = 1002;

  /// 업로드실패
  static const UPLOAD_FAILED = 1003;

  /// 인자 값 비어있음
  static const EMPTY_PARAMETERS = 2000;

  /// 인자 값 형식오류
  static const INVALID_PARAMETERS = 2001;

  /// 토큰없음
  static const INVALID_TOKEN = 2002;

  /// 권한없음/인증대기중
  static const NOT_AUTHORIZED = 2003;

  /// 인증 반려된 유저
  static const DENIED_AUTHORIZED = 2004;

  /// 사용 정지된 유저
  static const BANNED_USER = 2005;

  /// 허용하지 않는 외부 로그인
  static const NOT_ALLOWED_PROVIDER = 2006;

  /// 권한 확인 실패
  static const AUTHORIZATION_CHECK_FAILURE = 2007;

  /// 횟수 소진
  static const RUN_OUT = 2008;

  /// 매칭 가능한 유저 없음
  static const THERE_ARE_NO_USERS = 2009;

  /// body JSON 형식 오류
  static const JSON_PARSE_ERROR = 4000;

  /// 주소를 찾을 수 없음
  static const NOT_FOUND = 4001;

  /// 알 수 없는 오류
  static const SOMETHING_BROKEN = 5000;
}
