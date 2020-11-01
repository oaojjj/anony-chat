class ReportTypeDao {
  String reportType;
  String createBy;
  int id;

  ReportTypeDao({this.reportType, this.createBy, this.id});

  factory ReportTypeDao.fromJson(Map<String, dynamic> json) => ReportTypeDao(
        reportType: json['report_type'] as String,
        createBy: json['create_by'] as String,
        id: json['user_id'] as int,
      );

  Map<String, dynamic> toJson(ReportTypeDao instance) => {
        'reportType': instance.reportType,
        'createBy': instance.createBy,
        'id': instance.id,
      };
}
