import 'package:flutter/material.dart';

class PhoneVerificationTap extends StatefulWidget {
  @override
  _PhoneVerificationTapState createState() => _PhoneVerificationTapState();
}

class _PhoneVerificationTapState extends State<PhoneVerificationTap> {
  bool _isRequested = false;
  bool _isSuccessAuth = false;
  String _requestString = '인증요청';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0, bottom: 4.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "전화번호",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          Form(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 240,
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                            border: OutlineInputBorder(),
                            hintText: '전화번호'),
                      ),
                    ),
                    RaisedButton(
                        child: Text(_requestString,
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          requestPhoneAuth();
                        })
                  ],
                ),
                SizedBox(height: 8),
                _isRequested
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: 240,
                                child: TextFormField(
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                                      border: OutlineInputBorder(),
                                      hintText: '인증번호'),
                                ),
                              ),
                              Positioned(
                                  top: 16,
                                  bottom: 16,
                                  right: 16,
                                  child: Text(
                                    '1:59',
                                    style: TextStyle(color: Colors.indigo),
                                  ))
                            ],
                          ),
                          RaisedButton(
                              child: Text('확인',
                                  style: TextStyle(color: Colors.white)),
                              onPressed: _isSuccessAuth ? () {} : null),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void requestPhoneAuth() {
    setState(() {
      _requestString = '재전송';
      _isRequested = true;
    });
  }
}
