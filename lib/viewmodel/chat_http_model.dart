import 'package:anony_chat/controller/http_controller.dart';
import 'package:anony_chat/model/chat/chat_matching.dart';
import 'package:anony_chat/model/chat/chat_user_info.dart';
import 'package:anony_chat/utils/utill.dart';

class ChatHttpModel {

  // 사용자 채팅 상대 반환
  Future<ChatMatching> matching() async {
    final url = '$HOST/api/v1/matching';
    headers['Content-Type'] = 'application/json; charset=utf-8';

    return ChatMatching.fromJson(
        await HttpController.instance.httpGet(url, headers));
  }

  // 상대방 정보 조회
  Future<ChatUserInfo> getMatchingUserInfo(int id) async {
    final url = '$HOST/api/v1/matching/info?id=$id';
    headers['Content-Type'] = 'application/json; charset=utf-8';

    return ChatUserInfo.fromJson(
        await HttpController.instance.httpGet(url, headers));
  }
}
