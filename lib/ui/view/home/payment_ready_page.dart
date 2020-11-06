import 'package:anony_chat/ui/view/home/payment.dart';
import 'package:anony_chat/ui/widget/bottom_button.dart';
import 'package:anony_chat/ui/widget/home/my_card_view.dart';
import 'package:anony_chat/utils/utill.dart';
import 'package:anony_chat/viewmodel/card_http_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class PaymentReadyPage extends StatefulWidget {
  @override
  _PaymentReadyPageState createState() => _PaymentReadyPageState();
}

class _PaymentReadyPageState extends State<PaymentReadyPage> {
  final _scrollController = ScrollController();
  final cardList = [];
  final _cardHttpModel = CardHttpModel();

  final pgList = ['카카오페이', '네이버페이', 'KG 이니시스'];
  String pg;
  String _selected;
  String _selectedCardCUid;

  @override
  Widget build(BuildContext context) {
    print(_selectedCardCUid);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('월구독 정기결제'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24.0, top: 16.0, bottom: 4.0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '카드정보',
                  style: TextStyle(fontSize: 18.0),
                )),
          ),
          FutureBuilder(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  height: 180,
                  child: Swiper(
                    itemBuilder: (context, index) {
                      return snapshot.data[index];
                    },
                    onIndexChanged: (value) {
                      _selectedCardCUid = snapshot.data[value].getCustomerUid();
                      print(_selectedCardCUid);
                    },
                    loop: false,
                    itemCount: snapshot.data.length,
                    viewportFraction: 0.8,
                    scale: 0.9,
                  ),
                );
              } else
                return CircularProgressIndicator();
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, top: 16.0, bottom: 4.0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '결제 방법',
                  style: TextStyle(fontSize: 18.0),
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              height: 180,
              child: Card(
                elevation: 3,
                child: Scrollbar(
                  controller: _scrollController,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        buildListTile(0),
                        buildListTile(1),
                        buildListTile(2),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: BottomButton(
              text: '결제하기',
              onPressed: () {
                if (_selectedCardCUid == null) {
                  showToast('카드를 등록해주세요.');
                  return;
                }
                if (_selected == null) {
                  showToast('결제 방법을 선택해주세요.');
                  return;
                }
                if (_selected == pgList[0])
                  pg = 'kakaopay';
                else if (_selected == pgList[1])
                  pg = 'naverpay';
                else if (_selected == pgList[2]) pg = 'html5_inicis';
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Payment(
                      pg: pg,
                      customerUid: _selectedCardCUid,
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    ));
  }

  Widget buildListTile(index) {
    return RadioListTile(
      title: Text('${pgList[index]}'),
      value: pgList[index],
      groupValue: _selected,
      onChanged: (value) {
        setState(() {
          _selected = value;
        });
      },
    );
  }

  Future fetchData() async {
    print('test');
    bool flag = true;
    final cardListResult = await _cardHttpModel.getCardList();
    print('#카드정보: ${cardListResult.toJson()}');
    if (cardListResult.code == ResponseCode.SUCCESS_CODE) {
      cardListResult.data.item.forEach((element) {
        if (flag) {
          _selectedCardCUid = element['code'];
          flag = !flag;
        }
        cardList.add(MyCardView(customerUid: element['code']));
      });
    }
    cardList.add(MyCardView());
    return cardList;
  }
}
