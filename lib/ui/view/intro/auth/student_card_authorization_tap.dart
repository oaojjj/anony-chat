import 'dart:io';

import 'package:anony_chat/provider/register_provider.dart';
import 'package:anony_chat/utils/utill.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SCAuthorizationTap extends StatefulWidget {
  @override
  _SCAuthorizationTapState createState() => _SCAuthorizationTapState();
}

class _SCAuthorizationTapState extends State<SCAuthorizationTap> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _studentIDController = TextEditingController();

  bool _checkFlag = false;
  int _checkedPrev;

  List<bool> _selected = [];

  // dummy data
  List<String> _searchResult = [];

  List<String> _universityList = [
    '부경대학교',
    '서울대학교',
    '연세대학교',
    '대구대학교',
    '성균관대학교',
    '경기대학교',
    '부산대학교',
    '부산교육대학',
    '부산디지털대학교',
    '경북대학교',
    '고려대학교',
    '경성대학교',
    '포항공과대학'
  ];

  List<String> _majorList = [
    '컴퓨터공학과',
    'IT 융합응용공학과',
    '간호학과',
    '전자공학과',
    '현대무용학과',
  ];

  bool isNotMeetingSameMajor = false;
  bool isNotMeetingSameUniversity = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 420,
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.error),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        '학생증 인증이 완료된 후 정상적으로 서비스를 이용할 수 있습니다.',
                        style: TextStyle(fontSize: 12),
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8, right: 16, top: 16, bottom: 16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Align(
                                child: Text('학교',
                                    style: TextStyle(fontSize: 18.0)),
                                alignment: Alignment.center,
                              ),
                            ),
                            Flexible(
                              flex: 3,
                              fit: FlexFit.tight,
                              child: GestureDetector(
                                onTap: () => _dialogList(_universityList, '학교'),
                                child: Container(
                                  height: 50.0,
                                  width: 100.0,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.black, width: 0.5),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.0))),
                                  child: Row(
                                    children: [
                                      Flexible(
                                          fit: FlexFit.tight,
                                          flex: 5,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Consumer<RegisterProvider>(
                                              builder: (_, value, __) => Text(
                                                  value.member.university ==
                                                          null
                                                      ? '학교 검색'
                                                      : value.member.university,
                                                  style: TextStyle(
                                                      color: value.member
                                                                  .university ==
                                                              null
                                                          ? Colors.grey
                                                          : Colors.black,
                                                      fontSize: 16)),
                                            ),
                                          )),
                                      Flexible(
                                          fit: FlexFit.tight,
                                          flex: 1,
                                          child: Icon(Icons.search))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Align(
                                child: Text('학과',
                                    style: TextStyle(fontSize: 18.0)),
                                alignment: Alignment.center,
                              ),
                            ),
                            Flexible(
                              flex: 3,
                              fit: FlexFit.tight,
                              child: GestureDetector(
                                onTap: () => _dialogList(_majorList, '학과'),
                                child: Container(
                                  height: 50.0,
                                  width: 100.0,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.black, width: 0.5),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.0))),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        fit: FlexFit.tight,
                                        flex: 5,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Consumer<RegisterProvider>(
                                            builder: (_, value, __) => Text(
                                                value.member.major == null
                                                    ? '학과 검색'
                                                    : value.member.major,
                                                style: TextStyle(
                                                    color: value.member.major ==
                                                            null
                                                        ? Colors.grey
                                                        : Colors.black,
                                                    fontSize: 16)),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                          fit: FlexFit.tight,
                                          flex: 1,
                                          child: Icon(Icons.search))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Align(
                                  child: Text('학번',
                                      style: TextStyle(fontSize: 18.0)),
                                  alignment: Alignment.center),
                            ),
                            Flexible(
                              flex: 3,
                              fit: FlexFit.tight,
                              child: TextFormField(
                                controller: _studentIDController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                                    border: OutlineInputBorder(),
                                    hintText: '학번'),
                                onChanged: (text) {
                                  Provider.of<RegisterProvider>(context,
                                          listen: false)
                                      .member
                                      .studentID = int.parse(text);
                                  if (text.length == 9) _canNextStep();
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Align(
                                  child: Text('학생증',
                                      style: TextStyle(fontSize: 18.0)),
                                  alignment: Alignment.center),
                            ),
                            Flexible(
                                flex: 3,
                                fit: FlexFit.tight,
                                child: ButtonTheme(
                                  buttonColor: Colors.black,
                                  child: RaisedButton(
                                      textColor: Colors.white,
                                      child: Text('업로드'),
                                      onPressed: () {
                                        uploadImage();
                                        _canNextStep();
                                      }),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                              flex: 3,
                              fit: FlexFit.tight,
                              child: Text('같은 학교 학생 안만나기',
                                  style: TextStyle(fontSize: 16.0))),
                          Flexible(
                            flex: 1,
                            fit: FlexFit.loose,
                            child: Consumer<RegisterProvider>(
                              builder: (_, rp, __) => Container(
                                height: 35,
                                child: Switch(
                                  activeColor: chatPrimaryColor,
                                  value: rp.member.isNotMeetingSameUniversity,
                                  onChanged: (value) => setState(() => rp
                                      .member.isNotMeetingSameUniversity = value),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                              flex: 1, fit: FlexFit.tight, child: Container()),
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(
                              flex: 3,
                              fit: FlexFit.tight,
                              child: Text('같은 학과 학생 안만나기',
                                  style: TextStyle(fontSize: 16.0))),
                          Flexible(
                            flex: 1,
                            fit: FlexFit.loose,
                            child: Consumer<RegisterProvider>(
                              builder: (_, rp, __) => Container(
                                height: 35,
                                child: Switch(
                                  activeColor: chatPrimaryColor,
                                  value: rp.member.isNotMeetingSameMajor,
                                  onChanged: (value) => setState(() =>
                                      rp.member.isNotMeetingSameMajor = value),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                              flex: 1, fit: FlexFit.tight, child: Container()),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future uploadImage() async {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);
    //Provider.of<RegisterProvider>(context).member.studentCardImage = File(image.path);
  }

  Future<void> _dialogList(List item, String text) async {
    resetDialogData();
    return showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (_, setState) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Material(
            type: MaterialType.card,
            child: Container(
              height: 500,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text('$text 검색',
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: IconButton(
                            icon: Icon(Icons.close, size: 32.0),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                      )
                    ],
                  ),
                  SizedBox(height: 24.0),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                        controller: _textController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                            border: OutlineInputBorder(),
                            hintText: '$text 검색'),
                        onChanged: (text) {
                          onSearchTextChanged(text, item, setState);
                        }),
                  ),
                  SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child:
                            Text('검색된 $text', style: TextStyle(fontSize: 16))),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Card(
                        elevation: 3,
                        child: ListView.builder(
                          itemCount: _searchResult.length,
                          itemBuilder: (_, index) {
                            return GestureDetector(
                              onTap: () => checkOnlyOneLogic(setState, index),
                              child: ListTile(
                                title: Row(
                                  children: <Widget>[
                                    Icon(Icons.check,
                                        color: _selected[index]
                                            ? chatPrimaryColor
                                            : Colors.transparent),
                                    SizedBox(width: 5),
                                    Text(_searchResult[index],
                                        style: TextStyle(
                                            color: _selected[index]
                                                ? chatPrimaryColor
                                                : Colors.black))
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ButtonTheme(
                      minWidth: double.infinity,
                      buttonColor: Colors.black,
                      child: RaisedButton(
                          child: Text('확인'),
                          textColor: Colors.white,
                          onPressed: () {
                            final rp = Provider.of<RegisterProvider>(context,
                                listen: false);
                            if (_checkedPrev != -1) {
                              if (text == '학교')
                                this.setState(() => rp.member.university =
                                    _searchResult[_checkedPrev]);
                              else
                                this.setState(() => rp.member.major =
                                    _searchResult[_checkedPrev]);
                            }
                            _canNextStep();
                            Navigator.pop(context);
                          }),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void resetDialogData() {
    _searchResult.clear();
    _textController.clear();
    _checkFlag = false;
    _checkedPrev = -1;
  }

  // 다이어로그창때 학교, 학과를 하나만 선택할 수 있는 메소드
  void checkOnlyOneLogic(StateSetter ss, int index) {
    if (!_checkFlag) {
      ss(() => _selected[index] = !_selected[index]);
      _checkedPrev = index;
      _checkFlag = true;
    } else {
      if (_checkedPrev == index) {
        ss(() => _selected[index] = !_selected[index]);
        _checkFlag = false;
        _checkedPrev = -1;
      }
    }
  }

  onSearchTextChanged(String text, item, ss) {
    _searchResult.clear();
    _selected.clear();
    if (text.isEmpty) {
      ss(() {});
      return;
    }

    item.forEach((String value) {
      if (value.contains(text)) {
        _searchResult.add(value);
        _selected.add(false);
      }
    });
    ss(() {});
  }

  _canNextStep() {
    final rp = Provider.of<RegisterProvider>(context, listen: false);
    if ((rp.member.university == null || rp.member.major == null) ||
        (rp.member.studentID == null)) {
      rp.onCantNextStep();
    } else{
      rp.registerReady();
    }

  }
}
