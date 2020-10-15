import 'dart:io';

import 'package:anony_chat/controller/http_controller.dart';
import 'package:anony_chat/model/file/file_upload.dart';
import 'package:anony_chat/utils/utill.dart';

class FileHttpModel {
  // 파일 업로드
  Future<FileUpload> uploadFile({File file}) async {
    final url = '$HOST/api/v1/file/upload/image';
    headers['Content-Type'] = 'multipart/form-data';

    return FileUpload.fromJson(await HttpController.instance
        .httpMultipartPost(url, headers, file: file));
  }
}
