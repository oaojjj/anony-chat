class FileUpload {
  num code;
  String message;
  bool success;
  FileUploadData data;

  FileUpload({this.code, this.message, this.success, this.data});

  FileUpload.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    success = json['success'];
    data = json['data'] != null ? FileUploadData.fromJson(json['data']) : null;
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

class FileUploadData {
  bool success;
  String message;
  List<int> item;
  num itemLength;

  FileUploadData({this.item, this.itemLength});

  FileUploadData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    item = json['item'].cast<int>();
    itemLength = json['item_length'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['item'] = this.item;
    data['item_length'] = this.itemLength;
    return data;
  }
}
