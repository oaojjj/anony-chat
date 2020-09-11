import 'dart:io';

import 'package:anony_chat/database/firebase_storage_controller.dart';
import 'package:anony_chat/database/shared_preferences_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'dao/member.dart';

class MemberModel {
  static final FirebaseAuth _mAuth = FirebaseAuth.instance;
  static final FirebaseDatabase _db = FirebaseDatabase.instance;

  static const String USERS_TABLE = 'users';
  static const String USER_IDS_TABLE = 'user_ids';

  // 가입하기
  Future<void> register(Member member, File image) async {
    await _mAuth.signInAnonymously();

    // 회원번호
    member.id = await getTotalMemberCount() + 1;

    SPController.saveProfileToLocal(member);
    if (image != null) FSController.uploadStdCardToStorage(image);

    // 회원 번호로 관리하기 위해 테이블에 회원번호와 매핑되는 uid 추가
    await _db
        .reference()
        .child(USER_IDS_TABLE)
        .child('id/${member.id}')
        .set(_mAuth.currentUser.uid);

    await _db.reference().child(USER_IDS_TABLE).update({'count': member.id});

    // 회원 정보 등록(최종회원가입)
    // TODO join이 안되니까 uid로 관리하는게 맞는듯? 좋은 방법있는지 보류
    await _db
        .reference()
        .child(USERS_TABLE)
        .child('${_mAuth.currentUser.uid}')
        .set(member.toJson());
  }

  // 전체 회원 수 가져오기
  static Future<int> getTotalMemberCount() async {
    var snapshot = await _db.reference().child(USER_IDS_TABLE).once();
    return snapshot.value['count'];
  }

  // 회원 번호 가져오기
  static Future<int> getMemberID() async {
    var snapshot = await _db.reference().child(USER_IDS_TABLE).once();
    print(snapshot.value['${_mAuth.currentUser.uid}']);
    return snapshot.value['${_mAuth.currentUser.uid}'];
  }

  // 회원 프로필 수정하기
  Future<void> updateProfile(Member fixProfile) async {
    SPController.saveProfileToLocal(fixProfile);

    await _db
        .reference()
        .child(USERS_TABLE)
        .child(_mAuth.currentUser.uid)
        .update(fixProfile.toJson());
  }

  // 남은 메시지 조회
  static Stream<Event> getPossibleMessageOfSend() {
    return _db
        .reference()
        .child(USERS_TABLE)
        .child('${FirebaseAuth.instance.currentUser.uid}/possibleMessageOfSend')
        .onValue;
  }

/* // 회원 프로필 가져오기
  Future<Member> loadProfile() async {
    var snapshot = await _db
        .reference()
        .child(USERS_TABLE)
        .child('${_mAuth.currentUser.uid}')
        .once();

    var member = Member.fromMap({
      'id': snapshot.value['id'],
      'sex': snapshot.value['sex'],
      'region': snapshot.value['region'],
      'university': snapshot.value['university'],
      'birthYear': snapshot.value['birthYear'],
      'isNotMeetingSameUniversity':
          snapshot.value['isNotMeetingSameUniversity'].toString() == 'true',
      'isNotMeetingPhoneList':
          snapshot.value['isNotMeetingPhoneList'].toString() == 'true'
    });
    return member;
  }*/
}
