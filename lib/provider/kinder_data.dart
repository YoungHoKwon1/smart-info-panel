import 'package:flutter/material.dart';

class KinderDataProvider with ChangeNotifier {
  List<double> _classGraphRate = [20, 20, 20, 20, 20];
  List<dynamic> _classGraphName = [
    '만 3세반',
    '만 4세반',
    '만 5세반',
    '혼합 3-4세반',
    '혼합 4-5세반'
  ];
  int _classNumTotal=0;
  List<int> _classNumEach = [1, 3, 3, 1, 1];
  List<dynamic> _childNumEachAge = [12, 6, 11, 12, 1];
  int _childrenCountByTeacher=5;
  int _childrenCountByClass=5;
  List<dynamic> _firstRowInt = [4, 199, 0, 0, 0, 0, 1, 170, 0, 0];
  List<dynamic> _secondRowInt = [0, 0, 0, 0, 1, 37, 1, 37];
  List<dynamic> _thirdRowInt = [0, 0, 0, 0, 1, 37, 1, 37];
  Image _kinderImage = Image.asset("name");

  set kinderImage(Image value) {
    _kinderImage = value;
  }

  List<double> get classGraphRate => _classGraphRate;

  List<dynamic> get classGraphName => _classGraphName;

  int get classNumTotal => _classNumTotal;

  List<int> get classNumEach => _classNumEach;

  List<dynamic> get childNumEachAge => _childNumEachAge;

  int get childrenCountByTeacher => _childrenCountByTeacher;

  Image get kinderImage => _kinderImage;

  List<dynamic> get thirdRowInt => _thirdRowInt;

  List<dynamic> get secondRowInt => _secondRowInt;

  List<dynamic> get firstRowInt => _firstRowInt;

  int get childrenCountByClass => _childrenCountByClass;

  void dataUpdate(Image kinderImage, List<int> classNumEach, List<dynamic> classGraphName, List<dynamic> childNumEachAge,
      int classNumTotal, List<double> classGraphRate, var childrenCountByTeacher, var childrenCountByClass, List<dynamic> firstRowInt,
      List<dynamic> secondRowInt, List<dynamic> thirdRowInt,) {
    _kinderImage = kinderImage;
    _classNumEach = classNumEach;
    _classGraphName = classGraphName;
    _childNumEachAge = childNumEachAge;
    _classNumTotal = classNumTotal;
    _classGraphRate = classGraphRate;
    _childrenCountByClass = childrenCountByClass;
    _childrenCountByTeacher = childrenCountByTeacher;
    _firstRowInt = firstRowInt;
    _secondRowInt = secondRowInt;
    _thirdRowInt = thirdRowInt;
    print("update Kinder Data");
    notifyListeners();
  }
}