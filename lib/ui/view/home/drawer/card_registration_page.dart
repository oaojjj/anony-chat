import 'package:anony_chat/controller/hive_controller.dart';
import 'package:anony_chat/ui/widget/bottom_button.dart';
import 'package:anony_chat/utils/utill.dart';
import 'package:anony_chat/viewmodel/card_http_model.dart';
import 'package:flutter/material.dart';

class CardRegistrationPage extends StatefulWidget {
  @override
  _CardRegistrationPageState createState() => _CardRegistrationPageState();
}

class _CardRegistrationPageState extends State<CardRegistrationPage> {
  final _cardHttpModel = CardHttpModel();
  final _formKey = GlobalKey<FormState>();
  final _focusNode = [FocusNode(), FocusNode(), FocusNode(), FocusNode()];
  final _cardNumberController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  final _cardPWController = TextEditingController();
  final _birthController = TextEditingController();

  final monthList = [
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12'
  ];

  final yearList = ['2020', '2021', '2022', '2023', '2024', '2025', '2026'];

  String _selectedMonth;
  String _selectedYear;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('카드 등록'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Center(
                  child: Container(
                    width: double.infinity,
                    height: 250,
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('카드 번호')),
                              SizedBox(height: 4.0),
                              Row(
                                children: [
                                  Flexible(
                                      fit: FlexFit.tight,
                                      flex: 1,
                                      child: buildCardNumberContainer(0)),
                                  SizedBox(width: 16),
                                  Flexible(
                                      fit: FlexFit.tight,
                                      flex: 1,
                                      child: buildCardNumberContainer(1)),
                                  SizedBox(width: 16),
                                  Flexible(
                                      fit: FlexFit.tight,
                                      flex: 1,
                                      child: buildCardNumberContainer(2,
                                          obscureText: true)),
                                  SizedBox(width: 16),
                                  Flexible(
                                      fit: FlexFit.tight,
                                      flex: 1,
                                      child: buildCardNumberContainer(3,
                                          obscureText: true)),
                                ],
                              ),
                              SizedBox(height: 16.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('카드 유효기간'),
                                  Text('카드 비밀번호 앞 두자리'),
                                ],
                              ),
                              Row(
                                children: [
                                  buildCardValidity(monthList, 'MM'),
                                  SizedBox(width: 8),
                                  buildCardValidity(yearList, 'YYYY'),
                                  Spacer(),
                                  Container(
                                    height: 32,
                                    width: 64,
                                    child: TextFormField(
                                      controller: _cardPWController,
                                      keyboardType: TextInputType.number,
                                      maxLength: 2,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        counterText: "",
                                        contentPadding: EdgeInsets.fromLTRB(
                                            10.0, 0, 10.0, 0),
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 8.0),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('생년월일')),
                              SizedBox(height: 4.0),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  height: 32,
                                  width: 80,
                                  child: TextFormField(
                                    controller: _birthController,
                                    keyboardType: TextInputType.number,
                                    maxLength: 6,
                                    decoration: InputDecoration(
                                      hintText: '970608',
                                      counterText: "",
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 32.0),
                child: BottomButton(
                    text: '등록',
                    onPressed: () async {
                      if (_checkedData()) {
                        final userId = HiveController.instance.getMemberID();
                        final customerUid = userId.toString() +
                            '_' +
                            _birthController.text +
                            '_' +
                            _cardNumberController[0].text +
                            _cardNumberController[1].text +
                            _cardNumberController[2].text +
                            _cardNumberController[3].text;

                        final cardNumber = _cardNumberController[0].text +
                            '-' +
                            _cardNumberController[1].text +
                            '-' +
                            _cardNumberController[2].text +
                            '-' +
                            _cardNumberController[3].text;

                        final result = await _cardHttpModel.addImportApiCard(
                            cardNumber: cardNumber,
                            birth: _birthController.text,
                            expiry: _selectedYear + '-' + _selectedMonth,
                            pwd2Digit: _cardPWController.text,
                            customerUid: customerUid);

                        print(result.toString());
                        if (result['code'] == -1) {
                          showToast(result['message']);
                        } else {
                          final cardAddResult =
                              await _cardHttpModel.addCard(customerUid);
                          if (cardAddResult.code == ResponseCode.SUCCESS_CODE) {
                            showToast('카드 등록에 성공했습니다.');
                            Navigator.popUntil(
                                context, ModalRoute.withName('/payment_page'));
                          } else {
                            showToast('카드 등록에 실패했습니다.');
                          }
                        }
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Align buildCardValidity(List<String> item, type) {
    return Align(
      alignment: Alignment.centerLeft,
      child: DropdownButton<String>(
        value: type == 'MM' ? _selectedMonth : _selectedYear,
        hint: Text(type),
        items: item.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Container(
                width: 40,
                child: Text(
                  value,
                  style: TextStyle(color: Colors.black),
                )),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            type == 'MM' ? _selectedMonth = newValue : _selectedYear = newValue;
          });
        },
      ),
    );
  }

  Container buildCardNumberContainer(index, {obscureText = false}) {
    return Container(
      height: 32,
      width: 64,
      child: TextFormField(
        focusNode: _focusNode[index],
        controller: _cardNumberController[index],
        keyboardType: TextInputType.number,
        obscureText: obscureText,
        maxLength: 4,
        decoration: InputDecoration(
          counterText: "",
          contentPadding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          border: OutlineInputBorder(),
        ),
        onChanged: (text) {
          if (text.length >= 4) {
            _focusNode[index].unfocus();
            if (index < 4) _focusNode[index + 1].requestFocus();
          }
        },
      ),
    );
  }

  bool _checkedData() {
    bool b = false;
    _cardNumberController.forEach((element) {
      if (element.text.length < 4) b = true;
    });
    if (b) {
      showToast('카드 번호를 정확하게 입력해주세요.');
      return false;
    }
    if (_selectedYear == null || _selectedMonth == null) {
      showToast('카드 유효기간을 확인해주세요.');
      return false;
    }
    if (_cardPWController.text.length != 2) {
      showToast('카드 비밀번호를 확인해주세요.');
      return false;
    }
    if (_birthController.text.length != 6) {
      showToast('생년월일을 확인해주세요.');
      return false;
    }
    return true;
  }
}
