import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Center(
          child: SpinKitThreeBounce(
            color: Colors.indigo,
            size: 64.0,
          ),
        ),
      ),
    );
  }
}
