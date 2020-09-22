import 'package:anony_chat/database/shared_preferences_controller.dart';
import 'package:anony_chat/model/dao/report.dart';
import 'package:anony_chat/ui/widget/bottom_button.dart';
import 'package:flutter/material.dart';

class ReportChatPage extends StatefulWidget {
  @override
  _ReportChatPageState createState() => _ReportChatPageState();
}

class _ReportChatPageState extends State<ReportChatPage> {
  int memberID = 5463;
  ReportType _selectedType = ReportType.FourLetterWord;

  @override
  void initState() {
    super.initState();
    initID();
  }

  Future<void> initID() async {
    memberID = await SPController.getID();
  }

  List<ReportType> reportType = Report.getList();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('신고하기', style: TextStyle(color: Colors.black)),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              Container(
                  height: 30, child: Image.asset('assets/icons/report2.png')),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(32.0))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 4),
                      child: Text(
                        '회원번호 $memberID',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(
                elevation: 3,
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, top: 8, bottom: 4),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '신고사유',
                            style: TextStyle(fontSize: 15),
                          )),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: reportType.length,
                      itemBuilder: (context, index) {
                        return RadioListTile(
                            title: Text(Report.changeTypeToKoreanWord(
                                reportType[index])),
                            value: reportType[index],
                            groupValue: _selectedType,
                            onChanged: (value) {
                              setState(() => _selectedType = value);
                            });
                      },
                    ),
                    SizedBox(height: 8)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    Icon(Icons.error),
                    SizedBox(width: 4),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, right: 8.0),
                        child: Text(
                          '공전한 신고절차를 위해 신고 시에 해당 대화 내용이 관리자에게 제공됩니다.',
                          style: TextStyle(fontSize: 12),
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Spacer(),
              BottomButton(
                text: '신고하기',
                onPressed: () {
                  //TODO 신고하기 작성
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
