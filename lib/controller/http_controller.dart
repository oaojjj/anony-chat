import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpController {
  static HttpController get instance => HttpController();

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
}
