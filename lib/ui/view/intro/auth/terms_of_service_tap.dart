import 'package:anony_chat/api/terms_api.dart';
import 'package:anony_chat/model/dao/terms_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 이용약관 동의 페이지
class TermsOfServiceTap extends StatefulWidget {
  @override
  _TermsOfServiceTapState createState() => _TermsOfServiceTapState();
}

class _TermsOfServiceTapState extends State<TermsOfServiceTap> {
  TermsDataAPI _tda;

  // dummy data
  final List<TermsData> dummyItems = [
    TermsData.fromMap({
      'required': true,
      'isChecked': false,
      'title': '약관동의 테스트 제목',
      'content':
          '제 1장 총칙\n\n 제1조(목적)\n\n본 약관은 국가공간정보포털 웹사이트(이하 \"국가공간정보포털\")가 제공하는 모든 서비스 어쩌고 저쩌고 약관동의 너무 길다. 하기싫다...\n\n 제 2조(약관의 효력과 변경)\n\n 1. 어쩌고 저쩌고 본 약관 내용에 어쩌고 하는경우 어쩌고 저쩌고 저쩌고 어쩌고 저쩌고 이쩌고 자쩌고\n정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애\n\n\n\n\n\n\n\testsetestestsem\n\ntesttestestestse\n\n\n\테스트\n\n\n\n\n\n\n\n\n\스크롤뷰 되나요',
    }),
    TermsData.fromMap({
      'required': true,
      'isChecked': false,
      'title': '약관동의 테스트 제목2',
      'content':
          '제 2장 총칙\n\n 제1조(목적)\n\n본 약관은 국가공간정보포털 웹사이트(이하 \"국가공간정보포털\")가 제공하는 모든 서비스 어쩌고 저쩌고 약관동의 너무 길다. 하기싫다...\n\n 제 2조(약관의 효력과 변경)\n\n 1. 어쩌고 저쩌고 본 약관 내용에 어쩌고 하는경우 어쩌고 저쩌고 저쩌고 어쩌고 저쩌고 이쩌고 자쩌고\n정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애\n\n\n\n\n\n\n\testsetestestsem\n\ntesttestestestse\n\n\n\테스트\n\n\n\n\n\n\n\n\n\스크롤뷰 되나요',
    }),
    TermsData.fromMap({
      'required': false,
      'isChecked': false,
      'title': '광고성 문자 수신 동의',
      'content': 'test3',
    })
  ];

  @override
  void initState() {
    _tda = TermsDataAPI(items: dummyItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 60),
      child: Container(
        height: 50.0 * (_tda.mItems.length + 1),
        child: Column(
          children: [
            Expanded(
              child: Card(
                elevation: 3,
                child: ListView.builder(
                  // 모두 동의하기 넣기위해 길이 +1
                  itemCount: _tda.mItems.length + 1,
                  itemBuilder: (_, index) => _buildTerms(index),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 약관동의 리스트
  // ListTile로 하니까 크기를 마음대로 못정함
  Widget _buildTerms(int index) {
    if (index == _tda.mItems.length) return _buildFooter();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          fit: FlexFit.loose,
          flex: 1,
          child: Checkbox(
              checkColor: Colors.white,
              value: _tda.mItems[index].isChecked,
              onChanged: (value) {
                setState(() => _tda.onChecked(index, value));
              }),
        ),
        Flexible(
            fit: FlexFit.tight,
            flex: 4,
            child: Text(_tda.returnRequiredString(index))),
        Flexible(
          fit: FlexFit.loose,
          flex: 1,
          child: IconButton(
              color: Colors.black,
              icon: Icon(Icons.search),
              onPressed: () => _navigateTermsContent(context, index)),
        ),
      ],
    );
  }

  // 모두 동의하기
  Widget _buildFooter() {
    return Row(
      children: [
        Flexible(
          fit: FlexFit.loose,
          flex: 1,
          child: Checkbox(
              checkColor: Colors.white,
              value: _tda.allAgree,
              onChanged: (value) {
                setState(() => onAllAgree(value));
              }),
        ),
        Flexible(
            fit: FlexFit.tight,
            flex: 3,
            child:
                Text("모두 동의하기", style: TextStyle(fontWeight: FontWeight.bold))),
      ],
    );
  }

  onAllAgree(bool value) {
    _tda.onAllAgreeCheckBox(value);
  }

  _navigateTermsContent(BuildContext context, int index) async {
    TermsData result = await Navigator.pushNamed<dynamic>(
        context, '/terms_content_page',
        arguments: _tda.mItems[index]);
    if (result != null) setState(() => result.isChecked = true);
  }
}
