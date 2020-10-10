import 'package:anony_chat/model/dao/member.dart';
import 'package:flutter/foundation.dart';
import 'package:kakao_flutter_sdk/all.dart';

enum RegisterState { canNotRegister, canRegister }

class RegisterProvider extends ChangeNotifier {
  Member _member = Member();

  bool _isCanRegister = false;

  bool get isCanRegister => _isCanRegister;

  Member get member => _member; // 최종 회원가입 상태

  checkCanRegister() {
    if (member.university != null &&
        member.major != null &&
        member.studentID != null &&
        member.studentID.toString().length >= 7 &&
        member.city != null &&
        member.city != '선택') {
      canRegister();
    } else {
      cantRegister();
    }
    print(_isCanRegister);
  }

  canRegister() {
    _isCanRegister = true;
    notifyListeners();
  }

  cantRegister() {
    _isCanRegister = false;
    notifyListeners();
  }

  reset() {
    print('register provider reset');
    _isCanRegister = false;
    _member = Member();
  }

  setMemberInfoWithKakao(Account kakaoAccount) {
    _member.gender = kakaoAccount.gender == Gender.MALE ? '남자' : '여자';
    _member.birthYear = kakaoAccount.birthyear;
    _member.phoneNumber = kakaoAccount.phoneNumber;
  }

  onCheckShowMyInfo() {
    member.isShowMyInfo = !member.isShowMyInfo;
    notifyListeners();
  }

  onCheckNotMatchingSameMajor() {
    member.isNotMatchingSameMajor = !member.isNotMatchingSameMajor;
    notifyListeners();
  }

  onCheckNotMatchingSameUniversity() {
    member.isNotMatchingSameUniversity = !member.isNotMatchingSameUniversity;
    notifyListeners();
  }

  setStudentID(int id) {
    _member.studentID = id;
  }

  setUniversityInfo(String data, String type) {
    if (type == '학교')
      _member.university = data;
    else
      _member.major = data;
  }

  setCity(String data) {
    _member.city = data;
  }

  setFCMToken(String fcmToken) {
    _member.fcmToken = fcmToken;
  }

  setStudentCardImagePath(String path) {
    _member.studentCardImagePath = path;
  }
}
