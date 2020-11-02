import 'package:firebase_storage/firebase_storage.dart';

class FirebaseController {
  static FirebaseController get instance => FirebaseController();

  Future<dynamic> sendImageToUserInChatRoom(croppedFile, chatRoomID) async {
    try {
      String imageTimeStamp = DateTime.now().millisecondsSinceEpoch.toString();
      String filePath = 'chatrooms/$chatRoomID/$imageTimeStamp';

      final StorageReference storageReference =
          FirebaseStorage().ref().child(filePath);
      final StorageUploadTask uploadTask =
          storageReference.putFile(croppedFile);

      print('#사진업로드 완료:$filePath');

      StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
      return await storageTaskSnapshot.ref.getDownloadURL();
    } catch (e) {
      print(e.message);
    }
  }
}
