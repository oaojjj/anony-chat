import 'package:anony_chat/api/TermsDataAPI.dart';
import 'package:anony_chat/model/TermsData.dart';
import 'package:flutter/material.dart';

// 이용약관 동의 페이지
class TermsOfUsePage extends StatefulWidget {
  @override
  _TermsOfUsePageState createState() => _TermsOfUsePageState();
}

class _TermsOfUsePageState extends State<TermsOfUsePage> {
  TermsDataAPI _termsDataAPI;
  List<TermsData> items = [
    TermsData(true, false, '약관동의 테스트 제목', '약관동의 테스트 내용'),
    TermsData(true, false, '약관동의 테스트 제목2', '약관동의 테스트 내용2'),
    TermsData(false, false, '약관동의 테스트 제목3', '약관동의 테스트 내용3'),
    TermsData(false, false, '약관동의 테스트 기이이이이이이이인제목4', '약관동의 테스트 내용4'),
  ];

  @override
  Widget build(BuildContext context) {
    _termsDataAPI = TermsDataAPI(items, this);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('이용약관'),
      ),
      backgroundColor: Colors.amber,
      body: ListView.separated(
        // shrinkWrap: true, 얘가 뭔지는 모르겠는데 넣으면 center 가능
        itemCount: items.length + 1,
        itemBuilder: (context, index) {
          return _termsDataAPI.createTerms(index);
        },
        separatorBuilder: (context, index) {
          if (index == items.length - 1)
            return Divider(
              height: 8.0,
              endIndent: 24.0,
              indent: 24.0,
              color: Colors.black26,
              thickness: 1.0,
            );
          else
            return Divider();
        },
      ),
    );
  }
}
