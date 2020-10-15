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
        member.department != null &&
        member.studentID != null &&
        member.studentID.toString().length >= 7 &&
        member.city != null &&
        member.city != '선택' &&
        member.studentCardImage != null) {
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
    _member.city = null;
    _member.university = null;
    _member.department = null;
    _member.studentID = null;
    _member.studentCardImage = null;
    _member.isShowMyInfo = false;
    _member.isNotMatchingSameDepartment = false;
    _member.isNotMatchingSameUniversity = false;
  }

  setMemberInfoWithKakao(User user) {
    _member.authID = user.id.toString();
    _member.gender = user.kakaoAccount.gender == Gender.MALE ? '남자' : '여자';
    _member.birthYear = int.parse(user.kakaoAccount.birthyear ?? "-1");
    _member.phoneNumber = user.kakaoAccount.phoneNumber;
  }

  onCheckShowMyInfo() {
    member.isShowMyInfo = !member.isShowMyInfo;
    notifyListeners();
  }

  onCheckNotMatchingSameMajor() {
    member.isNotMatchingSameDepartment = !member.isNotMatchingSameDepartment;
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
      _member.department = data;
  }

  setCity(String data) {
    _member.city = data;
  }

  setFCMToken(String fcmToken) {
    _member.fcmToken = fcmToken;
  }

  setStudentCardImage(image) {
    _member.studentCardImage = image;
  }
}
