import 'dart:io';

import 'package:anony_chat/database/shared_preferences_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FSController {
  static final _firebaseStorage = FirebaseStorage.instance;

  static Future<void> uploadStdCardToStorage(File image) async {
    final uid = FirebaseAuth.instance.currentUser.uid;

    final _storageReference = _firebaseStorage.ref().child('student card/$uid');

    // 파일 업로드
    _storageReference.putFile(image);
  }

  static Future<String> loadPlanetImageURL(String name) async {
    /*final checkLocal = await SharedPreferences.getInstance();

    if (checkLocal.getString('planet') != null) {
      return SPController.loadPlanetImageURL();
    }*/

    return await _firebaseStorage.ref().child('planet/$name').getDownloadURL();
  }
}
