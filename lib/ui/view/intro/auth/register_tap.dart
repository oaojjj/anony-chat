import 'package:anony_chat/provider/register_provider.dart';
import 'package:anony_chat/utils/utill.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterTap extends StatefulWidget {
  @override
  _RegisterTapState createState() => _RegisterTapState();
}

class _RegisterTapState extends State<RegisterTap> {
  // true#남성 false#여성
  bool sexBtnColor = true;

  // test data
  List<String> _itemsBirth = List<String>.generate(30, (i) {
    if (i == 0)
      return '선택';
    else
      return (i + 1990).toString();
  });

  List<String> _itemsRegion = [
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Column(
        children: [
          Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Align(
                    child: Text('성별', style: TextStyle(fontSize: 18)),
                    alignment: Alignment.centerLeft,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Consumer<RegisterProvider>(
                          builder: (_, value, __) => RaisedButton(
                            child: Text('남자',
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.white)),
                            onPressed: () {
                              _canNextStep();
                              value.member.sex = '남자';
                              setState(() => sexBtnColor = true);
                            },
                            color: sexBtnColor ? chatPrimaryColor : Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Consumer<RegisterProvider>(
                          builder: (_, value, __) => RaisedButton(
                            child: Text('여자',
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.white)),
                            onPressed: () {
                              _canNextStep();
                              value.member.sex = '여자';
                              setState(() => sexBtnColor = false);
                            },
                            color:
                                !sexBtnColor ? chatPrimaryColor : Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child:
                              Text('태어난 해', style: TextStyle(fontSize: 18.0))),
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: GestureDetector(
                          onTap: () => _showPicker(context, _itemsBirth),
                          child: Container(
                            height: 40,
                            child: Card(
                              child: Row(
                                children: [
                                  Flexible(
                                      fit: FlexFit.tight,
                                      flex: 3,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Consumer<RegisterProvider>(
                                          builder: (_, value, __) => Text(
                                              value.member.birthYear == null
                                                  ? "선택"
                                                  : value.member.birthYear
                                                      .toString()),
                                        ),
                                      )),
                                  Flexible(
                                      fit: FlexFit.tight,
                                      flex: 1,
                                      child: Icon(Icons.arrow_drop_down))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Text('지역', style: TextStyle(fontSize: 18.0))),
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: GestureDetector(
                          onTap: () {
                            _showPicker(context, _itemsRegion);
                          },
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
                                            const EdgeInsets.only(left: 8.0),
                                        child: Consumer<RegisterProvider>(
                                          builder: (_, value, __) => Text(
                                              value.member.region == null
                                                  ? "선택"
                                                  : value.member.region),
                                        ),
                                      )),
                                  Flexible(
                                      fit: FlexFit.tight,
                                      flex: 1,
                                      child: Icon(Icons.arrow_drop_down))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.error),
              SizedBox(width: 4),
              Expanded(
                child: Text(
                  '회원 정보는 설정에서 언제든 변경 가능합니다.',
                  style: TextStyle(fontSize: 12),
                  maxLines: 1,
                  overflow: TextOverflow.visible,
                ),
              )
            ],
          )
        ],
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
              onTap: () {
                Navigator.pop(context);
                _canNextStep();
              },
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

                    item == _itemsBirth
                        ? rp.member.birthYear =
                            item[index] == '선택' ? null : int.parse(item[index])
                        : rp.member.region = item[index];
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

  _canNextStep() {
    final rp = Provider.of<RegisterProvider>(context, listen: false);
    if ((rp.member.region == '선택' || rp.member.region == null) ||
        (rp.member.birthYear == -1 || rp.member.birthYear == null)) {
      rp.onCantNextStep();
    } else {
      rp.onNextStep();
    }
  }
}
