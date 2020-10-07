import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PhoneCertification extends StatefulWidget {
  @override
  _PhoneCertificationState createState() => _PhoneCertificationState();
}

class _PhoneCertificationState extends State<PhoneCertification> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            '본인인증',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Card(
                elevation: 3,
                child: Column(
                  children: [
                    SvgPicture.asset(
                      'phone_certification_icon.svg',
                      height: 50,
                      width: 50,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
