import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dao/user.dart' as my;

class RegisterModel {
  final mAuth = FirebaseAuth.instance;

  Future<void> register(my.User user) async {
    if (user != null) {
      await mAuth.signInAnonymously();
      final db = FirebaseDatabase.instance.reference().child('users').child(mAuth.currentUser.uid);
      await db.set({
        'sex': user.sex,
        'birth_year': user.birthYear,
        'region': user.region,
        'university': user.university,
        'std_id': user.studentID.toString(),
        'un_meeting_same_university':
            user.isNotMeetingSameUniversity.toString(),
        'un_meeting_phone_list': user.isNotMeetingPhoneList.toString(),
      });
    }
  }
}
