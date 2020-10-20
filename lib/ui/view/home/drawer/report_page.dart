import 'package:anony_chat/model/report/report_type.dart' as test;
import 'package:anony_chat/utils/utill.dart';
import 'package:anony_chat/viewmodel/report_http_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  bool isReported = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    test.ReportType reportType = await ReportHttpModel().requestReportType();
    print(reportType.data.item[0]);
  }

  final List<Tab> tabs = [
    Tab(
      child: Text('신고된 내역', style: TextStyle(fontSize: 18)),
    ),
    Tab(
      child: Text('신고한 내역', style: TextStyle(fontSize: 18)),
    )
  ];



  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('신고내역', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
          actions: [
            IconButton(
                icon: Icon(Icons.help),
                onPressed: () =>
                    Navigator.pushNamed(context, '/report_guide_page'))
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: Container(
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(32.0))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          isReported ? '서비스제한중' : '정상이용가능',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        getReportTime()
                      ],
                    ),
                  ),
                ),
              ),
            ),
            DefaultTabController(
              length: tabs.length,
              child: Column(
                children: [
                  TabBar(
                    indicator: BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(width: 5, color: chatPrimaryColor))),
                    tabs: tabs,
                    labelColor: Colors.black,
                  ),
                  SingleChildScrollView(
                    child: Container(
                      height: deviceSize.height - 203,
                      child: TabBarView(
                        children: tabs.map((Tab tab) {
                          int index = tabs.indexOf(tab);
                          return Container(
                            width: double.infinity,
                            child: Text('ih'),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getReportTime() {
    final time = DateFormat('yyyy년 M월 dd').format(DateTime.now());
    return isReported
        ? Text(
            '${time.toString()}까지',
            style: TextStyle(color: Colors.white),
          )
        : Container();
  }

  /*buildReportedList(int index) {
    final List<int> item = 0 ;
    return ListView.builder(
        itemCount: index == 0 ? ,
        itemBuilder: (context, ix) {
          return Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0),
                child: Row(
                  children: [
                    Text(
                      '신고된 유저',
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                    SizedBox(width: 16),
                    Text(
                      '${item[ix].opponentID}',
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, top: 4.0, bottom: 4.0, right: 8.0),
                child: Row(
                  children: [
                    Text(
                      '신고사유',
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                    SizedBox(width: 16),
                    Text(item[ix].reportType, style: TextStyle(fontSize: 18)),
                    Spacer(),
                    Text(
                      item[ix].isProcessed == true ? '처리완료' : '신고접수',
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ),
              Divider(
                height: 1,
                thickness: 1,
              )
            ],
          );
        });
  }*/
}
