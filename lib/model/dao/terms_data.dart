class TermsData {
  bool required;
  bool isChecked;
  String title;
  String content;

  TermsData.fromMap(Map<String, dynamic> map)
      : required = map['required'],
        isChecked = map['isChecked'],
        title = map['title'],
        content = map['content'];
}
