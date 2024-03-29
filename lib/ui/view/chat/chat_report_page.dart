import 'package:anony_chat/controller/hive_controller.dart';
import 'package:anony_chat/model/report/report_type.dart';
import 'package:anony_chat/model/report/user_report.dart';
import 'package:anony_chat/ui/widget/bottom_button.dart';
import 'package:anony_chat/utils/utill.dart';
import 'package:anony_chat/viewmodel/report_http_model.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';

class ChatReportPage extends StatefulWidget {
  ChatReportPage({this.receiverID});

  final receiverID;

  @override
  _ChatReportPageState createState() => _ChatReportPageState();
}

class _ChatReportPageState extends State<ChatReportPage> {
  final AsyncMemoizer _memoizer = AsyncMemoizer();

  final _reportHttpModel = ReportHttpModel();

  String _selectedType;
  List<String> reportType = [];

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
        body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  SizedBox(height: 16),
                  Container(
                      height: 30,
                      child: Image.asset('assets/icons/report2.png')),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 4),
                          child: Text(
                            '회원번호 ${HiveController.instance.getMemberID()}',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Card(
                    elevation: 3,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, top: 8, bottom: 4),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '신고사유',
                                style: TextStyle(fontSize: 15),
                              )),
                        ),
                        FutureBuilder(
                            future: getReportType(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    return RadioListTile(
                                        title: Text(snapshot.data[index]),
                                        value: snapshot.data[index],
                                        groupValue: _selectedType,
                                        onChanged: (value) {
                                          setState(() => _selectedType = value);
                                        });
                                  },
                                );
                              } else if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              }
                              return CircularProgressIndicator();
                            }),
                        SizedBox(height: 8)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                    child: Row(
                      children: [
                        Icon(Icons.error),
                        SizedBox(width: 4),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                '신고한 회원과는 다시 매칭되지 않습니다.',
                                style: TextStyle(fontSize: 12),
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                    child: Row(
                      children: [
                        Icon(Icons.error),
                        SizedBox(width: 4),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
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
                  SizedBox(height: 32.0),
                  BottomButton(
                    text: '신고하기',
                    onPressed: () async {
                      await report(context);
                    },
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> report(BuildContext context) async {
    final UserReport reportResult = await _reportHttpModel.report(
        _selectedType, ModalRoute.of(context).settings.arguments);

    if (reportResult.code == ResponseCode.SUCCESS_CODE) {
      showToast('신고가 접수되었습니다.');
      Navigator.pop(context);
    } else {
      showToast('신고에 실패했습니다.');
    }
  }

  Future<void> getReportType() async {
    return this._memoizer.runOnce(() async {
      ReportType rt = await ReportHttpModel().requestReportType();
      rt.data.item.forEach((element) {
        reportType.add(element["value"]);
      });
      return reportType;
    });
  }
}
