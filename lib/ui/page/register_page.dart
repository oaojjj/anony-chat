import 'package:anony_chat/model/member.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Member newMember;
  bool isCanRegister;
  bool sexColor;
  String _selectedItemBirth;
  String _selectedItemRegion;
  List<String> _itemsBirth =
      List<String>.generate(50, (i) => (i + 1950).toString() + '년생');
  List<String> _itemsRegion = ['대구', '부산', '서울'];

  @override
  void initState() {
    newMember = Member();
    isCanRegister = false;
    sexColor = false;
    _selectedItemBirth = _itemsBirth[0];
    _selectedItemRegion = _itemsRegion[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.amber[700],
        centerTitle: true,
        title: Text(
          '회원정보입력',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.amber,
      body: Column(
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.all(8.0),
              color: Colors.amberAccent,
              height: 60.0,
              width: double.infinity,
              child: Text(
                '회원정보는 설정에서\n 언제든 변경가능합니다.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ),
          SizedBox(
            height: 24.0,
          ),
          Container(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonTheme(
                    minWidth: 100.0,
                    height: 50.0,
                    child: FlatButton(
                      child: Text('남자', style: TextStyle(fontSize: 20.0)),
                      onPressed: () {},
                      color: Colors.black12,
                      textColor: Colors.black,
                    ),
                  ),
                  SizedBox(width: 24.0),
                  ButtonTheme(
                    minWidth: 100.0,
                    height: 50.0,
                    child: FlatButton(
                      child: Text('여자', style: TextStyle(fontSize: 20.0)),
                      onPressed: () {},
                      color: Colors.amberAccent[100],
                      textColor: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('태어난 해',
                  style: TextStyle(fontSize: 20.0, color: Colors.white)),
              SizedBox(width: 20.0),
              DropdownButton<String>(
                  value: _selectedItemBirth,
                  items: _itemsBirth.map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newItem) {
                    setState(() {
                      _selectedItemBirth = newItem;
                    });
                  })
            ],
          )),
          Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('지역', style: TextStyle(fontSize: 20.0, color: Colors.white)),
              SizedBox(width: 20.0),
              DropdownButton<String>(
                  style: TextStyle(color: Colors.white),
                  value: _selectedItemRegion,
                  underline: Container(
                    height: 2,
                    color: Colors.amberAccent,
                  ),
                  items: _itemsRegion.map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newItem) {
                    setState(() {
                      _selectedItemRegion = newItem;
                    });
                  })
            ],
          ))
        ],
      ),
    );
  }
}
