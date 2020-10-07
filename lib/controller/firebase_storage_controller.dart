import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FSController {
  static final _firebaseStorage = FirebaseStorage.instance;

// 파일 업로드
  static void uploadStdCardToStorage(File image) =>
      _firebaseStorage
      .ref()
      .child('student card/${FirebaseAuth.instance.currentUser.uid}')
      .putFile(image);

  static Future<String> loadImageURL(String name) async {
    /*final checkLocal = await SharedPreferences.getInstance();

    if (checkLocal.getString('planet') != null) {
      return SPController.loadPlanetImageURL();
    }*/

    return await _firebaseStorage
        .ref()
        .child('messageImage/$name')
        .getDownloadURL();
  }

  static Future<String> loadStdCardImageURL(String name) async {
    final uid = FirebaseAuth.instance.currentUser.uid;
    return await _firebaseStorage
        .ref()
        .child('student card/$uid')
        .getDownloadURL();
  }
}
