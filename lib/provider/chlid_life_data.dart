import 'package:flutter/material.dart';

class ChildLifeProvider with ChangeNotifier {
  Image _childImage = Image.asset("name");
  String _childImagePath = "";

  String get childImagePath => _childImagePath;
  String _childName = "";
  String _childBDay = '';
  String _className = '';
  String _collectionPeriod = '';
  String _attendanceCount = '';
  String _avgAttendTime = '';
  String _avgGoinghomeTime = '';
  String _height = '';
  String _weight = '';
  String _beforeAttendEmotion = '';
  String _beforeGoingHomeEmotion = '';
  String _avgMeal = '';
  String _avgSleep = '';
  String _vomitCount = '';
  String _toiletCount = '';
  String _medicineCount = '';
  String _accidentCount = '';
  String _bdayYear='';


  Image get childImage => _childImage;
  String _bdayMonth='';
  String _bdayDay='';

  String get childName => _childName;

  String get childBDay => _childBDay;

  String get className => _className;

  String get collectionPeriod => _collectionPeriod;

  String get attendanceCount => _attendanceCount;

  String get avgAttendTime => _avgAttendTime;

  String get avgGoinghomeTime => _avgGoinghomeTime;

  String get height => _height;

  String get weight => _weight;

  String get beforeAttendEmotion => _beforeAttendEmotion;

  String get beforeGoingHomeEmotion => _beforeGoingHomeEmotion;

  String get avgMeal => _avgMeal;

  String get avgSleep => _avgSleep;

  String get vomitCount => _vomitCount;

  String get toiletCount => _toiletCount;

  String get medicineCount => _medicineCount;

  String get accidentCount => _accidentCount;

  String get bdayYear => _bdayYear;

  String get bdayMonth => _bdayMonth;

  String get bdayDay => _bdayDay;

  void updateData(Image childImage, String childImagePath, String childName, String childBDay, String className, String collectionPeriod,
  String attendanceCount, String avgAttendTime, String avgGoinghomeTime, String height, String weight, String beforeAttendEmotion,
  String beforeGoingHomeEmotion, String avgMeal, String avgSleep, String vomitCount, String toiletCount, String medicineCount,
  String accidentCount, String bdayYear, String bdayMonth, String bdayDay) {
    _childImage = childImage;
    _childImagePath = childImagePath;
    _childName = childName;
    _childBDay = childBDay;
    _className = className;
    _collectionPeriod = collectionPeriod;
    _attendanceCount = attendanceCount;
    _avgAttendTime = avgAttendTime;
    _avgGoinghomeTime = avgGoinghomeTime;
    _height = height;
    _weight = weight;
    _beforeAttendEmotion = beforeAttendEmotion;
    _beforeGoingHomeEmotion = beforeGoingHomeEmotion;
    _avgMeal = avgMeal;
    _avgSleep = avgSleep;
    _vomitCount = vomitCount;
    _toiletCount = toiletCount;
    _medicineCount = medicineCount;
    _accidentCount = accidentCount;
    _bdayYear=bdayYear;
    _bdayMonth=bdayMonth;
    _bdayDay=bdayDay;
    print("ChildLife Data Upate");
    notifyListeners();
  }
}