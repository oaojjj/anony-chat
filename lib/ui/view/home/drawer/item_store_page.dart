import 'package:anony_chat/ui/widget/bottom_button.dart';
import 'package:flutter/material.dart';

class ItemStorePage extends StatefulWidget {
  @override
  _ItemStorePageState createState() => _ItemStorePageState();
}

class _ItemStorePageState extends State<ItemStorePage> {
  static const SUBSCRIBE_IMAGE_PATH = 'assets/images/subscribe_image1440px.jpg';
  static const DOWN_ARROW_IMAGE_PATH = 'assets/images/down_arrow_image.png';

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
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  SUBSCRIBE_IMAGE_PATH,
                ),
              ),
              SizedBox(height: 24),
              Image.asset(DOWN_ARROW_IMAGE_PATH, scale: 0.9),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 12.0),
                child: BottomButton(
                  onPressed: () {
                    //TODO 월구독 신청
                  },
                  text: '월구독 신청',
                ),
              ),
              Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 16.0),
                  child: Expanded(
                    child: Text(
                      '· 신청 전 주의사항\n20대만 이용할 수 있는 어플이므로 29살이신 회원님은 매년 말일에 월구독신청이 해제됩니다.',
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.grey[300],
                width: double.infinity,
                child: Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 16.0),
                    child: Text(
                      '· 구입한 아이템은 환불이 불가능합니다.\n· 청구된 결제금액의 환불 및 해지는 Google / Apple 고객센터에서 가능합니다.',
                      style: TextStyle(color: Colors.grey),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
