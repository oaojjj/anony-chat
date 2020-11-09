class CardAdd {
  num code;
  String message;
  bool success;
  CardAddData data;

  CardAdd({this.code, this.message, this.success, this.data});

  CardAdd.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    success = json['success'];
    data = json['data'] != null ? CardAddData.fromJson(json['data']) : null;
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

class CardAddData {
  List<Map> item;
  num itemLength;
  num total;

  CardAddData({this.item, this.itemLength});

  CardAddData.fromJson(Map<String, dynamic> json) {
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
