import 'package:anony_chat/model/dao/member.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPController {
  // 가입할 때 프로필 저장
  static Future<void> saveProfileToLocal(Member member) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setInt('id', member.id);
    prefs.setString('sex', member.sex);
    prefs.setInt('birthYear', member.birthYear);
    prefs.setString('region', member.region);
    prefs.setString('university', member.university);
    prefs.setString('major', member.major);
    prefs.setInt('studentID', member.studentID);
    prefs.setString('phoneNumber', member.phoneNumber);
    prefs.setBool(
        'isNotMeetingSameUniversity', member.isNotMeetingSameUniversity);
    prefs.setBool('isNotMeetingPhoneList', member.isNotMeetingSameMajor);
  }

  // 프로필 가져오기
  static Future<Member> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();

    return Member.fromJson({
      'id': prefs.get('id') ?? -1,
      'sex': prefs.get('sex') ?? "",
      'birthYear': prefs.get('birthYear') ?? "",
      'region': prefs.get('region') ?? "",
      'university': prefs.get('university') ?? "",
      'major': prefs.get('major') ?? "",
      'studentID': prefs.get('studentID') ?? "",
      'phoneNumber': prefs.get('phoneNumber') ?? "",
      'isNotMeetingSameUniversity':
          prefs.get('isNotMeetingSameUniversity') ?? false,
      'isNotMeetingPhoneList': prefs.get('isNotMeetingPhoneList') ?? false,
    });
  }

  static Future<int> getID() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('id');
  }

  // test
  static Future<String> loadPlanetImageURL() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('planet');
  }
}
