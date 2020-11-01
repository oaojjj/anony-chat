import 'package:anony_chat/model/dao/member.dart';
import 'package:anony_chat/viewmodel/message_count_http_model.dart';
import 'package:hive/hive.dart';

class HiveController {
  static HiveController get instance => HiveController();

  final MessageCountHttpModel _messageCountHttpModel = MessageCountHttpModel();

  // 가입할 때 유저정보 저장
  saveMemberInfoToLocal(Member member) {
    final box = Hive.box('member');
    print(member.toJson());
    box.put('userID', member.userID);
    box.put('authID', member.authID);
    box.put('gender', member.gender);
    box.put('fcmToken', member.fcmToken);
    box.put('birthYear', member.birthYear);
    box.put('city', member.city);
    box.put('university', member.university);
    box.put('department', member.department);
    box.put('studentID', member.studentID);
    box.put('img', member.studentImageNumber);
    box.put('phoneNumber', member.phoneNumber);
    box.put('possibleMessageOfSend', member.possibleMessageOfSend);
    box.put('isShowMyInfo', member.isShowMyInfo);
    box.put('isNotMatchingSameUniversity', member.isNotMatchingSameUniversity);
    box.put('isNotMatchingSameDepartment', member.isNotMatchingSameDepartment);
  }

  int getMemberID() => Hive.box('member').get('userID');

  String getFCMToken() => Hive.box('member').get('fcmToken');

  int getPossibleMessageOfSend() =>
      Hive.box('member').get('possibleMessageOfSend');

  setFCMToken(String val) => Hive.box('member').put('fcmToken', val);

  setPossibleMessageOfSend(int n) =>
      Hive.box('member').put('possibleMessageOfSend', n);

  // 프로필 가져오기
  Member loadMemberInfoToLocal() {
    final box = Hive.box('member');

    return Member.fromJson({
      'id': box.get('userID') ?? -1,
      'authID': box.get('authID') ?? "null",
      'fcmToken': box.get('fcmToken') ?? "null",
      'gender': box.get('gender') ?? "null",
      'birth_year': box.get('birthYear') ?? -1,
      'address': box.get('city') ?? "null",
      'school': box.get('university') ?? "null",
      'department': box.get('department') ?? "null",
      'studentID': box.get('studentID') ?? -1,
      'img': box.get('img') ?? -1,
      'num': box.get('phoneNumber') ?? "null",
      'possibleMessageOfSend': box.get('possibleMessageOfSend') ?? -1,
      'provide': box.get('isShowMyInfo') ?? false,
      'school_matching': box.get('isNotMatchingSameUniversity') ?? false,
      'department_matching': box.get('isNotMatchingSameDepartment') ?? false,
    });
  }

  void setAuthState(num code) => Hive.box('auth').put('authState', code);

  void getAuthState() => Hive.box('auth').get('authState');

  Future fetchMemberInfo(member) async {
    // 사용자 정보 로컬에 저장
    await HiveController.instance.saveMemberInfoToLocal(
        Member.fromJson(member)..fcmToken = getFCMToken());

    final sendMsg = await _messageCountHttpModel.getMsgCount();
    await HiveController.instance
        .setPossibleMessageOfSend(sendMsg.data.item[0]['cnt']);
    print(HiveController.instance.loadMemberInfoToLocal());
    return;
  }
}
