import 'package:shared_preferences/shared_preferences.dart';

import 'dao/member.dart';

class SPDatabase {
  // 가입할 때 프로필 저장
  static Future<void> saveProfileToLocal(Member member) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setInt('id', member.id);
    prefs.setString('sex', member.sex);
    prefs.setString('birthYear', member.birthYear);
    prefs.setString('region', member.region);
    prefs.setString('university', member.university);
    prefs.setInt('studentID', member.studentID);
    prefs.setBool(
        'isNotMeetingSameUniversity', member.isNotMeetingSameUniversity);
    prefs.setBool('isNotMeetingPhoneList', member.isNotMeetingPhoneList);
  }

  // 프로필 가져오기
  static Future<Member> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();

    return Member.fromMap({
    'id':prefs.get('id'),
    'sex':prefs.get('sex'),
    'birthYear':prefs.get('birthYear'),
    'region':prefs.get('region'),
    'university':prefs.get('university'),
    'studentID':prefs.get('studentID'),
    'isNotMeetingSameUniversity':prefs.get('isNotMeetingSameUniversity'),
    'isNotMeetingPhoneList':prefs.get('isNotMeetingPhoneList')
    });
  }
}
