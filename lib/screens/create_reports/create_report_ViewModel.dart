//@dart=2.9
import 'package:stacked/stacked.dart';

class CreatePotholesViewModel extends BaseViewModel {
  String currentName;
  String currentTitleOfReport;
  String currentReportCategory = 'potholes';
  String currentReportDescription;

  void setName(String n) {
    currentName = n;
    notifyListeners();
  }
}
