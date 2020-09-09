import 'dart:math';

import 'package:anony_chat/model/dao/member.dart';
import 'package:anony_chat/model/member_model.dart';
import 'package:firebase_database/firebase_database.dart';

class ChatModel {
  Future<void> getTest() async {
    final memberModel = MemberModel();
    final int totalMember = await memberModel.getTotalMemberCount();



    final DataSnapshot snapShot = await FirebaseDatabase.instance
        .reference()
        .child(MemberModel.USER_IDS_TABLE)
        .once();

    final Map<dynamic, dynamic> test = snapShot.value;

    print(test);
    test.forEach((key, value) {
      print(test[key]);
    });

    print(snapShot);
  }
}
