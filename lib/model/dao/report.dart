class Report {
  int id;
  String reportType;
  bool isProcessed = false;

  Report({this.id, this.reportType, this.isProcessed});

  factory Report.fromJson(Map<String, dynamic> json) => Report(
      id: json['id'] as int,
      isProcessed: json['processed'] as bool,
      reportType: json['reportType'] as String);
}
