import 'dart:ui';

import 'package:anony_chat/model/TermsData.dart';
import 'package:flutter/material.dart';

class TermsDataAPI {
  List<TermsData> mItems;
  State mWidget;
  bool allAgree = false;

  TermsDataAPI(this.mItems, this.mWidget);

  ListTile createTerms(int index) {
    if (index == mItems.length) return createFooter();

    String title;
    if (mItems[index].required)
      title = '(필수) ' + mItems[index].title;
    else
      title = '(선택) ' + mItems[index].title;
    return ListTile(
      leading: Checkbox(
        value: mItems[index].isChecked,
        onChanged: (value) {
          mWidget.setState(() {
            mItems[index].isChecked = value;
          });
        },
      ),
      title: Text(title),
      trailing: RaisedButton(
          child: Text("약관보기"),
          onPressed: () {
            // TODO 약관보기 페이지 만들기
          }),
    );
  }

  ListTile createFooter() {
    return ListTile(
      leading: Checkbox(
        value: allAgree,
        onChanged: (value) {
          mWidget.setState(() {
            allAgree = value;
          });
        },
      ),
      title: Text(
        "모두 동의하기",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
