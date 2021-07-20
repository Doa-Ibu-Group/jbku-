class Report {
  final String userId;
  final String reportID;
  final String name;
  final String titleOfReport;
  final String reportDescription;
  final String reportCategory;
  final DateTime dateTime;
  final String respond;
  final String imageUrl;

  Report(
      {required this.imageUrl,
      required this.userId,
      required this.reportID,
      required this.name,
      required this.titleOfReport,
      required this.reportDescription,
      required this.reportCategory,
      required this.dateTime,
      required this.respond});
}
