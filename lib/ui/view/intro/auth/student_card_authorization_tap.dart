import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SCAuthorizationTap extends StatefulWidget {
  @override
  _SCAuthorizationTapState createState() => _SCAuthorizationTapState();
}

class _SCAuthorizationTapState extends State<SCAuthorizationTap> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _universityController = TextEditingController();
  final TextEditingController _studentIDController = TextEditingController();

  File _image;
  bool _isUpload;
  bool _validate;

  List<ListTile> _item = [
    ListTile(title: Text('부경대학교')),
    ListTile(title: Text('서울대학교')),
    ListTile(title: Text('연세대학교')),
    ListTile(title: Text('부경대학교')),
    ListTile(title: Text('성균관대학교')),
    ListTile(title: Text('연세대학교')),
    ListTile(title: Text('연세대학교')),
    ListTile(title: Text('연세대학교')),
    ListTile(title: Text('연세대학교')),
    ListTile(title: Text('연세대학교')),
    ListTile(title: Text('연세대학교')),
  ];

  // dummy data
  List<DropdownMenuItem> _universityList = [
    DropdownMenuItem(child: Text('고려대학교'), value: '고려대학교'),
    DropdownMenuItem(child: Text('부경대학교'), value: '부경대학교'),
    DropdownMenuItem(child: Text('부산대학교'), value: '부산대학교'),
    DropdownMenuItem(child: Text('서울대학교'), value: '서울대학교'),
    DropdownMenuItem(child: Text('연세대학교'), value: '연세대학교'),
  ];

  List<DropdownMenuItem> _majorList = [
    DropdownMenuItem(child: Text('컴퓨터공학과'), value: '컴퓨터공학과'),
    DropdownMenuItem(child: Text('IT융합응용공학과'), value: 'IT융합응용공학과'),
    DropdownMenuItem(child: Text('간호학과'), value: '간호학과'),
    DropdownMenuItem(child: Text('전자공학과'), value: '전자공학과'),
    DropdownMenuItem(child: Text('현대무용학과'), value: '현대무용학과'),
  ];

  String _selectedUniversity;
  String _selectedMajor;

  bool isNotMeetingSameMajor = false;
  bool isNotMeetingSameUniversity = false;

  @override
  void initState() {
    _image = null;
    _isUpload = false;
    _validate = false;
    super.initState();
  }

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
                        overflow: TextOverflow.fade,
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
                              child: Stack(
                                children: [
                                  TextFormField(
                                    onTap: () {
                                      _dialogList(_universityList, '학교');
                                    },
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            10.0, 0, 10.0, 0),
                                        border: OutlineInputBorder(),
                                        hintText: '학교 검색'),
                                  ),
                                  Positioned(
                                      right: 4,
                                      bottom: 1,
                                      top: 1,
                                      child: Icon(Icons.search, size: 28.0))
                                ],
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
                              child: Stack(
                                children: [
                                  TextFormField(
                                    onTap: () {
                                      _dialogList(_universityList, '학과');
                                    },
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            10.0, 0, 10.0, 0),
                                        border: OutlineInputBorder(),
                                        hintText: '학과 검색'),
                                  ),
                                  Positioned(
                                      right: 4,
                                      bottom: 1,
                                      top: 1,
                                      child: Icon(Icons.search, size: 28.0))
                                ],
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
                                  child: Text('학과',
                                      style: TextStyle(fontSize: 18.0)),
                                  alignment: Alignment.center),
                            ),
                            Flexible(
                              flex: 3,
                              fit: FlexFit.tight,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                                    border: OutlineInputBorder(),
                                    hintText: '학번'),
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
                                      onPressed: () {}),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
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
                      child: Switch(
                        value: isNotMeetingSameUniversity,
                        onChanged: (value) =>
                            setState(() => isNotMeetingSameUniversity = value),
                      ),
                    ),
                    Flexible(flex: 1, fit: FlexFit.tight, child: Container()),
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
                      child: Switch(
                        value: isNotMeetingSameMajor,
                        onChanged: (value) =>
                            setState(() => isNotMeetingSameMajor = value),
                      ),
                    ),
                    Flexible(flex: 1, fit: FlexFit.tight, child: Container()),
                  ],
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
    _image = File(image.path);
    setState(() {
      _isUpload = true;
    });
  }

  Future<void> _dialogList(List item, String text) async {
    return showDialog(
      context: context,
      builder: (_) => Padding(
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
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                        border: OutlineInputBorder(),
                        hintText: '$text 검색'),
                  ),
                ),
                SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('검색된 $text', style: TextStyle(fontSize: 16))),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Card(
                      elevation: 3,
                      child: ListView.builder(
                        itemCount: _item.length,
                        itemBuilder: (_, index) {
                          return _item[index];
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
                        onPressed: () {}),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  showImage() {
    return _image == null
        ? Container()
        : Container(
            width: 300.0,
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black26, width: 1.0),
            ),
            child: Image.file(_image, fit: BoxFit.fill));
  }

  _successAuthorization(BuildContext context) {
    if (_formKey.currentState.validate()) {
      // No any error in validation
      Navigator.pop(
          context,
          [_universityController.text, _studentIDController.text, _image]
              .toList());
    } else {
      // validation error
      setState(() {
        _validate = true;
      });
    }
  }
}
