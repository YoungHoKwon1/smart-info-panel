import 'package:flutter/cupertino.dart';

class NoticeProvider with ChangeNotifier {
  String _news = '이번달 행사';
  String _today = '오늘의 소식';
  int _eventNum = 0;
  int _months = 0;
  int _weeks = 0;
  int _rowNotice=0;
  int _columnNotice = 4;
  int _restNotice=0;
  int _newImageNum = 0;
  List<String> _childrenImagePath = [];

  String get news => _news;
  String _weekinfo = '';
  String _NewsComment = '';
  List<String> _event2 = [];

  List<Image> _imageList = [];

  String get today => _today;

  int get eventNum => _eventNum;

  int get months => _months;

  int get weeks => _weeks;

  int get rowNotice => _rowNotice;

  int get columnNotice => _columnNotice;

  int get restNotice => _restNotice;

  int get newImageNum => _newImageNum;

  List<String> get childrenImagePath => _childrenImagePath;

  String get weekinfo => _weekinfo;

  String get NewsComment => _NewsComment;

  List<String> get event2 => _event2;

  List<Image> get imageList => _imageList;

  void updateData(String news, String today, int eventNum, int months, int rowNotice, int restNotice,
      int newImageNum, List<String> childrenImagePath, String weekinfo, String NewsComment, List<String> event2, List<Image> imageList ) {
    _news = news;
    _today = today;
    _eventNum = eventNum;
    _months = months;
    _rowNotice = rowNotice;
    _restNotice = restNotice;
    _newImageNum = newImageNum;
    _childrenImagePath = childrenImagePath;
    _weekinfo = weekinfo;
    _NewsComment = NewsComment;
    _event2 = event2;
    _imageList = imageList;
    print("Notice Data Upate");
    notifyListeners();
  }
}