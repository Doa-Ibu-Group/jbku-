//@dart=2.9
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ReportPageViewModel extends BaseViewModel {
  ReportCategory selectedReportCategory;
  List<ReportCategory> reports = [
    ReportCategory("Potholes"),
    ReportCategory("Illegal Parking"),
    ReportCategory("Suspicious Activity"),
  ];

  List<DropdownMenuItem> generateItem(List<ReportCategory> reports) {
    List<DropdownMenuItem> items = [];
    for (var item in reports) {
      items.add(DropdownMenuItem(
        child: Text(item.name),
        value: item,
      ));
      notifyListeners();
    }
    return items;
  }

  ReportCategory get selected => selectedReportCategory;

  void getSelectedCategory() async {
    setBusy(true);

    setBusy(false);
    notifyListeners();
  }
}

class ReportCategory {
  String name;
  ReportCategory(this.name);
}
