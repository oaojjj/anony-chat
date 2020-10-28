class MessageCount {
  num code;
  String message;
  bool success;
  MessageCountData data;

  MessageCount({this.code, this.message, this.success, this.data});

  MessageCount.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    success = json['success'];
    data =
        json['data'] != null ? MessageCountData.fromJson(json['data']) : null;
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

class MessageCountData {
  List<Map> item;
  num itemLength;
  num total;

  MessageCountData({this.item, this.itemLength});

  MessageCountData.fromJson(Map<String, dynamic> json) {
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

class MessageAdd {
  num code;
  String message;
  bool success;
  MessageAddData data;

  MessageAdd({this.code, this.message, this.success, this.data});

  MessageAdd.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    success = json['success'];
    data = json['data'] != null ? MessageAddData.fromJson(json['data']) : null;
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

class MessageAddData {
  List<int> item;
  num itemLength;
  num total;

  MessageAddData({this.item, this.itemLength});

  MessageAddData.fromJson(Map<String, dynamic> json) {
    item = json['item'].cast<int>();
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
