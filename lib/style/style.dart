import 'package:flutter/widgets.dart';

class Style {
  static final Style instance = Style._private();
  var _mContext;
  Size _size;

  Style._private();

  Style of(BuildContext context) {
    _mContext = context;
    return this;
  }

  Size get size => _size;

  void initScreenSize() {
    _size = MediaQuery.of(_mContext).size;
  }
}
