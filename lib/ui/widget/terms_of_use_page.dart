import 'package:anony_chat/api/terms_api.dart';
import 'package:anony_chat/model/terms_data.dart';
import 'package:anony_chat/ui/widget/terms_content_page.dart';
import 'package:flutter/material.dart';

// 이용약관 동의 페이지
class TermsOfUsePage extends StatefulWidget {
  @override
  _TermsOfUsePageState createState() => _TermsOfUsePageState();
}

class _TermsOfUsePageState extends State<TermsOfUsePage> {
  TermsDataAPI _termsDataAPI;

  // TEST
  List<TermsData> testItems = [
    TermsData(true, false, '약관동의 테스트 제목',
        '제 1장 총칙\n\n 제1조(목적)\n\n본 약관은 국가공간정보포털 웹사이트(이하 \"국가공간정보포털\")가 제공하는 모든 서비스 어쩌고 저쩌고 약관동의 스트링 너무 길다. 하기싫다...\n\n 제 2조(약관의 효력과 변경)\n\n 1. 어쩌고 저쩌고 본 약관 내용에 어쩌고 하는경우 어쩌고 저쩌고 저쩌고 어쩌고 저쩌고 이쩌고 자쩌고\n정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애정신나갈것같애\n\n\n\n\n\n\n\testsetestestsem\n\ntesttestestestse\n\n\n\테스트\n\n\n\n\n\n\n\n\n\스크롤뷰 되나욤'),
    TermsData(true, false, '약관동의 테스트 제목2', '약관동의 테스트 내용2'),
    TermsData(false, false, '약관동의 테스트 제목3', '약관동의 테스트 내용3'),
    TermsData(false, false, '약관동의 테스트 기이이이이이이이인제목4', '약관동의 테스트 내용4'),
  ];

  @override
  void initState() {
    _termsDataAPI = TermsDataAPI(items: testItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.amber[700],
        title: Text(
          '이용약관',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.amber,
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: _termsDataAPI.mItems.length + 1,
              itemBuilder: (context, index) {
                return createTerms(index);
              },
              separatorBuilder: (context, index) {
                if (index != _termsDataAPI.mItems.length - 1)
                  return Divider(
                    height: 4.0,
                    color: Colors.amberAccent,
                    endIndent: 24.0,
                    indent: 24.0,
                    thickness: 1.0,
                  );
                else
                  return Divider(
                    // footer
                    height: 8.0,
                    endIndent: 24.0,
                    indent: 24.0,
                    color: Colors.amberAccent[100],
                    thickness: 1.0,
                  );
              },
            ),
          ),
          ButtonTheme(
            minWidth: 160.0,
            buttonColor: Colors.amberAccent,
            child: RaisedButton(
                child: Text('확인'),
                onPressed: _termsDataAPI.isRequiredChecked()
                    ? () => {
                          //TODO 회원가입 페이지 만들기
                        }
                    : null),
          ),
          SizedBox(height: 16.0)
        ],
      ),
    );
  }

  ListTile createTerms(int index) {
    if (index == _termsDataAPI.mItems.length) return createFooter();

    return ListTile(
      leading: Checkbox(
        value: _termsDataAPI.mItems[index].isChecked,
        onChanged: (value) {
          setState(() {
            _termsDataAPI.onChecked(index, value);
          });
        },
      ),
      title: Text(
        _termsDataAPI.returnRequiredString(index),
        style: TextStyle(color: Colors.white),
      ),
      trailing: ButtonTheme(
        buttonColor: Colors.amberAccent,
        child: RaisedButton(
            child: Text("약관보기"),
            onPressed: () {
              _navigateDisplaySelection(context, index);
            }),
      ),
    );
  }

  ListTile createFooter() {
    return ListTile(
      leading: Checkbox(
        value: _termsDataAPI.allAgree,
        onChanged: (value) {
          setState(() {
            _termsDataAPI.allAgree = value;
            _termsDataAPI.onAllAgreeCheckBox(value);
          });
        },
      ),
      title: Text(
        "모두 동의하기",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  _navigateDisplaySelection(BuildContext context, int index) async {
    TermsData result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                TermsContentPage(_termsDataAPI.mItems[index])));

    setState(() {
      result.isChecked = true;
    });
  }
}