import 'package:anony_chat/model/dao/member.dart';
import 'package:anony_chat/provider/member_auth_provider.dart';
import 'package:hive/hive.dart';

class HiveController {
  static HiveController get instance => HiveController();

  // 가입할 때 유저정보 저장
  saveMemberInfoToLocal(Member member) {
    final box = Hive.box('member');

    box.put('id', member.id);
    box.put('gender', member.gender);
    box.put('birthYear', member.birthYear);
    box.put('city', member.city);
    box.put('university', member.university);
    box.put('major', member.major);
    box.put('studentID', member.studentID);
    box.put('phoneNumber', member.phoneNumber);
    box.put('authorization', member.authorization);
    box.put('possibleMessageOfSend', member.possibleMessageOfSend);
    box.put('isNotMeetingSameUniversity', member.isNotMeetingSameUniversity);
    box.put('isNotMeetingSameMajor', member.isNotMeetingSameMajor);
  }

  onRegisterCompleted() =>
      Hive.box('auth').put('authStatus', AuthStatus.registered);

  onRegisterSecession() =>
      Hive.box('auth').put('authStatus', AuthStatus.nonRegistered);

  AuthStatus getAuthStatus() =>
      Hive.box('auth').get('authStatus') ?? AuthStatus.nonRegistered;

  int getMemberID() => Hive.box('member').get('id');

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
      'id': box.get('id') ?? -1,
      'gender': box.get('gender') ?? "남자",
      'birthYear': box.get('birthYear') ?? "",
      'city': box.get('city') ?? "",
      'university': box.get('university') ?? "",
      'major': box.get('major') ?? "",
      'studentID': box.get('studentID') ?? -1,
      'phoneNumber': box.get('phoneNumber') ?? -1,
      'authorization': box.get('authorization') ?? "authorizationsWaiting",
      'isNotMeetingSameUniversity':
          box.get('isNotMeetingSameUniversity') ?? false,
      'isNotMeetingSameMajor': box.get('isNotMeetingSameMajor') ?? false,
    });
  }
}
