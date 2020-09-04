import 'dart:io';

import 'package:anony_chat/ui/widget/bottom_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SCCertification extends StatefulWidget {
  @override
  _SCCertificationState createState() => _SCCertificationState();
}

class _SCCertificationState extends State<SCCertification> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _universityController = TextEditingController();
  final TextEditingController _studentIDController = TextEditingController();

  File _image;
  bool _isUpload = true;
  bool _validate = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final guidanceText = '학생증인증 안내 텍스트\n\n\n\n\n\n\n\n\n\n\n\n\n\n\ 스크롤테스트';

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context)),
          centerTitle: true,
          title: Text('학생증인증하기', style: TextStyle(color: Colors.white))),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(children: [
              SizedBox(height: 24.0),
              Container(
                padding: EdgeInsets.all(8.0),
                width: 360.0,
                height: 240.0,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black26)),
                child: Center(
                    child: SingleChildScrollView(child: Text(guidanceText))),
              ),
              SizedBox(height: 24.0),
              Form(
                autovalidate: _validate,
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('학교', style: TextStyle(fontSize: 24.0)),
                        Container(
                          width: 240.0,
                          child: TextFormField(
                            controller: _universityController,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value.isEmpty) return '학교를 입력하세요.';
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: '학교 입력',
                              isDense: true,
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('학번', style: TextStyle(fontSize: 24.0)),
                        Container(
                          width: 240.0,
                          child: TextFormField(
                            controller: _studentIDController,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value.isEmpty) return '학번를 입력하세요.';
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: '학번 입력',
                              isDense: true,
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              showImage(),
              Container(
                width: 160.0,
                child: ButtonTheme(
                  buttonColor: Colors.amberAccent,
                  child: RaisedButton(
                      child: Text('학생증 업로드', style: TextStyle(fontSize: 20.0)),
                      onPressed: () {
                        uploadImage();
                        _isUpload = true;
                      }),
                ),
              ),
            ]),
            SizedBox(height: 32.0),
            BottomButton(
                onPressed: _isUpload ? () {
                        _successCertification();
                      }
                    : null,
                text: '인증하기'),
            SizedBox(height: size.height * 0.05)
          ],
        ),
      ),
    );
  }

  Future uploadImage() async {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(image.path);
    });
  }

  showImage() {
    return _image == null
        ? Container()
        : Container(
            width: 350.0,
            height: 300,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Image.file(_image, fit: BoxFit.fill),
            ));
  }

  _successCertification() {
    if (_formKey.currentState.validate()) {
      // No any error in validation
    } else {
      // validation error
      setState(() {
        _validate=true;
      });
    }
  }
}
