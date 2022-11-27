import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_info_panel/childlifedata.dart';
import 'package:smart_info_panel/classinfo20.dart';
import 'package:smart_info_panel/facetime.dart';
import 'package:smart_info_panel/notice.dart';

import 'package:smart_info_panel/classinfo30.dart';
import 'package:smart_info_panel/provider/attendance_data.dart';
import 'package:smart_info_panel/provider/chlid_life_data.dart';
import 'package:smart_info_panel/provider/class_data.dart';
import 'package:smart_info_panel/provider/kinder_data.dart';

import 'package:smart_info_panel/provider/notice_data.dart';

import 'package:smart_info_panel/provider/teacher_data.dart';
import 'package:smart_info_panel/provider/test_notice_provider.dart';

import 'package:smart_info_panel/smartinfopanel.dart';
import 'package:smart_info_panel/teacher_info.dart';

import 'package:smart_info_panel/kinder_info_2.dart';
import 'package:smart_info_panel/kinder_info_3.dart';

import 'classinfo10.dart';
import 'classinfo30.dart';
import 'fl_graph_test.dart';
import 'notice.dart';

import 'package:timer_builder/timer_builder.dart';
import 'package:intl/intl.dart';
import 'package:smart_info_panel/api/infopanel.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'dart:async';
//maindart change test

final supportedLocales = [Locale('en', 'US'), Locale('ko', 'KR')];

void main() async {
  await ScreenUtil.ensureScreenSize(); //화면 비율 맞추기 위함

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => KinderDataProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => ClassDataProvider(),
      ), ChangeNotifierProvider(
        create: (_) => AttendanceDataProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => ChildLifeProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => TeacherDataProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => NoticeProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => NoticedataProvider(),
      ),
    ], child: SmartInfoPanel()),
  );
}

//기본적인 앱들어갈때 세팅할것들
class SmartInfoPanel extends StatelessWidget {
  const SmartInfoPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ScreenUtilInit(
      designSize: const Size(1920, 1080),
      builder: (ctx, child) {
        return MaterialApp(
          theme: ThemeData(
            fontFamily: 'NotoSansKR',
          ),
          home: const SmartInfoPanelMain(),
        );
      });
}

class SmartInfoPanelMain extends StatefulWidget {
  const SmartInfoPanelMain({Key? key}) : super(key: key);

  @override
  State<SmartInfoPanelMain> createState() => _SmartInfoPanelMainState();
}

class _SmartInfoPanelMainState extends State<SmartInfoPanelMain> {
  ///routing 순서, 20초마다 넘김
  ///어린이집소개페이지(KinderInfo2,3)
  ///선생님소개(TeacherInfo)
  ///학급소개 페이지(ClassInfo10,20,30) // 유아 수에 따라 routing
  ///학급공지 페이지(Notice)
  ///영유아 인식 페이지(facetime)
  ///아이생활 데이터(ChildLifeData)
  @override
  void initState() {
    super.initState();
    _callBasicApi();
    _callAttendApi();
    _callChildApi();
  }

  Dio dio = Dio();
  String url = "http://tmap.aijoa.us:48764/";
  final token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZGVudGlmaWNhdGlvbiI6MjIsInZlcnNpb24iOiIwLjAuNCIsImlhdCI6MTY2NzM2MTY3NCwiZXhwIjoxNjY5OTUzNjc0LCJpc3MiOiJhaWpvYSJ9.GKbcaliPyXkYy5szr_4nJOOpfN-vvigMBt3ufShmgtY';

  List<double> classGraphRate = [20, 20, 20, 20, 20];
  List<dynamic> classGraphName = [
    '만 3세반',
    '만 4세반',
    '만 5세반',
    '혼합 3-4세반',
    '혼합 4-5세반'
  ];
  int classNumTotal = 0;
  List<int> classNumEach = [1, 3, 3, 1, 1];
  List<dynamic> childNumEachAge = [12, 6, 11, 12, 1];

  var childrenCountByTeacher;
  var childrenCountByClass;
  List<dynamic> firstRowInt = [4, 199, 0, 0, 0, 0, 1, 170, 0, 0];
  List<dynamic> secondRowInt = [0, 0, 0, 0, 1, 37, 1, 37];
  List<dynamic> thirdRowInt = [0, 0, 0, 0, 1, 37, 1, 37];
  Image kinderImage = Image.asset("name");

  int childNum = 0;
  int column = 0;
  int row=0;
  int rest=0; //나머지 아이들
  String className = '새싹어린이반';
  int teacherNum = 0;
  int directorNum = 0;
  int committeeNum = 0;
  List<String> teacherName = ['김담임', '김담임', '김담임'];
  List<Image> teacherImage = [];
  List<String> childrenName = [];
  List<Image> childrenImage = [];
  List<String> directorImagePath = [];
  List<Image> directorImage = [];
  List<String> directorName = [];
  List<String> directorIntroduction = [];
  List<String> teacherIntroduction = [];

  List<Image> committeeImage = [];
  List<String> committeeName = [];
  List<String> committeeClassName = [];
  //반 나이, 총 인원, 남아 수, 여아 수 순서
  List<int> classInfo =[0,0,0,0];
  String news = '이번달 행사';
  String today = '오늘의 소식';
  int eventNum = 0;
  int months = 0;
  int weeks = 0;
  int ro=0;
  int co = 4;
  int re=0;
  int newImageNum = 0;
  List<String> childrenImagePath = [];
  String weekinfo = '';
  String NewsComment = '';
  List<String> event2 = [];
  List<Image> imageList = [];
  int days = 0;
  String snews= '';
  String names='';
  List<String> imagePaths = [
    "api/image/뒷산사진1.png",
    "api/image/뒷산사진2.png",
  ];
  var now = DateTime.now();


  ///어린이집소개 좌측용
  void _callBasicApi() async {
    Map<String, String> headers = Map();
    headers['authorization'] = token;
    final client = RestInfoPanel(dio);
    final responseBasic =
        await client.getHouseInfo(token).catchError((Object obj) {
      final res = (obj as DioError).response;
      switch (res!.statusCode) {
        case 200:
          debugPrint('200');
          break;
        case 401:
          debugPrint('401 : 유효하지 않은 토큰입니다.');
          break;
        case 419:
          debugPrint('419 : 토큰이 만료되었습니다.');
          break;
        case 500:
          debugPrint('500 : 심각한 서버 문제.');
          break;
        default:
          break;
      }
      return obj.response;
    });
    // print(responseBasic);
    Map<String, dynamic> mapResult = Map<String, dynamic>.from(
        responseBasic); //안해주면 Iteral뭐시기 형태로 데이터가 들어와 Map형식으로 읽을 수 없음

    setState(() {
      weeks = mapResult["news"]["week"];
      months= mapResult["news"]["month"];
      weekinfo = mapResult["news"]["weekNews"];
      NewsComment = mapResult["news"]["weekNewsComment"];
      names = mapResult["kindergarten"]["name"];
      newImageNum = mapResult["news"]["imagePaths"].length;
      for(int q=0;q<newImageNum;q++) {
        imageList.add(
          Image.network(
            url + mapResult["news"]["imagePaths"][q],
            headers: headers,
            width: 200.w,
            height: 200.w,
            fit: BoxFit.cover,
          ),
        );
      };
      ro = newImageNum ~/ co;
      re = newImageNum % co;
      //print(co);

      }

      teacherNum = mapResult["teachers"].length;
      directorNum = mapResult["directors"].length;
      committeeNum = mapResult["committees"].length;
      // print(teacherNum);
      print(mapResult["teachers"]);
      print("before For");
      for(int i=0;i<teacherNum;i++) {
        teacherName.add(mapResult["teachers"][i]["name"]);
        teacherIntroduction.add(mapResult["teachers"][i]["introduction"]);
        teacherImage.add(
          Image.network(
            url + mapResult["teachers"][i]["imagePath"],
            headers: headers,
            width: 128.w,
            height: 146.w,

            fit: BoxFit.cover,
          ),
        );
      }

      print("-----");
      print(teacherName);
      print(teacherIntroduction);
      print("-----");
      classInfo[1] = directorNum;
      directorName.clear();
      directorIntroduction.clear();
      for (int i = 0; i < directorNum; i++) {
        directorName.add(mapResult["directors"][i]["name"]);
        directorIntroduction.add(mapResult["directors"][i]["introduction"]);
        // childrenImagePath.add(mapResult["classInfo"][0]["children"][i]["imagePath"]);
        directorImage.add(
          Image.network(
            url + mapResult["directors"][i]["imagePath"],
            headers: headers,
            width: 128.w,
            height: 146.w,
            fit: BoxFit.cover,
          ),
        );
      }
      classInfo[1] = committeeNum;
      committeeName.clear();
      committeeClassName.clear();
      for (int i = 0; i < committeeNum; i++) {
        committeeName.add(mapResult["committees"][i]["name"]);
        committeeClassName.add(mapResult["committees"][i]["className"]);
        //       for (int i = 0; i < committeesNum; i++) {
        //         committeesName.add(mapResult["classInfo"][0]["committees"][i]["name"]);
        //         // childrenImagePath.add(mapResult["classInfo"][0]["children"][i]["imagePath"]);
        committeeImage.add(
          Image.network(
            url + mapResult["committees"][i]["imagePath"],
            headers: headers,
            width: 128.w,
            height: 146.w,
            fit: BoxFit.cover,
          ),
        );
        context.read<TeacherDataProvider>().dataUpdate(column, row, rest, teacherNum, teacherName, teacherImage, teacherIntroduction, directorNum, directorName, directorImage, directorIntroduction, committeeNum, committeeName, committeeImage, committeeClassName);
      }

      kinderImage = Image.network(
        url + mapResult["kindergarten"]["imagePath"],
        headers: headers,
        width: 128.w,
        height: 146.w,
        fit: BoxFit.cover,
      );
      classNumEach =
          mapResult["kindergarten"]["classCounts"].cast<int>(); //원형그래프:각 나이별 학급 수
      classGraphName = mapResult["kindergarten"]["classAges"]; //원형그래프:학급수
      childNumEachAge = mapResult["kindergarten"]["childrenCounts"]; //원형그래프: 유아수
      //원형그래프 비율 구하기
      for (int i = 0; i < classGraphName.length; i++) {
        //총 학급수 계산
        classNumTotal += classNumEach[i];
      }
      for (int i = 0; i < classGraphName.length; i++) {
        //그래프 비율 계산
        classGraphRate[i] = classNumEach[i] / classNumTotal;
      }
      childrenCountByTeacher =
      mapResult["kindergarten"]["childrenCountByTeacher"]; //교사당 유아수
      childrenCountByClass =
      mapResult["kindergarten"]["childrenCountByClass"]; //학급당 유아수
      firstRowInt[0] = mapResult["kindergarten"]["classroomCount"];
      firstRowInt[1] = mapResult["kindergarten"]["classroomArea"];
      firstRowInt[2] = mapResult["kindergarten"]["indoorgymCount"];
      firstRowInt[3] = mapResult["kindergarten"]["indoorgymArea"];
      firstRowInt[4] = mapResult["kindergarten"]["outdoorgymCount"];
      firstRowInt[5] = mapResult["kindergarten"]["outdoorgymArea"];
      firstRowInt[6] = mapResult["kindergarten"]["roofgymCount"];
      firstRowInt[7] = mapResult["kindergarten"]["roofgymArea"];
      firstRowInt[8] = mapResult["kindergarten"]["neargymCount"];
      firstRowInt[9] = mapResult["kindergarten"]["neargymArea"];

      secondRowInt[0] = mapResult["kindergarten"]["healthroomCount"];
      secondRowInt[1] = mapResult["kindergarten"]["healthroomArea"];
      secondRowInt[2] = mapResult["kindergarten"]["restroomCount"];
      secondRowInt[3] = mapResult["kindergarten"]["restroomArea"];
      secondRowInt[4] = mapResult["kindergarten"]["kitchenCount"];
      secondRowInt[5] = mapResult["kindergarten"]["kitchenArea"];
      secondRowInt[6] = mapResult["kindergarten"]["cafeteriaCount"];
      secondRowInt[7] = mapResult["kindergarten"]["cafeteriaArea"];

      thirdRowInt[0] = mapResult["kindergarten"]["directorroomCount"];
      thirdRowInt[1] = mapResult["kindergarten"]["directorroomArea"];
      thirdRowInt[2] = mapResult["kindergarten"]["teacherroomCount"];
      thirdRowInt[3] = mapResult["kindergarten"]["teacherroomArea"];
      thirdRowInt[4] = mapResult["kindergarten"]["counselingroomCount"];
      thirdRowInt[5] = mapResult["kindergarten"]["counselingroomArea"];
      thirdRowInt[6] = mapResult["kindergarten"]["otherplaceCount"];
      thirdRowInt[7] = mapResult["kindergarten"]["otherplaceArea"];
      context.read<KinderDataProvider>().dataUpdate(
          kinderImage,
          classNumEach,
          classGraphName,
          childNumEachAge,
          classNumTotal,
          classGraphRate,
          childrenCountByTeacher,
          childrenCountByClass,
          firstRowInt,
          secondRowInt,
          thirdRowInt
      );
      className = mapResult["classInfo"][0]["name"];
      className = mapResult["classInfo"][0]["name"];
      teacherNum = mapResult["classInfo"][0]["teachers"].length;
      for(int i=0;i<teacherNum;i++) {
        teacherName[i] = mapResult["classInfo"][0]["teachers"][i]["name"];
        teacherImage.add(Image.network(
          url+mapResult["classInfo"][0]["teachers"][i]["imagePath"],
          headers: headers,
          width: 128.w,
          height: 146.w,
          fit: BoxFit.cover,
        ),
        );

      }
      childNum = mapResult["classInfo"][0]["children"].length;

      if(childNum<10) {
        column=4;
      } else if(childNum<20) {
        column=5;
      } else {
        column=7;
      }
      classInfo[1] = childNum;
      childrenName.clear();
      print(mapResult["classInfo"]);
      for(int i=0;i<childNum;i++) {
        childrenName.add(mapResult["classInfo"][0]["children"][i]["name"]);
        // childrenImagePath.add(mapResult["classInfo"][0]["children"][i]["imagePath"]);
        childrenImage.add(Image.network(
          url+mapResult["classInfo"][0]["children"][i]["imagePath"],
          headers: headers,
          width: 128.w,
          height: 146.w,
          fit: BoxFit.cover,
        ),);
      }


      row = childNum ~/ column;
      rest = childNum % column;
      print("row: " +row.toString());
      print("childNum: " +childNum.toString());
      print("column: " +column.toString());
      for(int i=0;i<childNum;i++) {
        if(mapResult["classInfo"][0]["children"][i]["sex"] == true) {
          classInfo[2]++;//남+1
        } else {
          classInfo[3]++;//여+1
        }
      }

      context.read<ClassDataProvider>().dataUpdate(childNum, column, row, rest, className, teacherNum,
          teacherName, teacherImage, childrenName, childrenImage, classInfo);
      context.read<NoticedataProvider>().updataData(news, today, eventNum, months, weeks, ro, co, re, newImageNum, days, childrenImagePath, weekinfo, NewsComment, snews, event2, imageList, now, names, imagePaths);
    });

  }
  Image childImage = Image.asset("name");
  String childName = "";
  String childBDay = '';
  String oneClassName = '';
  String collectionPeriod = '';
  String attendanceCount = '';
  String avgAttendTime = '';
  String avgGoinghomeTime = '';
  String height = '';
  String weight = '';
  String beforeAttendEmotion = '';
  String beforeGoingHomeEmotion = '';
  String avgMeal = '';
  String avgSleep = '';
  String vomitCount = '';
  String toiletCount = '';
  String medicineCount = '';
  String accidentCount = '';

  String bdayYear='';
  String bdayMonth='';
  String bdayDay='';

  ///영유아 정보 요청 api
  void _callChildApi() async {
    Map<String, String> headers = Map();
    headers['authorization'] = token;
    final client = RestInfoPanel(dio);
    final responseChild = await client.postChildInfo(token).catchError((Object obj) {
      final res = (obj as DioError).response;
      //swagger 참조
      switch (res!.statusCode) {
        case 200:
          debugPrint('200');
          break;
        case 401:
          debugPrint('401 : 유효하지 않은 토큰입니다.');
          break;
        case 419:
          debugPrint('419 : 토큰이 만료되었습니다.');
          break;
        case 500:
          debugPrint('500 : 심각한 서버 문제.');
          break;
        default:
          break;
      }
      return obj.response;
    });
    // print(responseChild);//데이터 뭐가오나 확인
    Map<String, dynamic> mapResult = Map<String, dynamic>.from(responseChild);//안해주면 Iteral뭐시기 형태로 데이터가 들어와 Map형식으로 읽을 수 없음
    setState(() {
      childImage = Image.network(
        url+mapResult["imagePath"],
        headers: headers,
        width: 128.w,
        height: 146.w,
        fit: BoxFit.cover,
      );
      childName = mapResult["name"];
      childBDay = mapResult["birthday"];
      bdayYear = childBDay.substring(0,4);
      bdayMonth = childBDay.substring(4,6);
      bdayDay = childBDay.substring(6,8);
      oneClassName = mapResult["className"];
      collectionPeriod = mapResult["collectionPeriod"].toString();
      attendanceCount = mapResult["attendanceCount"].toString();
      avgAttendTime = mapResult["avgAttendTime"].toString();
      avgGoinghomeTime = mapResult["avgGoinghomeTime"].toString();
      height = mapResult["height"].toString();
      weight = mapResult["weight"].toString();
      beforeAttendEmotion = mapResult["beforeAttendEmotion"].toString();
      beforeGoingHomeEmotion = mapResult["beforeGoingHomeEmotion"].toString();
      avgMeal = mapResult["avgMeal"].toString();
      avgSleep = mapResult["avgSleep"].toString();
      vomitCount = mapResult["vomitCount"].toString();
      toiletCount = mapResult["toiletCount"].toString();
      medicineCount = mapResult["medicineCount"].toString();
      accidentCount = mapResult["accidentCount"].toString();
      context.read<ChildLifeProvider>().updateData(childImage, childName, childBDay, oneClassName, collectionPeriod, attendanceCount, avgAttendTime, avgGoinghomeTime, height, weight, beforeAttendEmotion, beforeGoingHomeEmotion, avgMeal, avgSleep, vomitCount, toiletCount, medicineCount, accidentCount, bdayYear, bdayMonth, bdayDay);
      row = newImageNum ~/ column;
      rest = newImageNum % column;
    });
  }///

  double boyrate = 0.5;
  double girlrate = 0.78;

  List<dynamic> childClassName = [
    '꽃사랑',
    '개나리',
    '진달래',
    '방울꽃',
    '계란꽃',
    '아카시아',
    '튤립',
    '해바라기',
    //'금잔디',
    //'소나무',
  ]; //반 이름입니다.
  List<double> chartRate = [0.67, 0.89, 0.30, 1.00, 0.92, 0.94, 0.89, 0.90];
  ///등하원 api
  void _callAttendApi() async {
    final client = RestInfoPanel(dio);
    final token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZGVudGlmaWNhdGlvbiI6MjIsInZlcnNpb24iOiIwLjAuNCIsImlhdCI6MTY2NzM2MTY3NCwiZXhwIjoxNjY5OTUzNjc0LCJpc3MiOiJhaWpvYSJ9.GKbcaliPyXkYy5szr_4nJOOpfN-vvigMBt3ufShmgtY';
    final responseAttend =
        await client.getAttendInfo(token).catchError((Object obj) {
      final res = (obj as DioError).response;
      //swagger 참조
      switch (res!.statusCode) {
        case 200:
          debugPrint('200');
          break;
        case 401:
          debugPrint('401 : 유효하지 않은 토큰입니다.');
          break;
        case 419:
          debugPrint('419 : 토큰이 만료되었습니다.');
          break;
        case 500:
          debugPrint('500 : 심각한 서버 문제.');
          break;
        default:
          break;
      }
      return obj.response;
    });
    Map<String, dynamic> mapResult = Map<String, dynamic>.from(responseAttend); //안해주면 Iteral뭐시기 형태로 데이터가 들어와 Map형식으로 읽을 수 없음
    // print(mapResult);
    setState(() {
      //값이 0이 들어와서 현재 제대로 그릴수없어서 임의로 대체
      //boyrate = mapResult["maleRate"];
      //girlrate = mapResult["femaleRate"];
      // childClassName = mapResult["classList"];
      // chartRate = mapResult["rateByClass"].cast<double>();
      context.read<AttendanceDataProvider>().updateData(boyrate, girlrate, childClassName, chartRate);
    });
  }

  String weatherTemperature = '22';
  String weatherType = '비';
  String weatherHumidity = '85';
  String weatherPm10 = '비';
  String weatherPm25 = '비';
  var sensorLocation = '비';
  var sensorTemperature = '비';
  var sensorHumidity = '비';
  var sensorPm25 = '비';
  var sensorPm10 = '비';
  var sensorCo2 = '비';
  var sensorTvoc = '비';

  String weather_assets = 'assets/airple_weather/sunny.jpg';

  ///환경데이터 api
  void _callEnvApi() async {
    final client = RestInfoPanel(dio);
    final token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZGVudGlmaWNhdGlvbiI6MjIsInZlcnNpb24iOiIwLjAuNCIsImlhdCI6MTY2NzM2MTY3NCwiZXhwIjoxNjY5OTUzNjc0LCJpc3MiOiJhaWpvYSJ9.GKbcaliPyXkYy5szr_4nJOOpfN-vvigMBt3ufShmgtY';

    final response = await client.getEnvInfo(token).catchError((Object obj) {
      final res = (obj as DioError).response;
      //swagger 참조
      switch (res!.statusCode) {
        case 200:
          debugPrint('200');
          break;
        case 401:
          debugPrint('401 : 유효하지 않은 토큰입니다.');
          break;
        case 408:
          debugPrint('408 : 외부 api 연동 실패.(timeout of 5000ms exceeded)');
          break;
        case 419:
          debugPrint('419 : 토큰이 만료되었습니다.');
          break;
        case 500:
          debugPrint('500 : 심각한 서버 문제.');
          break;
        default:
          break;
      }
      return obj.response;
    });
    // print(response);//데이터 뭐가오나 확인
    Map<String, dynamic> mapResult = Map<String, dynamic>.from(
        response); //안해주면 Iteral뭐시기 형태로 데이터가 들어와 Map형식으로 읽을 수 없음
    setState(() {
      weatherTemperature = mapResult["weatherTemperature"];
      weatherType = mapResult["weatherType"];
      switch (weatherType) {
        case "구름":
          weather_assets = 'assets/airple_weather/cloudy.jpg';
          break;
        case "비":
          weather_assets = 'assets/airple_weather/rain_only.jpg';
          break;
        case "눈":
          weather_assets = 'assets/airple_weather/snow_only.jpg';
          break;
        case "눈/비":
          weather_assets = 'assets/airple_weather/snow_rain.jpg';
          break;
        case "맑음":
          weather_assets = 'assets/airple_weather/sunny.jpg';
          break;
        case "바람":
          weather_assets = 'assets/airple_weather/wind.jpg';
          break;
      }
      weatherHumidity = mapResult["weatherHumidity"];
      weatherPm10 = mapResult["weatherPm10"];
      weatherPm25 = mapResult["weatherPm25"];
      sensorLocation = mapResult["sensorLocation"][0];
      sensorTemperature = mapResult["sensorTemperature"][0];
      sensorHumidity = mapResult["sensorHumidity"][0];
      sensorPm25 = mapResult["sensorPm25"][0];
      sensorPm10 = mapResult["sensorPm10"][0];
      sensorCo2 = mapResult["sensorCo2"][0];
      sensorTvoc = mapResult["sensorTvoc"][0];
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        width: 1920.w,
        height: 980.w,
        child: Container(
            width: 200.w,
            height: 100.w,
            color: Colors.white,
            child: ElevatedButton(
              onPressed: () {

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainPanel()));

              },
              child: Text('데모 시작'),
            )),
      ),
    );
  }
}
