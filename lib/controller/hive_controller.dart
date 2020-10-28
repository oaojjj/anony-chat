import 'package:anony_chat/model/dao/member.dart';
import 'package:anony_chat/provider/auth_provider.dart';
import 'package:hive/hive.dart';

class HiveController {
  static HiveController get instance => HiveController();

  // 가입할 때 유저정보 저장
  saveMemberInfoToLocal(Member member) {
    final box = Hive.box('member');

    box.put('userID', member.userID);
    box.put('authID', member.authID);
    box.put('gender', member.gender);
    box.put('fcmToken', member.fcmToken);
    box.put('birthYear', member.birthYear);
    box.put('city', member.city);
    box.put('university', member.university);
    box.put('department', member.department);
    box.put('studentID', member.studentID);
    box.put('phoneNumber', member.phoneNumber);
    box.put('possibleMessageOfSend', member.possibleMessageOfSend);
    box.put('isShowMyInfo', member.isShowMyInfo);
    box.put('isNotMatchingSameUniversity', member.isNotMatchingSameUniversity);
    box.put('isNotMatchingSameDepartment', member.isNotMatchingSameDepartment);
  }

  int getMemberID() => Hive.box('member').get('userID');

  String getFCMToken() => Hive.box('member').get('fcmToken') ?? null;

  int getPossibleMessageOfSend() =>
      Hive.box('member').get('possibleMessageOfSend') ?? 0;

  setFCMToken(String val) => Hive.box('member').put('fcmToken', val);

  setPossibleMessageOfSend(int n) =>
      Hive.box('member').put('possibleMessageOfSend', n);

  // 프로필 가져오기
  Member loadProfileToLocal() {
    final box = Hive.box('member');

    return Member.fromJson({
      'userID': box.get('userID') ?? -1,
      'authID': box.get('authID') ?? "null",
      'fcmToken': box.get('fcmToken') ?? "null",
      'gender': box.get('gender') ?? "null",
      'birthYear': box.get('birthYear') ?? -1,
      'city': box.get('city') ?? "null",
      'university': box.get('university') ?? "null",
      'department': box.get('department') ?? "null",
      'studentID': box.get('studentID') ?? -1,
      'phoneNumber': box.get('phoneNumber') ?? "null",
      'possibleMessageOfSend': box.get('possibleMessageOfSend') ?? -1,
      'isShowMyInfo': box.get('isShowMyInfo') ?? false,
      'isNotMatchingSameUniversity':
          box.get('isNotMatchingSameUniversity') ?? false,
      'isNotMatchingSameDepartment':
          box.get('isNotMatchingSameDepartment') ?? false,
    });
  }
}
