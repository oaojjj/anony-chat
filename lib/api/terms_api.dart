import 'package:anony_chat/model/terms_data.dart';

class TermsDataAPI {
  List<TermsData> _mItems;
  bool _allAgree;

  TermsDataAPI({List<TermsData> items}) {
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
  }

  onAllAgreeCheckBox(bool b) {
    _allAgree = b;
    _mItems.forEach((element) {
      element.isChecked = b;
    });
  }

  bool isRequiredChecked() {
    if (_allAgree) return true;
    for (final item in _mItems) {
      if (item.required && !item.isChecked) {
        return false;
      }
    }
    return true;
  }

  String returnRequiredString(int index) {
    return _mItems[index].required
        ? '(필수) ' + _mItems[index].title
        : '(선택) ' + _mItems[index].title;
  }
}
