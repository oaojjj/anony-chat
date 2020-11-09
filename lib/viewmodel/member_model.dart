import 'package:anony_chat/controller/hive_controller.dart';
import 'package:anony_chat/model/dao/member.dart';
import 'package:anony_chat/model/user/user_info_edit.dart';
import 'package:anony_chat/utils/utill.dart';
import 'package:anony_chat/viewmodel/file_http_model.dart';
import 'package:anony_chat/viewmodel/user_http_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'auth_http_model.dart';

class MemberModel {
  static final FirebaseFirestore _fdb = FirebaseFirestore.instance;

  static const String USERS_COLLECTION = 'users';

  AuthHttpModel _authHttpModel = AuthHttpModel();
  FileHttpModel _fileHttpModel = FileHttpModel();
  UserHttpModel _userHttpModel = UserHttpModel();

  // 가입하기
  Future<bool> register(Member member) async {
    print(member.toString());

    // 서버에 사용자 정보로 회원가입
    final signUpResult = await _authHttpModel.requestSingUp("kakao", member);

    if (signUpResult.code == ResponseCode.SUCCESS_CODE) {
      print('#회원가입 - 멤버정보 입력');

      headers['token'] = signUpResult.data.item[0]['token'];
      member.userID = signUpResult.data.item[0]['id'];

      print('#jwt토큰: ${signUpResult.data.item[0]['token']}');
      print('#회원번호: ${signUpResult.data.item[0]['id']}');

      print('#학생증 업로드');
      final uploadResult =
          await _fileHttpModel.uploadFile(file: member.studentCardImage);

      if (uploadResult.success) {
        UserInfoEdit userEditResult = await _userHttpModel.userEdit(member,
            imageCode: uploadResult.data.item[0]);

        if (userEditResult.code == ResponseCode.SUCCESS_CODE) {
          print('#학생증 업로드 성공');
          print('#최종 회원가입 성공');
          member.studentImageNumber = uploadResult.data.item[0];

          // 프로필 로컬 저장, fcmToken 업데이트
          HiveController.instance.saveMemberInfoToLocal(member);
          updateFcmToken(member.userID, member.fcmToken);
          return true;
        } else {
          print('#학생증 업로드 파일 실패');
          return false;
        }
      } else {
        print('#학생증 업로드 에디트 실패');
        return false;
      }
    } else {
      print('#회원가입 실패 - 멤버정보 입력 실패');
      print(signUpResult.toJson());
      return false;
    }
  }

  // 회원 프로필 수정하기
  Future<bool> updateProfile(Member fixProfile) async {
    UserInfoEdit userEditResult = await _userHttpModel.userEdit(fixProfile,
        imageCode: fixProfile.studentImageNumber);
    if (userEditResult.code == ResponseCode.SUCCESS_CODE) {
      HiveController.instance.saveMemberInfoToLocal(fixProfile);
      return true;
    } else {
      return false;
    }
  }

  Future<void> updateFcmToken(int id, String fcmToken) async {
    _fdb
        .collection(USERS_COLLECTION)
        .doc(id.toString())
        .set({'fcmToken': fcmToken});
  }
}
