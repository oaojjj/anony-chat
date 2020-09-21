import 'package:anony_chat/model/dao/report.dart';
import 'package:flutter/material.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final List<Tab> tabs = [
    Tab(
      child: Text('신고된 내역'),
    ),
    Tab(
      child: Text('신고한 내역'),
    )
  ];

  final reportedList0 = [
    Report.fromJson({'id': 2245, 'processed': false, 'reportType': '신고사유 2'}),
    Report.fromJson({'id': 12, 'processed': true, 'reportType': '신고사유 1'})
  ];

  final reportedList1 = [
    Report.fromJson({'id': 12345, 'processed': true, 'reportType': '신고사유 1'}),
    Report.fromJson({'id': 1245, 'processed': true, 'reportType': '신고사유 1'}),
    Report.fromJson({'id': 1, 'processed': false, 'reportType': '신고사유 5'}),
    Report.fromJson({'id': 1, 'processed': false, 'reportType': '신고사유 5'}),
    Report.fromJson({'id': 1, 'processed': false, 'reportType': '신고사유 5'}),
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
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(32.0))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 8),
                    child: Text('정상이용 가능',
                        style: TextStyle(color: Colors.white, fontSize: 13)),
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: DefaultTabController(
                length: tabs.length,
                child: Column(
                  children: [
                    TabBar(
                      tabs: tabs,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.indigo,
                    ),
                    Container(
                      width: double.infinity,
                      height: deviceSize.height - 200,
                      child: TabBarView(
                        children: tabs.map((Tab tab) {
                          int index = tabs.indexOf(tab);
                          return Container(
                            width: double.infinity,
                            child: buildReportedList(index),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  buildReportedList(int index) {
    final List<Report> item = index == 0 ? reportedList0 : reportedList1;
    return ListView.builder(
        itemCount: index == 0 ? reportedList0.length : reportedList1.length,
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
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(width: 16),
                    Text('${item[ix].id}')
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
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(width: 16),
                    Text(item[ix].reportType),
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
  }
}
