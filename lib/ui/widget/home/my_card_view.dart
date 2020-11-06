import 'package:anony_chat/utils/utill.dart';
import 'package:flutter/material.dart';

class MyCardView extends StatefulWidget {
  MyCardView({this.customerUid});

  final customerUid;

  getCustomerUid() => customerUid;

  @override
  _MyCardViewState createState() => _MyCardViewState();
}

class _MyCardViewState extends State<MyCardView> {
  @override
  Widget build(BuildContext context) {
    return widget.customerUid != null
        ? Container(
            child: new Card(
              elevation: 5,
              child: Center(child: Text('${widget.customerUid}')),
            ),
          )
        : GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/card_registration_page')
                .then((value) {
              setState(() {});
            }),
            child: Container(
              child: new Card(
                elevation: 5,
                child: Icon(Icons.add, size: 50, color: chatPrimaryColor),
              ),
            ),
          );
  }
}
