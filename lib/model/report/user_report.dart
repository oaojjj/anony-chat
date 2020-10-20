class UserReport {
  num code;
  String message;
  bool success;
  UserReportData data;

  UserReport({this.code, this.message, this.success, this.data});

  UserReport.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    success = json['success'];
    data = json['data'] != null ? UserReportData.fromJson(json['data']) : null;
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

class UserReportData {
  List<int> item;
  num itemLength;
  num total;

  UserReportData({this.item, this.itemLength});

  UserReportData.fromJson(Map<String, dynamic> json) {
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
