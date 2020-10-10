import 'dart:convert';

import 'package:anony_chat/controller//hive_controller.dart';
import 'package:anony_chat/model/dao/member.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class MemberModel {
  static final FirebaseAuth _mAuth = FirebaseAuth.instance;
  static final FirebaseDatabase _db = FirebaseDatabase.instance;
  static final FirebaseFirestore _fdb = FirebaseFirestore.instance;

  static const String USERS_COLLECTION = 'users';
  static const String USER_IDS_COLLECTION = 'user_ids';

  // 가입하기
  Future<void> register(Member member) async {
    member.id = 2;

    // 마지막 회원번호를 불러오고 회원 카운트 증가

    // 프로필 로컬 저장, 학생증 서버에 업로드
    HiveController.instance.saveMemberInfoToLocal(member);

    // 회원 정보 등록(최종회원가입)
    // 일단 파이어베이스에서 테스트
    await _fdb
        .collection(USERS_COLLECTION)
        .doc('${member.id}')
        .set(member.toJson());

    // ApiRegister(member.toJson())
    // await HiveController.instance.onRegisterCompleted();
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
        .child('${fixProfile.id}')
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
