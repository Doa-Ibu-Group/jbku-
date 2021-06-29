//@dart=2.9
import 'package:stacked/stacked.dart';
import 'package:uuid/uuid.dart';

class CreatePotholesViewModel extends BaseViewModel {
  var uuid = Uuid();

  String reportId;
  String currentName;
  String currentTitleOfReport;
  String currentReportCategory = 'potholes';
  String currentReportDescription;

  String get reportUniqueId => this.reportId = uuid.v1();
  void setName(String n) {
    currentName = n;
    notifyListeners();
  }
}
