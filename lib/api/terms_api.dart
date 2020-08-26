import 'package:anony_chat/model/terms_data.dart';

class TermsDataAPI {
  List<TermsData> _mItems;
  bool allAgree;

  TermsDataAPI({List<TermsData> items}) {
    _mItems = items;
    allAgree = false;
  }

  List<TermsData> get mItems => _mItems;

  set mItems(List<TermsData> value) {
    _mItems = value;
  }

  onCheck(int index, bool b) {
    _mItems[index].isChecked = b;
  }

  onAllAgreeCheckBox(bool b) {
    allAgree = b;
    _mItems.forEach((element) {
      element.isChecked = b;
    });
  }

  bool isRequiredChecked() {
    if (allAgree) return true;
    for (final item in _mItems) {
      if (item.required && !item.isChecked) {
        return false;
      }
    }
    return true;
  }
}
