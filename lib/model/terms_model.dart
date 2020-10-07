import 'package:anony_chat/model/dao/terms_data.dart';

class TermsModel {
  List<TermsData> _mItems;
  bool _allAgree;

  TermsModel({List<TermsData> items}) {
    _mItems = items;
    _allAgree = false;
  }

  List<TermsData> get mItems => _mItems;

  set mItems(List<TermsData> value) {
    _mItems = value;
  }

  bool get allAgree => _allAgree;

  set allAgree(bool value) {
    _allAgree = value;
  }

  onChecked(int index, bool b) {
    _mItems[index].isChecked = b;
    if (!b) _allAgree = b;
    if (isAlChecked()) _allAgree = true;
  }

  onAllOfAgreeCheckBox(bool b) {
    _allAgree = b;
    _mItems.forEach((element) {
      element.isChecked = b;
    });
  }

  bool isAllOfRequiredChecked() {
    if (_allAgree) return true;

    for (final item in _mItems) {
      if (item.required && !item.isChecked) {
        return false;
      }
    }
    return true;
  }

  bool isAlChecked() {
    if (_allAgree) return true;

    for (final item in _mItems) if (!item.isChecked) return false;
    return true;
  }

  String returnRequiredString(int index) {
    return _mItems[index].required
        ? '(필수) ' + _mItems[index].title
        : '(선택) ' + _mItems[index].title;
  }
}
