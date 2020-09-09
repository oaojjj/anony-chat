import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'dao/member.dart';

class MemberModel {
  final FirebaseAuth mAuth = FirebaseAuth.instance;
  final FirebaseDatabase db = FirebaseDatabase.instance;

  static const String USERS_TABLE = 'users';
  static const String USER_IDS_TABLE = 'user_ids';

  Future<void> register(Member member) async {
    if (member != null) {
      // 익명 로그인
      await mAuth.signInAnonymously();

      // 회원번호
      member.id = await getTotalMemberCount() + 1;

      // 회원 번호로 관리하기 위해 테이블에 회원번호와 매핑되는 uid 추가
      await db.reference().child(USER_IDS_TABLE).child('id').child('${member.id}').set(mAuth.currentUser.uid);
      await db.reference().child(USER_IDS_TABLE).update({'count': member.id});

      // 회원 정보 등록(최종회원가입)
      // join이 안되니까 uid로 관리하는게 맞는듯?
      // TODO 좋은 방법있는지 보류
      await db.reference().child(USERS_TABLE).child('${mAuth.currentUser.uid}').set(member.toJson());
    }
  }

  Future<String> test() async {
    var test = await db.reference().child('test').once();
    print(test.value);
    return test.value['test'];
  }

  Future<int> getTotalMemberCount() async {
    var snapshot = await db.reference().child(USER_IDS_TABLE).once();
    return snapshot.value['count'];
  }

  Future<int> getMemberID() async {
    var snapshot = await db.reference().child(USER_IDS_TABLE).once();
    print(snapshot.value['${mAuth.currentUser.uid}']);
    return snapshot.value['${mAuth.currentUser.uid}'];
  }

  Future<Member> getProfile() async {
    var snapshot = await db.reference().child(USERS_TABLE).child('${mAuth.currentUser.uid}').once();
    var member = Member.fromMap({
      'id': snapshot.value['id'],
      'sex': snapshot.value['sex'],
      'region': snapshot.value['region'],
      'university': snapshot.value['university'],
      'birthYear': snapshot.value['birthYear'],
      'studentID': snapshot.value['studentID'],
      'isNotMeetingSameUniversity':
          snapshot.value['isNotMeetingSameUniversity'].toString() == 'true',
      'isNotMeetingPhoneList':
          snapshot.value['isNotMeetingPhoneList'].toString() == 'true'
    });
    return member;
  }

  Future<void> updateProfile(Member fixProfile) async {
    if (fixProfile != null) {
      await db
          .reference()
          .child(USERS_TABLE)
          .child(mAuth.currentUser.uid)
          .update(fixProfile.toJson());
    }
  }
}
