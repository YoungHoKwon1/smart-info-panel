import 'package:flutter/cupertino.dart';

class NoticedataProvider with ChangeNotifier {
  String _news = '이번달 행사';
  String _today = '오늘의 소식';
  int _eventNum = 0;
  int _months = 0;
  int _weeks = 0;
  int _ro=0;
  int _co = 4;
  int _re=0;
  int _newImageNum = 0;
  int _days = 0;
  List<String> _childrenImagePath = [];
  String _weekinfo = '';
  String _NewsComment = '';
  List<dynamic> _specialDays=[];
  List<dynamic> _specialNews = [];
  bool newsExist =true;
  List<Image> _imageList = [];
  String _names = '';
  List<String> _imagePaths = [
    "api/image/뒷산사진1.png",
    "api/image/뒷산사진2.png",
  ];


  int _now = 1;

  List<String> get imagePaths => _imagePaths;

  String get names => _names;


  String get news => _news;

  String get today => _today;

  int get eventNum => _eventNum;

  int get months => _months;

  int get weeks => _weeks;

  int get ro => _ro;

  int get co => _co;

  int get re => _re;

  int get newImageNum => _newImageNum;

  int get days => _days;

  List<String> get childrenImagePath => _childrenImagePath;

  String get weekinfo => _weekinfo;

  String get NewsComment => _NewsComment;

  List<dynamic> get specialDays => _specialDays;

  List<dynamic> get specialNews => _specialNews;

  List<Image> get imageList => _imageList;

  int get now => _now;

  void updataData(String news,String today,int eventNum,int months,int weeks,int ro,int co,int re,int newImageNum,
      int days,List<String> childrenImagePath,String weekinfo,String NewsComment, List<dynamic> specialDays,List<dynamic> specialNews,bool newsExist,List<Image> imageList,now,String names,List<String>  imagePaths ) {
    _news = news;
    _today = today;
    _eventNum = eventNum;
    _months = months;
    _weeks = weeks;
    _ro = ro;
    _co = co;
    _re = re;
    _newImageNum = newImageNum;
    _days = days;
    _childrenImagePath = childrenImagePath;
    _weekinfo = weekinfo;
    _NewsComment = NewsComment;
    _specialDays = specialDays;
    _specialNews = specialNews;
    this.newsExist = newsExist;
    _imageList = imageList;
    _now = now;
    _names = names;
    _imagePaths = imagePaths;
    print("Class Data Upate1");

    notifyListeners();
  }
}