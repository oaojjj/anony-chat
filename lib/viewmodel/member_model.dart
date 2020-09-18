import 'dart:convert';

import 'package:anony_chat/database/shared_preferences_controller.dart';
import 'package:anony_chat/model/dao/member.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class MemberModel {
  static final FirebaseAuth _mAuth = FirebaseAuth.instance;
  static final FirebaseDatabase _db = FirebaseDatabase.instance;

  static const String USERS_TABLE = 'users';
  static const String USER_IDS_TABLE = 'user_ids';

  // 가입하기
  Future<void> register(Member member) async {
    //회원 수 증가
    updateTotalMember();

    // 회원번호
    member.id = await getLastNumberID() + 1;

    // 회원 카운트 증가
    await _db.reference().child(USER_IDS_TABLE).update({'lastNumber': member.id});

    // 프로필 로컬 저장, 학생증 서버에 업로드
    SPController.saveProfileToLocal(member);
    //FSController.uploadStdCardToStorage(member.studentCardImage);

    // 회원 번호로 관리하기 위해 테이블에 회원번호와 매핑되는 uid 추가
    _db
        .reference()
        .child(USER_IDS_TABLE)
        .child('id/${_mAuth.currentUser.uid}')
        .set(member.id);
    _db
        .reference()
        .child(USER_IDS_TABLE)
        .child('uid/${member.id}')
        .set(_mAuth.currentUser.uid);

    // 회원 정보 등록(최종회원가입)
    // TODO join이 안되니까 uid로 관리하는게 맞는듯? 좋은 방법있는지 보류
    await _db
        .reference()
        .child(USERS_TABLE)
        .child('${member.id}')
        .set(member.toJson());
  }

  // 전체 회원 수 가져오기
  static Future<int> getTotalMemberCount() async {
    final snapshot = await _db.reference().child(USER_IDS_TABLE).once();
    return snapshot.value['count'];
  }

  // 회원 id 가져오기
  static Future<int> getMemberID(String uid) async {
    final snapshot =
    await _db.reference().child(USER_IDS_TABLE).child('id').once();
    return snapshot.value['$uid'];
  }

  // 회원 uid 가져오기
  static Future<String> getMemberUid(int id) async {
    final snapshot =
    await _db.reference().child(USER_IDS_TABLE).child('uid').once();
    return snapshot.value[id];
  }

  static Future<int> getLastNumberID() async {
    final snapshot = await _db.reference().child(USER_IDS_TABLE).once();
    return snapshot.value['lastNumber'];
  }

  static Future<String> getMemberSex(int id) async {
    final snapshot = await _db
        .reference()
        .child(USERS_TABLE)
        .child('$id')
        .child('sex')
        .once();
    return snapshot.value;
  }

  static Future<String> getMemberAuthorization(int id) async {
    final snapshot = await _db
        .reference()
        .child(USERS_TABLE)
        .child('$id')
        .child('authorization')
        .once();

    return snapshot.value;
  }

  // 회원 프로필 수정하기
  Future<Member> updateProfile(Member fixProfile) async {
    SPController.saveProfileToLocal(fixProfile);

    await _db
        .reference()
        .child(USERS_TABLE)
        .child('${fixProfile.id}')
        .update(fixProfile.toJson());

    return fixProfile;
  }

  // 남은 메시지 조회
  static Future<int> getPossibleMessageOfSend() async {
    final snapshot = await _db
        .reference()
        .child(USERS_TABLE)
        .child(
        '${await getMemberID(_mAuth.currentUser.uid)}/possibleMessageOfSend')
        .once();

    return snapshot.value;
  }

  // 회원 프로필 가져오기
  Future<Member> loadProfile() async {
    final snapshot = await _db
        .reference()
        .child(USERS_TABLE)
        .child('${_mAuth.currentUser.uid}')
        .once();

    final responseData = json.decode(snapshot.value);

    return Member.fromJson(responseData);
  }

  Future<void> updateTotalMember() async =>
      _db.reference().child(USER_IDS_TABLE).update({'count': await getTotalMemberCount() + 1});

}
