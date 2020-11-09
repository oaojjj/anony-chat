import 'package:anony_chat/utils/utill.dart';
import 'package:anony_chat/viewmodel/card_http_model.dart';
import 'package:anony_chat/viewmodel/payment_http_model.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _cardHttpModel = CardHttpModel();
  final _paymentHttpModel = PaymentHttpModel();

  String _selectedCard = '-';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('월구독 정기결제'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('카드 리스트'),
            Center(
              child: SingleChildScrollView(
                child: Container(
                  height: 150,
                  child: FutureBuilder(
                    future: fetchCardList(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.separated(
                            separatorBuilder: (context, index) => Divider(
                                  color: Colors.black,
                                ),
                            itemBuilder: (context, index) => GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedCard = snapshot.data[index];
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Text('${snapshot.data[index]}')),
                                  ),
                                ),
                            itemCount: snapshot.data.length);
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              ),
            ),
            Text('결제 진행 리스트'),
            Center(
              child: SingleChildScrollView(
                child: Container(
                  height: 150,
                  child: FutureBuilder(
                    future: fetchPaymentList(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.separated(
                            separatorBuilder: (context, index) => Divider(
                                  color: Colors.black,
                                ),
                            itemBuilder: (context, index) => GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedCard = snapshot.data[index];
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Text('${snapshot.data[index]}')),
                                  ),
                                ),
                            itemCount: snapshot.data.length);
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              ),
            ),
            Text('선택된 카드'),
            Text('$_selectedCard'),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/card_registration_page');
                    },
                    child: Text(
                      '카드등록',
                      style: TextStyle(color: Colors.white),
                    )),
                RaisedButton(
                    onPressed: () => payment(),
                    child: Text(
                      '결제하기',
                      style: TextStyle(color: Colors.white),
                    )),
                RaisedButton(
                    onPressed: () => paymentUnSchedule(),
                    child: Text(
                      '결제취소',
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }

  fetchCardList() async {
    final cardList = [];

    final resultCardList = await _cardHttpModel.getCardList();

    if (resultCardList.code == ResponseCode.SUCCESS_CODE) {
      resultCardList.data.item.forEach((element) {
        cardList.add(element['code']);
      });
    } else {
      showToast('카드 불러오기에 실패했습니다.');
    }

    return cardList;
  }

  fetchPaymentList() async {
    final paymentList = [];

    final resultPaymentList = await _paymentHttpModel.getPaymentState();
    print(resultPaymentList.toJson());
    if (resultPaymentList.code == ResponseCode.SUCCESS_CODE) {
      resultPaymentList.data.item.forEach((element) {
        paymentList.add(element);
      });
    } else {
      showToast('결제 진행 상황 불러오기 실패');
    }
    return paymentList;
  }

  Future<void> payment() async {
    if (_selectedCard == '-') {
      showToast('카드를 선택해주요');
      return;
    } else {
      final resultBillings =
          await _paymentHttpModel.paymentBillings(100, _selectedCard);
      if (resultBillings.code == ResponseCode.SUCCESS_CODE) {
        showToast('결제완료');
      } else {
        showToast('결제실패');
      }
    }
  }

  Future<void> paymentUnSchedule() async {
    if (_selectedCard == '-') {
      showToast('카드를 선택해주요');
      return;
    } else {
      final resultUnSchedule =
          await _paymentHttpModel.paymentUnSchedule(_selectedCard);
      if (resultUnSchedule.code == ResponseCode.SUCCESS_CODE) {
        showToast('결제취소 완료');
      } else {
        showToast('결제취소 실패');
      }
    }
  }
}
