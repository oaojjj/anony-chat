import 'dart:convert';

import 'package:http/http.dart' as http;

const String CAREER_NET_API_KEY = '2b8fb36b09184721501accd24799f283';
const String UNIVERSITY_LIST_API_PATH =
    'http://www.career.go.kr/cnet/openapi/getOpenApi?apiKey=$CAREER_NET_API_KEY&svcType=api&svcCode=SCHOOL&contentType=json&gubun=univ_list&perPage=441';
const String MAJOR_LIST_PAGE1_API_PATH =
    'http://www.career.go.kr/cnet/openapi/getOpenApi?apiKey=$CAREER_NET_API_KEY&svcType=api&svcCode=MAJOR&contentType=json&gubun=univ_list&thisPage=1&perPage=258';
const String MAJOR_LIST_PAGE2_API_PATH =
    'http://www.career.go.kr/cnet/openapi/getOpenApi?apiKey=$CAREER_NET_API_KEY&svcType=api&svcCode=MAJOR&contentType=json&gubun=univ_list&thisPage=2&perPage=258';

class HttpController {
  static HttpController get instance => HttpController();

  List<String> fetchDataUniversity() {
    final List<String> list = [];
    http.get(UNIVERSITY_LIST_API_PATH).then((response) {
      if (response.statusCode == 200) {
        Map jsonList = jsonDecode(response.body);
        jsonList.forEach((key, value) {
          value.forEach((key, json) {
            json.forEach((element) {
              if (element['campusName'] == '본교' ||
                  element['campusName'] == 'null')
                list.add(element['schoolName']);
              else
                list.add('${element['schoolName']}(${element['campusName']})');
            });
          });
        });
      } else {
        print('career net error');
      }
    });
    return list;
  }

  List<String> fetchDataMajor() {
    final List<String> list = [];

    // page1
    http.get(MAJOR_LIST_PAGE1_API_PATH).then((response) {
      if (response.statusCode == 200) {
        Map jsonList = jsonDecode(response.body);
        jsonList.forEach((key, value) {
          value.forEach((key, json) {
            json.forEach((element) {
              element['facilName'].split(',').forEach((element) {
                list.add(element);
              });
            });
          });
        });
      } else {
        return null;
      }
    });

    // page2
    http.get(MAJOR_LIST_PAGE2_API_PATH).then((response) {
      if (response.statusCode == 200) {
        Map jsonList = jsonDecode(response.body);
        jsonList.forEach((key, value) {
          value.forEach((key, json) {
            json.forEach((element) {
              element['facilName'].split(',').forEach((element) {
                list.add(element);
              });
            });
          });
        });
      } else {
        return null;
      }
    });

    return list;
  }
}
