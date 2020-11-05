import 'package:anony_chat/ui/widget/bottom_button.dart';
import 'package:flutter/material.dart';

class AdWatchingPage extends StatefulWidget {
  @override
  _AdWatchingPageState createState() => _AdWatchingPageState();
}

class _AdWatchingPageState extends State<AdWatchingPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
          leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              }),
          actions: [
            IconButton(
              icon: Icon(Icons.info_outline, color: Colors.white),
              onPressed: () {
                // TODO 광고 정보
              },
            ),
            IconButton(
              icon: Icon(Icons.play_circle_outline, color: Colors.white),
              onPressed: () {
                // TODO 플레이스토어 정보?
              },
            ),
          ],
        ),
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Container(
                    color: Colors.white,
                    height: 400,
                    width: double.infinity,
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 24.0, left: 24.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4.0)),
                        height: 64,
                        width: 64,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
                      child: Text(
                        '어플',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 40.0),
                  child: BottomButton(
                    icon: Icon(Icons.extension, color: Colors.white),
                    onPressed: () {
                      // TODO 메세지 추가로 얻기
                    },
                    text: '메시지 추가로 얻기',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
