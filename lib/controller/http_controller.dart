import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class HttpController {
  static HttpController get instance => HttpController();

  Future<dynamic> httpGet(String url,Map headers) async {
    Map <String, dynamic> result = Map();
    print('httpGet request $url');
    try {
      var response = await http.get(url, headers: headers).timeout(Duration(seconds: 5));
      if (response.statusCode == 200){
        result = jsonDecode(utf8.decode(response.bodyBytes));
        return result;
      }else {
        result['success'] = false;
        print("httpGet response error response code ${response.statusCode.toString()}");
        return result;
      }
    }catch (e) {
      print("httpGet error ${e.toString()} $url");
      result['success'] = false;
      return result;
    }
  }

  Future<dynamic> httpPost(String url, Map headers, {String data}) async {
    Map<String, dynamic> result = Map();
    print('httpPost request $url');

    try {
      final response = await http
          .post(url, headers: headers, body: data)
          .timeout(Duration(seconds: 5));
      if (response.statusCode == 200) {
        print('response body: ${response.body}');
        result = jsonDecode(utf8.decode(response.bodyBytes));
        return result;
      } else {
        result['success'] = false;
        print(
            "httpPost response error response code ${response.statusCode.toString()}");
        return result;
      }
    } catch (e) {
      print("httpPost error ${e.toString()} $url");
      result['success'] = false;
      return result;
    }
  }

  Future<dynamic> httpMultipartPost(String url, Map headers,
      {File file, int duration}) async {
    print('http httpMultipartPost 요청 $url');

    Map<String, dynamic> result = Map();

    try {
      var request = http.MultipartRequest("POST", Uri.parse(url));
      if (duration != null) {
        Map<String, String> durationMap = Map();
        durationMap['duration'] = duration.toString();
        request.fields.addAll(durationMap);
      }
      request.headers.addAll(headers);
      request.files.add(
          await http.MultipartFile.fromPath(basename(file.path), file.path));

      return await request.send().then((response) async {
        if (response.statusCode == 200) {
          result = json.decode(await response.stream.bytesToString());
          print('HttpMultipartPost 업로드 성공 $result');
          return result;
        } else {
          print('HttpMultipartPost 업로드 실패 ${response.statusCode}');
          result['success'] = false;
          return result;
        }
      });
    } catch (e) {
      print('httpMultipartPost 업로드 실패 $e');
    }
  }
}
