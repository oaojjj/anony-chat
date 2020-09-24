import 'package:anony_chat/model/dao/member.dart';
import 'package:anony_chat/provider/member_auth_provider.dart';
import 'package:hive/hive.dart';

class HiveController {
  // 가입할 때 프로필 저장
  static saveProfileToLocal(Member member) async {
    final box = Hive.box('member');

    box.put('id', member.id);
    box.put('sex', member.sex);
    box.put('birthYear', member.birthYear);
    box.put('region', member.region);
    box.put('university', member.university);
    box.put('major', member.major);
    box.put('studentID', member.studentID);
    box.put('phoneNumber', member.phoneNumber);
    box.put('authorization', member.authorization);
    box.put('isNotMeetingSameUniversity', member.isNotMeetingSameUniversity);
    box.put('isNotMeetingSameMajor', member.isNotMeetingSameMajor);
  }

  static void onRegisterCompleted() =>
      Hive.box('auth').put('authStatus', AuthStatus.registered);

  static AuthStatus getAuthStatus() =>
      Hive.box('auth').get('authStatus') ?? AuthStatus.nonRegistered;

  static int getMemberID() {
    final box = Hive.box('member');
    return box.get('id');
  }

  // 프로필 가져오기
  static Member loadProfileToLocal() {
    final box = Hive.box('member');

    return Member.fromJson({
      'id': box.get('id') ?? -1,
      'sex': box.get('sex') ?? "남자",
      'birthYear': box.get('birthYear') ?? "",
      'region': box.get('region') ?? "",
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
