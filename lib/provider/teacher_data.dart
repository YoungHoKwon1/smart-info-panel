import 'package:flutter/material.dart';

class TeacherDataProvider with ChangeNotifier {
  int _column = 7;
  int _row=0;
  int _rest=0;

  int _teacherNum = 0;
  int _directorNum = 0;
  int _committeeNum = 0;
  List<String> _teacherName = [];
  List<Image> _teacherImage = [];
  List<String> _teacherIntroduction = [];

  List<String> _directorName = [];
  List<Image> _directorImage = [];
  List<String> _directorIntroduction = [];

  List<String> _committeeName = [];
  List<Image> _committeeImage = [];
  List<String> _committeeClassName = [];

  int get column => _column;

  int get row => _row;

  int get rest => _rest;

  int get teacherNum => _teacherNum;
  int get directorNum => _directorNum;
  int get committeeNum => _committeeNum;


  List<String> get teacherName => _teacherName;
  List<Image> get teacherImage => _teacherImage;
  List<String> get teacherIntroduction => _teacherIntroduction;

  List<String> get directorName => _directorName;
  List<Image> get directorImage => _directorImage;
  List<String> get directorIntroduction => _directorIntroduction;

  List<String> get committeeName => _committeeName;
  List<Image> get committeeImage => _committeeImage;
  List<String> get committeeClassName => _committeeClassName;


  void dataUpdate(int column, int row, int rest,
      int teacherNum, List<String> teacherName, List<Image> teacherImage, List<String> teacherIntroduction, int directorNum, List<String> directorName,  List<Image> directorImage, List<String> directorIntroduction, int committeeNum, List<String> committeeName, List<Image> committeeImage, List<String> committeeClassName,
      ) {

    _column = column;
    _row = row;
    _rest = rest;
    _teacherNum = teacherNum;
    _teacherName = teacherName;
    _teacherImage = teacherImage;
    _teacherIntroduction = teacherIntroduction;

    _directorNum = directorNum;
    _directorName = directorName;
    _directorImage = directorImage;
    _directorIntroduction = directorIntroduction;

    _committeeNum = committeeNum;
    _committeeName = committeeName;
    _committeeImage = committeeImage;
    _committeeClassName = committeeClassName;
    print("Class Data Upate1");
    notifyListeners();
  }
}