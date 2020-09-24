// 예시로 일단
enum ReportType {
  // 욕설
  FourLetterWord,
  // 음담패설
  Obscenity,
  // 스팸
  Spam,
  // 공갈/협박
  Blackmail,
  // 불법
  IllegalThing
}

class Report {
  int id;
  int opponentID;
  String reportType;
  bool isProcessed = false;

  Report({this.id, this.opponentID, this.reportType, this.isProcessed});

  factory Report.fromJson(Map<String, dynamic> json) => Report(
      id: json['id'] as int,
      opponentID: json['opponentID'] as int,
      isProcessed: json['processed'] as bool,
      reportType: json['reportType'] as String);

  static changeTypeToKoreanWord(ReportType type) {
    switch (type) {
      case ReportType.FourLetterWord:
        return '욕설';
      case ReportType.Obscenity:
        return '음담패설';
      case ReportType.Spam:
        return '스팸';
      case ReportType.Blackmail:
        return '공갈/협박';
      case ReportType.IllegalThing:
        return '불법';
    }
  }

  static getList() => [
        ReportType.FourLetterWord,
        ReportType.Obscenity,
        ReportType.Spam,
        ReportType.Blackmail,
        ReportType.IllegalThing
      ];
}
