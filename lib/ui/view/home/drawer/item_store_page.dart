import 'package:flutter/material.dart';

class ItemStorePage extends StatefulWidget {
  @override
  _ItemStorePageState createState() => _ItemStorePageState();
}

class _ItemStorePageState extends State<ItemStorePage> {
  // 보유 캐시
  int cash = 0;

  // 사진아이템 남은 일수
  int possiblePhotoDay = 0;

  // 남은 메시지
  int possibleMessageOfSend = 5;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            '아이템 상점',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text('보유 캐시', style: TextStyle(fontSize: 18)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(width: 88),
                  Text('$cash개',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 4.0),
                    child: Container(
                        height: 30,
                        child: Image.asset(
                          'assets/icons/store_cash.png',
                        )),
                  )
                ],
              ),
              SizedBox(height: 16),
              Container(
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '사진아이템',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      SizedBox(width: 40),
                      Text(
                        '$possiblePhotoDay일 남음',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              buildItemContainer('사진아이템', 7, 10),
              SizedBox(height: 8),
              buildItemContainer('사진아이템', 30, 20),
              SizedBox(height: 16),
              Container(
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '보낼 수 있는 메시지',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      SizedBox(width: 40),
                      Text(
                        '$possibleMessageOfSend개',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              buildItemContainer('메시지', 3, 1),
              SizedBox(height: 8),
              buildItemContainer('메시지', 50, 10),
              Spacer(),
              Container(
                width: double.infinity,
                color: Colors.grey[300],
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                  child: Text(
                    '구입한 아이템은 환불이 불가능합니다.\n청구된 결제금액의 환불의 Google / Apple 고객센터에서만 가능합니다.',
                    style: TextStyle(color: Colors.grey[700], fontSize: 12),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildItemContainer(String item, int day, int count) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Card(
          child: InkWell(
            onTap: (){
              // TODO 아이템 구매 작성
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '$item $day일',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  SizedBox(width: 20),
                  Text(
                    '캐시 $count개',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  )
                ],
              ),
            ),
          ),
          elevation: 3,
        ),
      ),
    );
  }
}
