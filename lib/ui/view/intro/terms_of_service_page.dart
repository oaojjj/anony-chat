import 'package:anony_chat/api/terms_api.dart';
import 'package:anony_chat/model/dao/terms_data.dart';
import 'package:anony_chat/provider/sign_up_auth_state_provider.dart';
import 'package:anony_chat/ui/view/intro/sign_up_page.dart';
import 'package:anony_chat/ui/view/intro/terms_content_page.dart';
import 'package:anony_chat/ui/widget/bottom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 이용약관 동의 페이지
class TermsOfServicePage extends StatefulWidget {
  @override
  _TermsOfServicePageState createState() => _TermsOfServicePageState();
}

class _TermsOfServicePageState extends State<TermsOfServicePage> {
  TermsDataAPI _tda;

  // TEST data
  final List<TermsData> testItems = [
    TermsData(true, false, '약관동의 테스트 제목',
        '제 1장 총칙\n\n 제1조(목적)\n\n본 약관은 국가공간정보포털 웹사이트(이하 \"국가공간정보포털\")가 제공하는 모든 서비스 어쩌고 저쩌고 약관동의 너무 길다. 하기싫다...\n\n 제 2조(약관의 효력과 변경)\n\n 1. 어쩌고 저쩌고 본 약관 내용에 어쩌고 하는경우 어쩌고 저쩌고 저쩌고 어쩌고 저쩌고 이쩌고 자쩌고\n정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애\n\n\n\n\n\n\n\testsetestestsem\n\ntesttestestestse\n\n\n\테스트\n\n\n\n\n\n\n\n\n\스크롤뷰 되나요'),
    TermsData(true, false, '약관동의 테스트 제목2', '약관동의 테스트 내용2'),
    TermsData(false, false, '광고성 문자 수신 동의', '약관동의 테스트 내용3'),
  ];

  @override
  void initState() {
    _tda = TermsDataAPI(items: testItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text('이용약관 동의', style: TextStyle(color: Colors.white)),
          centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: ListView.separated(
              // 모두 동의하기 넣기위해 길이 +1
              itemCount: _tda.mItems.length + 1,
              itemBuilder: (context, index) {
                return _createTerms(index);
              },
              separatorBuilder: (context, index) {
                return Divider(
                  height: 1.0,
                  endIndent: 16.0,
                  indent: 16.0,
                  color: Colors.amberAccent,
                  thickness: 1.0,
                );
              },
            ),
          ),
          BottomButton(
              onPressed: _tda.isRequiredChecked()
                  ? () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChangeNotifierProvider<
                                  RegisterAuthStateProvider>.value(
                                child: SignUpPage(),
                                value: RegisterAuthStateProvider(),
                              ),
                            ))
                      }
                  : null,
              text: '확인'),
          SizedBox(height: size.height * 0.05)
        ],
      ),
    );
  }

  // 약관동의 리스트
  Widget _createTerms(int index) {
    if (index == _tda.mItems.length) return _createFooter();

    return ListTile(
      leading: Checkbox(
          value: _tda.mItems[index].isChecked,
          onChanged: (value) {
            setState(() {
              _tda.onChecked(index, value);
            });
          }),
      title: Text(_tda.returnRequiredString(index)),
      trailing: IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            _navigateTermsContent(context, index);
          }),
    );
  }

  // 모두 동의하기
  Widget _createFooter() {
    return ListTile(
      leading: Checkbox(
          value: _tda.allAgree,
          onChanged: (value) {
            setState(() {
              _tda.onAllAgreeCheckBox(value);
            });
          }),
      title: Text("모두 동의하기", style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  _navigateTermsContent(BuildContext context, int index) async {
    TermsData result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TermsContentPage(_tda.mItems[index])));
    result.isChecked = true;
  }
}
