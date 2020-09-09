import 'package:anony_chat/ui/widget/bottom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatSendPage extends StatefulWidget {
  @override
  _ChatSendPageState createState() => _ChatSendPageState();
}

class _ChatSendPageState extends State<ChatSendPage> {
  String _choiceImagePath = 'assets/images/earth.png';
  final List<Widget> _images = [];
  final List<String> _imagePaths = [
    'assets/images/earth.png',
    'assets/images/moon.png',
    'assets/images/planet1.png',
    'assets/images/planet2.png',
    'assets/images/planet3.png',
    'assets/images/planet4.png',
    'assets/images/planet5.png',
    'assets/images/planet6.png',
  ];
  int n = 5;

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('메시지 보내기', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          iconTheme: new IconThemeData(color: Colors.white),
          leading: IconButton(
              icon: Icon(Icons.close), onPressed: () => Navigator.pop(context)),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.black87,
            child: Column(
              children: [
                SizedBox(height: 32.0),
                Center(
                  child: Container(
                    width: 120,
                    child: Stack(
                      children: [
                        Container(
                          width: 120.0,
                          height: 120.0,
                          child: GestureDetector(
                            onTap: () => _choicePlanet(),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image(image: AssetImage(_choiceImagePath)),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                                icon: Icon(Icons.settings,
                                    color: Colors.grey[700]),
                                onPressed: () => _choicePlanet()),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 32.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Container(
                    color: Colors.white,
                    height: 240,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration:
                              InputDecoration.collapsed(hintText: '메시지 입력')),
                    ),
                  ),
                ),
                SizedBox(height: 24.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Row(
                    children: [
                      RaisedButton(child: Text('사진'), onPressed: () {}),
                      Spacer(),
                      Text('오늘 보낼 수 있는 메시지: $n개',
                          style: TextStyle(fontSize: 16, color: Colors.white))
                    ],
                  ),
                ),
                SizedBox(height: 24.0),
                BottomButton(onPressed: () => {}, text: '보내기'),
                SizedBox(height: size.height * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _choicePlanet() async {
    return showDialog(
      context: context,
      builder: (_) => Material(
        type: MaterialType.transparency,
        child: Center(
          child: Container(
              color: Colors.white30,
              padding: EdgeInsets.all(32),
              child: GridView.count(crossAxisCount: 3, children: _images)),
        ),
      ),
    );
  }

  Widget createPlanet(String path) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        setState(() => _choiceImagePath = path);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image(image: AssetImage('$path')),
      ),
    );
  }

  void initData() {
    _imagePaths.forEach((element) {
      _images.add(createPlanet(element));
    });
  }
}
