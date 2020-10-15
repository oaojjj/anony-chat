import 'dart:convert';

import 'package:anony_chat/controller/hive_controller.dart';
import 'package:anony_chat/model/dao/member.dart';
import 'package:anony_chat/utils/utill.dart';
import 'package:anony_chat/viewmodel/file_http_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'auth_http_model.dart';

class MemberModel {
  static final FirebaseAuth _mAuth = FirebaseAuth.instance;
  static final FirebaseDatabase _db = FirebaseDatabase.instance;
  static final FirebaseFirestore _fdb = FirebaseFirestore.instance;

  static const String USERS_COLLECTION = 'users';
  static const String USER_IDS_COLLECTION = 'user_ids';
  AuthHttpModel _authHttpModel = AuthHttpModel();

  // 가입하기
  Future<bool> register(Member member) async {
    print(member.toString());

    // 서버에 사용자 정보로 회원가입
    final signUpResult =
        await _authHttpModel.requestSingUp("anonymous_chat", member);

    if (signUpResult.code == ResponseCode.SUCCESS_CODE) {
      print('#회원가입 성공');
      print('#회원번호: ${signUpResult.data.item[0]}');
      member.userID = signUpResult.data.item[0];

      // 프로필 로컬 저장
      HiveController.instance.saveMemberInfoToLocal(member);
      return true;
    } else {
      print('#회원가입 실패');
      print(signUpResult.toJson());
      return false;
    }

    // 일단 파이어베이스에서 테스트
    /* await _fdb
        .collection(USERS_COLLECTION)
        .doc('${member.userID}')
        .set(member.toJson());
     */
  }

  // 전체 회원 수 가져오기
  static Future<int> getTotalMemberCount() async {
    final snapshot = await _db.reference().child(USER_IDS_COLLECTION).once();
    return snapshot.value['count'] ?? 0;
  }

  // 회원 id 가져오기
  static Future<int> getMemberID(String uid) async {
    final snapshot =
        await _db.reference().child(USER_IDS_COLLECTION).child('id').once();
    return snapshot.value['$uid'];
  }

  // 회원 uid 가져오기
  static Future<String> getMemberUid(int id) async {
    final snapshot =
        await _db.reference().child(USER_IDS_COLLECTION).child('uid').once();
    return snapshot.value['$id'];
  }

  static Future<int> getLastNumberID() async {
    final snapshot = await _db.reference().child(USER_IDS_COLLECTION).once();
    return snapshot.value['lastNumber'] ?? 0;
  }

  static Future<String> getMemberSex(int id) async {
    final snapshot = await _db
        .reference()
        .child(USERS_COLLECTION)
        .child('$id')
        .child('sex')
        .once();
    return snapshot.value;
  }

  static Future<String> getMemberAuthorization(int id) async {
    final snapshot = await _db
        .reference()
        .child(USERS_COLLECTION)
        .child('$id')
        .child('authorization')
        .once();

    return snapshot.value;
  }

  // 회원 프로필 수정하기
  Future<Member> updateProfile(Member fixProfile) async {
    HiveController.instance.saveMemberInfoToLocal(fixProfile);

    await _db
        .reference()
        .child(USERS_COLLECTION)
        .child('${fixProfile.userID}')
        .update(fixProfile.toJson());

    return fixProfile;
  }

  // 남은 메시지 조회
  static Future<int> getPossibleMessageOfSend() async {
    final snapshot = await _db
        .reference()
        .child(USERS_COLLECTION)
        .child(
            '${await getMemberID(_mAuth.currentUser.uid)}/possibleMessageOfSend')
        .once();

    return snapshot.value;
  }

  // 회원 프로필 가져오기
  Future<Member> loadProfile() async {
    final snapshot = await _db
        .reference()
        .child(USERS_COLLECTION)
        .child('${_mAuth.currentUser.uid}')
        .once();

    final responseData = json.decode(snapshot.value);

    return Member.fromJson(responseData);
  }

  Future<void> updateTotalMember() async => _db
      .reference()
      .child(USER_IDS_COLLECTION)
      .update({'count': await getTotalMemberCount() + 1});
}
