class IssueBillings {
  num code;
  String message;
  bool success;
  IssueBillingsData data;

  IssueBillings({this.code, this.message, this.success, this.data});

  IssueBillings.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    success = json['success'];
    data = json['data'] != null ? IssueBillingsData.fromJson(json['data']) : null;
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

class IssueBillingsData {
  List<bool> item;
  num itemLength;
  num total;

  IssueBillingsData({this.item, this.itemLength});

  IssueBillingsData.fromJson(Map<String, dynamic> json) {
    item = json['item'].cast<bool>();
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
