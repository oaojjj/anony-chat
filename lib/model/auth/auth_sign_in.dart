class AuthSignIn {
  num code;
  String message;
  bool success;
  AuthSignInData data;

  AuthSignIn({this.code, this.message, this.success, this.data});

  AuthSignIn.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    success = json['success'];
    data = json['data'] != null ? AuthSignInData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class AuthSignInData {
  List<String> item;
  num itemLength;

  AuthSignInData({this.item, this.itemLength});

  AuthSignInData.fromJson(Map<String, dynamic> json) {
    item = json['item'].cast<String>();
    itemLength = json['item_length'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item'] = this.item;
    data['item_length'] = this.itemLength;
    return data;
  }
}