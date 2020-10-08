import 'package:anony_chat/controller/hive_controller.dart';
import 'package:anony_chat/controller/http_controller.dart';
import 'package:anony_chat/provider/register_provider.dart';
import 'package:anony_chat/ui/widget/bottom_button.dart';
import 'package:anony_chat/ui/widget/loading.dart';
import 'package:anony_chat/utils/utill.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SCAuthorizationPage extends StatefulWidget {
  @override
  _SCAuthorizationPageState createState() => _SCAuthorizationPageState();
}

class _SCAuthorizationPageState extends State<SCAuthorizationPage> {
  final _formKey = GlobalKey<FormState>();
  final _focusNode = [FocusNode(), FocusNode()];
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _studentIDController = TextEditingController();

  RegExp regExp = RegExp(r'^[+-]?([0-9]+([0-9]*)?|[0-9]+)$');

  bool loading = true;

  bool _checkFlag = false;
  int _checkedPrev = -1;
  String stdCardImage;

  List<bool> _selected = [];
  List<String> _searchResult = [];
  List<String> _universityList = [];
  List<String> _majorList = [];
  List<String> _cityList = [
    '선택',
    '서울',
    '부산',
    '대구',
    '인천',
    '광주',
    '대전',
    '울산',
    '세종',
    '경기',
    '강원',
    '충북',
    '충남',
    '전북',
    '전남',
    '경북',
    '경남',
    '제주',
  ];

  _fetchData() {
    _universityList = HttpController.instance.fetchDataUniversity();
    _majorList = HttpController.instance.fetchDataMajor();

    // 데이터 받아오지 못함 -> 무한로딩
    if (_universityList != null && _majorList != null)
      setState(() => loading = false);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _fetchData();
      Provider.of<RegisterProvider>(context, listen: false).reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : SafeArea(
            child: WillPopScope(
              onWillPop: () async {
                _showDialogAllDataDelete();
                return true;
              },
              child: Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.white12,
                  iconTheme: IconThemeData(color: Colors.black),
                  centerTitle: true,
                  title: Text(
                    '회원 정보 입력',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                body: GestureDetector(
                  onTap: () => _focusNode[1].unfocus(),
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      child: Container(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 4.0),
                              child: Card(
                                elevation: 3,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24.0, vertical: 4.0),
                                  child: Row(
                                    children: [
                                      Flexible(
                                          flex: 1,
                                          fit: FlexFit.tight,
                                          child: Text('내 지역',
                                              style:
                                                  TextStyle(fontSize: 16.0))),
                                      Flexible(
                                        flex: 2,
                                        fit: FlexFit.tight,
                                        child: GestureDetector(
                                          onTap: () =>
                                              _showPicker(context, _cityList),
                                          child: Container(
                                            height: 40.0,
                                            child: Card(
                                              child: Row(
                                                children: [
                                                  Flexible(
                                                    fit: FlexFit.tight,
                                                    flex: 3,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: Consumer<
                                                          RegisterProvider>(
                                                        builder: (_, value,
                                                                __) =>
                                                            Text(value.member
                                                                        .city ==
                                                                    null
                                                                ? '선택'
                                                                : value.member
                                                                    .city),
                                                      ),
                                                    ),
                                                  ),
                                                  Flexible(
                                                      fit: FlexFit.tight,
                                                      flex: 1,
                                                      child: Icon(Icons
                                                          .arrow_drop_down))
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Card(
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 24, top: 16, bottom: 24),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16.0, bottom: 4.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                      ),
                                      Row(
                                        children: [
                                          Flexible(
                                            flex: 1,
                                            fit: FlexFit.tight,
                                            child: Align(
                                              child: Text('학교',
                                                  style: TextStyle(
                                                      fontSize: 18.0)),
                                              alignment: Alignment.center,
                                            ),
                                          ),
                                          Flexible(
                                            flex: 3,
                                            fit: FlexFit.tight,
                                            child: GestureDetector(
                                              onTap: () => _showDialogList(
                                                  _universityList,
                                                  '학교',
                                                  _focusNode[0]),
                                              child: Container(
                                                height: 50.0,
                                                width: 100.0,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 0.5),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(4.0),
                                                  ),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Flexible(
                                                      fit: FlexFit.tight,
                                                      flex: 5,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8.0),
                                                        child: Consumer<
                                                            RegisterProvider>(
                                                          builder:
                                                              (_, value, __) =>
                                                                  Text(
                                                            value.member.university ==
                                                                    null
                                                                ? '학교 검색'
                                                                : value.member
                                                                    .university,
                                                            style: TextStyle(
                                                                color: value.member
                                                                            .university ==
                                                                        null
                                                                    ? Colors
                                                                        .grey
                                                                    : Colors
                                                                        .black,
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Flexible(
                                                        fit: FlexFit.tight,
                                                        flex: 1,
                                                        child:
                                                            Icon(Icons.search))
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
                                                  style: TextStyle(
                                                      fontSize: 18.0)),
                                              alignment: Alignment.center,
                                            ),
                                          ),
                                          Flexible(
                                            flex: 3,
                                            fit: FlexFit.tight,
                                            child: GestureDetector(
                                              onTap: () => _showDialogList(
                                                  _majorList,
                                                  '학과',
                                                  _focusNode[0]),
                                              child: Container(
                                                height: 50.0,
                                                width: 100.0,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color: Colors.black,
                                                        width: 0.5),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                4.0))),
                                                child: Row(
                                                  children: [
                                                    Flexible(
                                                      fit: FlexFit.tight,
                                                      flex: 5,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8.0),
                                                        child: Consumer<
                                                            RegisterProvider>(
                                                          builder: (_, value, __) => Text(
                                                              value.member.major ==
                                                                      null
                                                                  ? '학과 검색'
                                                                  : value.member
                                                                      .major,
                                                              style: TextStyle(
                                                                  color: value.member
                                                                              .major ==
                                                                          null
                                                                      ? Colors
                                                                          .grey
                                                                      : Colors
                                                                          .black,
                                                                  fontSize:
                                                                      16)),
                                                        ),
                                                      ),
                                                    ),
                                                    Flexible(
                                                        fit: FlexFit.tight,
                                                        flex: 1,
                                                        child:
                                                            Icon(Icons.search))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            flex: 1,
                                            fit: FlexFit.tight,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Align(
                                                  child: Text('학번',
                                                      style: TextStyle(
                                                          fontSize: 18.0)),
                                                  alignment: Alignment.center),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 3,
                                            fit: FlexFit.tight,
                                            child: Form(
                                              key: _formKey,
                                              child: TextFormField(
                                                focusNode: _focusNode[1],
                                                controller:
                                                    _studentIDController,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.fromLTRB(
                                                            10.0, 0, 10.0, 0),
                                                    border:
                                                        OutlineInputBorder(),
                                                    hintText: '학번'),
                                                onChanged: (text) {
                                                  final rp = Provider.of<
                                                          RegisterProvider>(
                                                      context,
                                                      listen: false);
                                                  rp.setStudentID(
                                                      int.parse(text));
                                                  rp.checkCanRegister();
                                                },
                                                validator: validatePassword,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      stdCardImage == null
                                          ? Container()
                                          : Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 75.0),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Image.asset(stdCardImage,
                                                    fit: BoxFit.fill,
                                                    height: 50,
                                                    width: 50),
                                              ),
                                            ),
                                      SizedBox(height: 4),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Flexible(
                                            flex: 1,
                                            fit: FlexFit.tight,
                                            child: Align(
                                                child: Text('학생증',
                                                    style: TextStyle(
                                                        fontSize: 18.0)),
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
                                                    onPressed: uploadImage),
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Consumer<RegisterProvider>(
                              builder: (_, rp, __) => Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, top: 4.0, bottom: 4.0),
                                    child: Row(
                                      children: [
                                        InkWell(
                                          highlightColor: Colors.transparent,
                                          splashColor: Colors.transparent,
                                          onTap: rp.onCheckShowMyInfo,
                                          child: Row(
                                            children: [
                                              Icon(Icons.check,
                                                  color: rp.member.isShowMyInfo
                                                      ? chatPrimaryColor
                                                      : Colors.grey),
                                              SizedBox(
                                                width: 24,
                                              ),
                                              Text('회원정보 공개',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color:
                                                          rp.member.isShowMyInfo
                                                              ? chatPrimaryColor
                                                              : Colors.black))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.error,
                                          size: 20,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            '회원님과 상대방 모두 공개일때만 회원정보가 공개됩니다',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey),
                                            overflow: TextOverflow.visible,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Divider(
                                        thickness: 0.5, color: Colors.grey),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, top: 4.0, bottom: 4.0),
                                    child: Row(
                                      children: [
                                        InkWell(
                                          highlightColor: Colors.transparent,
                                          splashColor: Colors.transparent,
                                          onTap: () => rp
                                              .onCheckNotMeetingSameUniversity(),
                                          child: Row(
                                            children: [
                                              Icon(Icons.check,
                                                  color: rp.member
                                                          .isNotMeetingSameUniversity
                                                      ? chatPrimaryColor
                                                      : Colors.grey),
                                              SizedBox(
                                                width: 24,
                                              ),
                                              Text(
                                                '같은 학교 학생 안만나기',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: rp.member
                                                            .isNotMeetingSameUniversity
                                                        ? chatPrimaryColor
                                                        : Colors.black),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, top: 4.0, bottom: 4.0),
                                    child: Row(
                                      children: [
                                        InkWell(
                                          highlightColor: Colors.transparent,
                                          splashColor: Colors.transparent,
                                          onTap: () =>
                                              rp.onCheckNotMeetingSameMajor(),
                                          child: Row(
                                            children: [
                                              Icon(Icons.check,
                                                  color: rp.member
                                                          .isNotMeetingSameMajor
                                                      ? chatPrimaryColor
                                                      : Colors.grey),
                                              SizedBox(
                                                width: 24,
                                              ),
                                              Text('같은 학교의 같은 학과 학생 안만나기',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: rp.member
                                                              .isNotMeetingSameMajor
                                                          ? chatPrimaryColor
                                                          : Colors.black))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 32),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24.0),
                              child: BottomButton(
                                onPressed:
                                    Provider.of<RegisterProvider>(context)
                                            .isCanRegister
                                        ? _register
                                        : null,
                                text: '가입하기',
                              ),
                            ),
                            SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  Future uploadImage() async {
    final imageFile = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() => stdCardImage = imageFile.path);
  }

  Future<void> _showDialogAllDataDelete() async {
    _focusNode[1].unfocus();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (_) {
        return AlertDialog(
          title: Text('주의', style: TextStyle(color: chatPrimaryColor)),
          content: Text('처음부터 다시 작성하셔야 합니다. \n그래도 뒤로가겠습니까?'),
          actions: <Widget>[
            FlatButton(
              child: Text('취소', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('확인', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.popUntil(
                    context, ModalRoute.withName(Navigator.defaultRouteName));
              },
            ),
          ],
        );
      },
    );
  }

  // 학교, 학과 다이얼로그 리스트
  Future<void> _showDialogList(
      List item, String text, FocusNode focusNode) async {
    _resetDialogData();
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
                        focusNode: focusNode,
                        controller: _textController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                            border: OutlineInputBorder(),
                            hintText: '$text 검색'),
                        onChanged: (text) {
                          _onSearchTextChanged(text, item, setState);
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
                        child: Scrollbar(
                          child: ListView.builder(
                            itemCount: _searchResult.length,
                            itemBuilder: (_, index) {
                              return GestureDetector(
                                onTap: () {
                                  focusNode.unfocus();
                                  _checkOnlyOneItem(setState, index);
                                },
                                child: ListTile(
                                  title: Row(
                                    children: <Widget>[
                                      Icon(Icons.check,
                                          color: _selected[index]
                                              ? chatPrimaryColor
                                              : Colors.transparent),
                                      SizedBox(width: 5),
                                      Container(
                                        width: 250,
                                        child: Text(_searchResult[index],
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(
                                                color: _selected[index]
                                                    ? chatPrimaryColor
                                                    : Colors.black)),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
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
                              rp.setUniversityInfo(
                                  _searchResult[_checkedPrev], text);
                              rp.checkCanRegister();
                            }
                            Navigator.pop(context);
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _showPicker(
    context,
    List<String> item,
  ) {
    return showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 300,
            color: Colors.white,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: CupertinoPicker.builder(
                  itemExtent: 50,
                  childCount: item.length,
                  diameterRatio: 10,
                  squeeze: 1,
                  backgroundColor: Colors.grey[100],
                  onSelectedItemChanged: (index) {
                    final rp =
                        Provider.of<RegisterProvider>(context, listen: false);
                    rp.setCity(item[index]);
                    rp.checkCanRegister();
                  },
                  itemBuilder: (_, index) => Center(
                    child: Text(item[index],
                        style: TextStyle(color: Colors.black)),
                  ),
                ),
              ),
            ),
          );
        });
  }

  _resetDialogData() {
    _searchResult.clear();
    _textController.clear();
    _checkFlag = false;
    _checkedPrev = -1;
  }

  // 다이어로그창때 학교, 학과를 하나만 선택할 수 있는 메소드
  _checkOnlyOneItem(StateSetter ss, int index) {
    // 선택이 안되어 있다면
    ss(() {
      if (!_checkFlag) {
        _selected[index] = !_selected[index];
        _checkFlag = true;
      } else {
        if (index == _checkedPrev) {
          _selected[index] = !_selected[index];
          _checkFlag = false;
        } else {
          _selected[index] = !_selected[index];
          _selected[_checkedPrev] = !_selected[_checkedPrev];
        }
      }
      _checkedPrev = index;
    });
  }

  _onSearchTextChanged(String text, item, ss) {
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

    if (_checkFlag) {
      _selected[_checkedPrev] = false;
      _checkFlag = false;
    }

    ss(() {});
  }

  _register() {
    if (_checkedValidate()) {
      print('숫자만 입력');
      return;
    } else {
      //register
      final rp = Provider.of<RegisterProvider>(context, listen: false);
      print(rp.member.toString());
      rp.setFCMToken(HiveController.instance.getFCMToken());
      Navigator.pushNamed(context, '/main_page');
    }
  }

  String validatePassword(String value) {
    print(value);
    if (!regExp.hasMatch(value)) {
      return '숫자만 입력해주세요.';
    } else if (value.length > 11) {
      return '학번을 정확하게 입력해주세요.';
    } else {
      // something
      return null;
    }
  }

  bool _checkedValidate() {
    if (_formKey.currentState.validate()) {
      // success
      return false;
    } else {
      // fail
      return true;
    }
  }
}
