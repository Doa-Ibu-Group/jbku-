import 'package:flutter/material.dart';
import 'package:jbku_project/screens/TrackReport/track.dart';
import 'package:jbku_project/screens/create_reports/report_page.dart';
import 'package:jbku_project/screens/home/report_list.dart';
import 'package:jbku_project/screens/home/user_setting.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  int selectedIndex = 0;

  List<Widget> widgetOptions = <Widget>[
    ReportList(),
    ReportPage(),
    TrackScreen(),
    UserSettingPage(),
  ];
}
