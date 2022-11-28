import 'package:flutter/material.dart';

class ClassDataProvider with ChangeNotifier {
  int _childNum = 0;
  String _classDeco ='assets/class_info_deco/2class.png';
  String _classAge ='만2세반';
  int _column = 7;


  String get classAge => _classAge;

  String get classDeco => _classDeco;
  int _row=0;
  int _rest=0; //나머지 아이들
  String _className = '새싹어린이반';
  int _teacherNum = 1;
  List<String> _teacherName = ['김담임',
    // '김담임',
    // '김담임'
  ];
  List<Image> _teacherImage = [
    Image.asset("assets/childlifedata/baby_sample.png"),
    // Image.asset("assets/childlifedata/baby_sample.png"),
    // Image.asset("assets/childlifedata/baby_sample.png"),
  ];
  List<String> _childrenName = [];
  List<Image> _childrenImage = [];

  int get childNum => _childNum; //반 나이, 총 인원, 남아 수, 여아 수 순서
  List<int> _classInfo =[0,0,0,0];

  int get column => _column;

  int get row => _row;

  int get rest => _rest;

  String get className => _className;

  int get teacherNum => _teacherNum;

  List<String> get teacherName => _teacherName;


  List<Image> get teacherImage => _teacherImage;

  List<String> get childrenName => _childrenName;


  List<Image> get childrenImage => _childrenImage;

  List<int> get classInfo => _classInfo;

  void dataUpdate(int childNum,String classAge, String classDeco, int column, int row, int rest, String className,
      int teacherNum, List<String> teacherName, List<Image> teacherImage,List<String> childrenName, List<Image> childrenImage,
      List<int> classInfo,){
    _childNum = childNum;
    _classAge = classAge;
    _classDeco = classDeco;
    _column = column;
    _row = row;
    _rest = rest;
    _className = className;
    _teacherNum = teacherNum;
    _teacherName = teacherName;
    _teacherImage = teacherImage;
    _childrenName = childrenName;
    _childrenImage = childrenImage;
    _classInfo = classInfo;
    print("Class Data Upate1");
    notifyListeners();
  }
}