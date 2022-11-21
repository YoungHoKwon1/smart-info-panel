import 'package:flutter/material.dart';

class AttendanceDataProvider with ChangeNotifier {
  double _boyrate =0.0;
  double _girlrate =0.0;
  List<dynamic> _childClassName = []; //반 이름입니다.
  List<double> _chartRate = [];

  double get boyrate => _boyrate;

  double get girlrate => _girlrate;

  List<dynamic> get childClassName => _childClassName;

  List<double> get chartRate => _chartRate;

  void updateData(double boyrate, double girlrate,
      List<dynamic> childClassName, List<double> chartRate) {
    _boyrate = boyrate;
    _girlrate = girlrate;
    _childClassName = childClassName;
    _chartRate = chartRate;
    print("Attendance Data Upate");
    notifyListeners();
  }


}