class ChatUserInfo {
  num code;
  String message;
  bool success;
  ChatUserInfoData data;

  ChatUserInfo({this.code, this.message, this.success, this.data});

  ChatUserInfo.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    success = json['success'];
    data =
    json['data'] != null ? ChatUserInfoData.fromJson(json['data']) : null;
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

class ChatUserInfoData {
  List<Map> item;
  num itemLength;
  num total;

  ChatUserInfoData({this.item, this.itemLength});

  ChatUserInfoData.fromJson(Map<String, dynamic> json) {
    item = json['item'].cast<Map>();
    itemLength = json['item_length'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item'] = this.item;
    data['item_length'] = this.itemLength;
    data['total'] = this.total;
    return data;
  }
}


