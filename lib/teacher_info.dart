import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_info_panel/classinfo10.dart';
import 'api/infopanel.dart';

import 'dart:math' as math;
import 'dart:async';

import 'classinfo20.dart';
import 'classinfo30.dart';
//왠지는
class TeacherInfo extends StatefulWidget {
  const TeacherInfo({Key? key}) : super(key: key);

  @override
  State<TeacherInfo> createState() => _TeacherInfoState();
}

class _TeacherInfoState extends State<TeacherInfo> {
  int touchedIndex = -1;

  @override
  void initState() {
    super.initState();
    _callBasicApi();
    _callEnvApi();
    _callAttendApi();
    Timer(Duration(seconds: 20), () {
      if(childNum<=10) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ClassInfo10()));
      } else if(childNum>10 || childNum<20) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ClassInfo20()));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ClassInfo30()));
      }
    });
  }

  Dio dio = Dio();

  String url = "http://tmap.aijoa.us:48764/";
  final token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZGVudGlmaWNhdGlvbiI6MjIsInZlcnNpb24iOiIwLjAuNCIsImlhdCI6MTY2NzM2MTY3NCwiZXhwIjoxNjY5OTUzNjc0LCJpc3MiOiJhaWpvYSJ9.GKbcaliPyXkYy5szr_4nJOOpfN-vvigMBt3ufShmgtY';

  int childNum = 0;
  int column = 4;
  int row = 0;
  int rest = 0; //나머지 아이들
  String className = '새싹어린이반';
  int teacherNum = 0;
  int directorNum = 0;
  int committeeNum = 0;
  List<String> directorImagePath = [];
  List<Image> directorImage = [];
  List<String> directorName = [];
  List<String> directorIntroduction = [];
  List<Image> teacherImage = [];
  List<String> teacherName = [];
  List<String> teacherIntroduction = [];

  List<Image> committeeImage = [];
  List<String> committeeName = [];
  List<String> committeeClassName = [];

  void _callBasicApi() async {
    final client = RestInfoPanel(dio);
    Map<String, String> headers = Map();
    headers['authorization'] = token;
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
    // print("basic:  "+mapResult["classInfo"].toString());
    // print(mapResult["committees"]);//학급이벤트
    // print(mapResult["classInfo"]);//학급소개왼쪽
    // print(mapResult["classInfo"][0]);
    setState(() {
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
      }
    });
  }

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
  List<int> classInfo = [0, 10, 6, 4]; //반 나이, 총 인원, 남아 수, 여아 수 순서

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
    // print(responseAttend);//데이터 뭐가오나 확인
    Map<String, dynamic> mapResult = Map<String, dynamic>.from(
        responseAttend); //안해주면 Iteral뭐시기 형태로 데이터가 들어와 Map형식으로 읽을 수 없음
    setState(() {
      boyrate = mapResult["maleRate"]; //
      girlrate = mapResult["femaleRate"];
      childClassName = mapResult["classList"];
      chartRate = mapResult["rateByClass"].cast<double>();
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
      weatherTemperature =  mapResult["weatherTemperature"];
      weatherType =  mapResult["weatherType"];
      switch(weatherType) {
        case "구름" :
          weather_assets = 'assets/airple_weather/cloudy.jpg';
          break;
        case "비" :
          weather_assets = 'assets/airple_weather/rain_only.jpg';
          break;
        case "눈" :
          weather_assets = 'assets/airple_weather/snow_only.jpg';
          break;
        case "눈/비" :
          weather_assets = 'assets/airple_weather/snow_rain.jpg';
          break;
        case "맑음" :
          weather_assets = 'assets/airple_weather/sunny.jpg';
          break;
        case "바람" :
          weather_assets = 'assets/airple_weather/wind.jpg';
          break;
      }
      weatherTemperature = mapResult["weatherTemperature"];
      weatherType = mapResult["weatherType"];
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

    if(weatherType=='비') {
      return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                      ),
                      Container(
                        width: 200.0,
                        height: 200.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                      ),
                      Container(
                        width: 500.0,
                        child: LinearProgressIndicator(
                          backgroundColor: Colors.pink,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                      ),
                      Text(
                        "Loading.....",
                        style: TextStyle(color: Colors.yellow, fontSize: 18.0, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      );
    }
    else{
      return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          children: [
            Column(
              children: [
                Container(
                  width: 1048.w,
                  height: 895.w,
                  margin: EdgeInsets.only(left: 16.w, top: 16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: const Color(0x6663e6d7),
                      width: 1.w,
                    ),
                    borderRadius: BorderRadius.circular(20.w),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x29b1b1b1),
                        offset: Offset(-2.w, 2.w),
                        blurRadius: 6.w,
                        spreadRadius: 0.w,
                      ),
                      BoxShadow(
                        color: const Color(0x29dbdbdb),
                        offset: Offset(-2.w, -4.w),
                        blurRadius: 6.w,
                        spreadRadius: 0.w,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ///원장
                          for (int i = 0; i < directorNum; i++) ...[
                            Column(
                              children: [
                                Container(
                                    width: 140.w,
                                    height: 140.w,
                                    //페이지에 따라 마진 조절 바람 건희, 성민
                                    margin:
                                        EdgeInsets.only(left: 102.w, top: 49.w),
                                    child: directorImage[i]),
                                Container(
                                  width: 200.w,
                                  height: 45.w,
                                  margin: EdgeInsets.only(left: 102.w),
                                  decoration: BoxDecoration(
                                      color: Color(0xff71d8d4),
                                      borderRadius:
                                          BorderRadius.circular(22.5)),
                                  child: Center(
                                    child: Text(
                                      directorName[i],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.sp,
                                        fontFamily: '.NotoSansKR',
                                      ),
                                      strutStyle: StrutStyle(
                                        fontSize: 18.sp,
                                        forceStrutHeight: true,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 200.w,
                                  height: 45.w,
                                  margin: EdgeInsets.only(left: 102.w),
                                  child: Center(
                                    child: Text(
                                      directorIntroduction[i],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontFamily: '.NotoSansKR',
                                      ),
                                      strutStyle: StrutStyle(
                                        fontSize: 18.sp,
                                        forceStrutHeight: true,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ]

                          ///원장
                        ],
                      ),

                      ///선생님
                      for (int i = 0; i < 1; i++) ...[
                        // 총 row줄, row column 잘 안먹으면 일단 그냥 정수 박으세요
                        Row(
                          children: [
                            for (int j = 0; j < teacherNum; j++) ...[
                              Column(
                                //사진+이름배치를 위해 column으로 시작
                                children: [
                                  if (j == 0) ...[
                                    Container(
                                        width: 135.w,
                                        height: 135.w,
                                        margin: EdgeInsets.only(
                                            left: 23.w, top: 65.w),
                                        child: teacherImage[j]),
                                    Container(
                                      width: 180.w,
                                      height: 45.w,
                                      margin: EdgeInsets.only(left: 28.w),
                                      decoration: new BoxDecoration(
                                          color: Color(0xffc7f7f5),
                                          borderRadius:
                                              BorderRadius.circular(22.5)),
                                      child: Center(
                                        child: Text(teacherName[j],
                                            style: TextStyle(
                                              fontFamily: '.NotoSansKR',
                                              color: Color(0xff000000),
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.normal,
                                            )),
                                      ),
                                    ),
                                    Container(
                                        width: 160.w,
                                        height: 47.w,
                                        margin: EdgeInsets.only(left: 38.w),
                                        child: Center(
                                            child: Text(teacherIntroduction[j],
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.sp,
                                                  fontFamily: '.NotoSansKR',
                                                ),
                                                strutStyle: StrutStyle(
                                                  fontSize: 18.sp,
                                                  forceStrutHeight: true,
                                                ))))
                                  ] else ...[
                                    Container(
                                        width: 135.w,
                                        height: 135.w,
                                        margin: EdgeInsets.only(
                                            left: 13.w, top: 65.w),
                                        child: teacherImage[j]),
                                    Container(
                                      width: 180.w,
                                      height: 45.w,
                                      margin: EdgeInsets.only(left: 23.w),
                                      decoration: new BoxDecoration(
                                          color: Color(0xffc7f7f5),
                                          borderRadius:
                                              BorderRadius.circular(17.5)),
                                      child: Center(
                                        child: Text(teacherName[j],
                                            style: TextStyle(
                                              fontFamily: 'NotoSansKR',
                                              color: Color(0xff000000),
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.normal,
                                            )),
                                      ),
                                    ),
                                    Container(
                                        width: 160.w,
                                        height: 47.w,
                                        margin: EdgeInsets.only(left: 43.w),
                                        child: Center(
                                            child: Text(teacherIntroduction[j],
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.sp,
                                                  fontFamily: '.NotoSansKR',
                                                ),
                                                strutStyle: StrutStyle(
                                                  fontSize: 18.sp,
                                                  forceStrutHeight: true,
                                                ))))
                                  ],
                                ],
                              )
                            ]
                          ],
                        )
                      ],

                      ///학부모
                      for (int i = 0; i < 1; i++) ...[
                        // 총 row줄, row column 잘 안먹으면 일단 그냥 정수 박으세요
                        Row(
                          children: [
                            for (int j = 0; j < committeeNum; j++) ...[
                              Column(
                                //사진+이름배치를 위해 column으로 시작
                                children: [
                                  if (j == 0) ...[
                                    Container(
                                        width: 135.w,
                                        height: 135.w,
                                        margin: EdgeInsets.only(
                                            left: 23.w, top: 65.w),
                                        child: committeeImage[j]),
                                    Container(
                                      width: 180.w,
                                      height: 45.w,
                                      margin: EdgeInsets.only(left: 28.w),
                                      decoration: new BoxDecoration(
                                          color: Color(0xffffc9c9),
                                          borderRadius:
                                              BorderRadius.circular(22.5)),
                                      child: Center(
                                        child: Text(committeeName[j],
                                            style: TextStyle(
                                              fontFamily: '.NotoSansKR',
                                              color: Color(0xff000000),
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.normal,
                                            )),
                                      ),
                                    ),
                                    Container(
                                        width: 160.w,
                                        height: 47.w,
                                        margin: EdgeInsets.only(left: 38.w),
                                        child: Center(
                                            child: Text(committeeClassName[j],
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.sp,
                                                  fontFamily: '.NotoSansKR',
                                                ),
                                                strutStyle: StrutStyle(
                                                  fontSize: 18.sp,
                                                  forceStrutHeight: true,
                                                ))))
                                  ] else ...[
                                    Container(
                                        width: 135.w,
                                        height: 135.w,
                                        margin: EdgeInsets.only(
                                            left: 13.w, top: 65.w),
                                        child: committeeImage[j]),
                                    Container(
                                      width: 180.w,
                                      height: 45.w,
                                      margin: EdgeInsets.only(left: 23.w),
                                      decoration: new BoxDecoration(
                                          color: Color(0xffffc9c9),
                                          borderRadius:
                                              BorderRadius.circular(17.5)),
                                      child: Center(
                                        child: Text(committeeName[j],
                                            style: TextStyle(
                                              fontFamily: 'NotoSansKR',
                                              color: Color(0xff000000),
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.normal,
                                            )),
                                      ),
                                    ),
                                    Container(
                                        width: 160.w,
                                        height: 47.w,
                                        margin: EdgeInsets.only(left: 33.w),
                                        child: Center(
                                            child: Text(committeeClassName[j],
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.sp,
                                                  fontFamily: '.NotoSansKR',
                                                ),
                                                strutStyle: StrutStyle(
                                                  fontSize: 18.sp,
                                                  forceStrutHeight: true,
                                                ))))
                                  ],
                                ],
                              )
                            ]
                          ],
                        )
                      ]
                    ],
                  ),
                ),
              ],
            ),

            /// 등원유아 수, 공기질
            /// 가로그래프의 경우 아시다시피 세로그래프를 => 가로그래프 로 회전시킨거라
            /// 가로그래프의 길이(width)를 넓힐 경우 => 해당 구역의 height가 늘어나 밑에 overflow가 발생합니다
            /// 이는 차후에 수정해 나가야 할 듯 싶습니다.
            Column(
              children: [
                ///등원유아 수
                // 사각형 9608
                Container(
                  width: 820.w,
                  height: 518.w,
                  margin: EdgeInsets.only(left: 15.w, top: 10.w),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border:
                          Border.all(color: const Color(0x6663e6d7), width: 1),
                      boxShadow: const [
                        BoxShadow(
                            color: Color(0x29b1b1b1),
                            offset: Offset(-2, 2),
                            blurRadius: 6,
                            spreadRadius: 0),
                        BoxShadow(
                            color: Color(0x29dbdbdb),
                            offset: Offset(-2, -4),
                            blurRadius: 6,
                            spreadRadius: 0)
                      ],
                      color: const Color(0xffffffff)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 40.w, top: 40.w),
                        child: Text(
                          '등원유아 수',
                          style: TextStyle(
                            color: const Color(0xff39605f),
                            fontSize: 20.sp,
                            fontFamily: 'NotoSansKR',
                            fontWeight: FontWeight.w700,
                          ),
                          strutStyle: StrutStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            forceStrutHeight: true,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          ///남아
                          Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  width: 182.w,
                                  height: 110.w,
                                  margin:
                                      EdgeInsets.only(left: 26.w, top: 16.w),
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        'assets/childlifedata/02_3.jpg'),
                                  )),
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(left: 130.w, top: 60.w),
                                    child: Text("남아",
                                        style: TextStyle(
                                          fontFamily: 'GamjaFlower',
                                          color: const Color(0xff39605f),
                                          fontSize: 30.sp,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                        )),
                                  )),
                              Container(
                                width: 336 * boyrate.w,
                                height: 20.w,
                                margin: EdgeInsets.only(left: 40.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18.w),
                                  color: const Color(0x4d63e66d),
                                ),
                                child: Text(
                                  (100 * boyrate).toString() + "%",
                                  style: TextStyle(fontSize: 16.sp),
                                  textAlign: TextAlign.right,
                                ),
                              )
                              //남아
                            ],
                          ),

                          ///남아
                          SizedBox(width: 50.w),

                          ///여아
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                      width: 182.w,
                                      height: 105.w,
                                      margin: EdgeInsets.only(top: 16.w),
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                            'assets/childlifedata/02_4.jpg'),
                                      )),
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: 130.w, top: 60.w),
                                        child: Text("여아",
                                            style: TextStyle(
                                              fontFamily: 'GamjaFlower',
                                              color: const Color(0xff39605f),
                                              fontSize: 30.sp,
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.normal,
                                            )),
                                      )),
                                ],
                              ),
                              Container(
                                width: 336 * girlrate.w,
                                //336
                                height: 20.w,
                                margin: EdgeInsets.only(left: 20.w),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18.w),
                                    color: const Color(0xffffc9c9)),
                                child: Text(
                                  (100 * girlrate).toString() + "%",
                                  style: TextStyle(fontSize: 16.sp),
                                  textAlign: TextAlign.right,
                                ),
                              )
                            ],
                          )

                          ///여아
                        ],
                      ),

                      ///학급별그래프
                      Container(
                          width: 70.w,
                          height: 29.w,
                          margin: EdgeInsets.only(left: 40.w, top: 40.w),
                          child: // 학급별
                              Text("학급별",
                                  style: TextStyle(
                                      color: Color(0xff39605f),
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "NotoSansKR",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 20.sp),
                                  textAlign: TextAlign.left)),
                      Container(
                          width: 748.w,
                          height: 160.w,
                          margin: EdgeInsets.only(left: 40.w, top: 20.w),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                for (int i = 0; i < chartRate.length; i++) ...[
                                  Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(bottom: 2.w),
                                          child: Text(
                                              (100 * chartRate[i]).toString() +
                                                  "%",
                                              style: TextStyle(
                                                fontFamily: 'NotoSansKR',
                                                color: Color(0xff393838),
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal,
                                              )),
                                        ),
                                        Container(
                                            width: 20.w,
                                            height: 135 * chartRate[i].w,
                                            decoration: BoxDecoration(
                                              color: Color(0xffc7f7f5),
                                              borderRadius: BorderRadius.only(
                                                  topRight:
                                                      Radius.circular(10.w),
                                                  topLeft:
                                                      Radius.circular(10.w)),
                                            )),
                                      ]),
                                ]
                              ])),
                      Container(
                          width: 748.w,
                          height: 3.w,
                          margin: EdgeInsets.only(left: 40.w),
                          decoration: BoxDecoration(color: Color(0xff63e6d7))),
                      Container(
                        margin: EdgeInsets.only(left: 40.w),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              for (int i = 0; i < chartRate.length; i++) ...[
                                Text(childClassName[i],
                                    style: TextStyle(
                                      fontFamily: '.AppleSystemUIFont',
                                      color: Color(0xff000000),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                    ))
                              ]
                            ]),
                      )

                      ///학급별그래프
                    ],
                  ),

                  ///등원유아 수
                ),

                ///공기질
                Container(
                  width: 820.w,
                  height: 518.w,
                  margin: EdgeInsets.only(left: 15.w, top: 12.w),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(weather_assets),
                      )),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 594.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text("온도",
                                style: TextStyle(
                                  fontFamily: 'NotoSansKR',
                                  color: const Color(0xffc45d1a),
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                )),
                            margin: EdgeInsets.only(top: 62.w),
                          ),
                          Container(
                            child: Text("습도",
                                style: TextStyle(
                                  fontFamily: 'NotoSansKR',
                                  color: const Color(0xffc45d1a),
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                )),
                            margin: EdgeInsets.only(top: 62.w),
                          ),
                          Container(
                            child: Text("미세먼지",
                                style: TextStyle(
                                  fontFamily: 'NotoSansKR',
                                  color: const Color(0xffc45d1a),
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                )),
                            margin: EdgeInsets.only(top: 62.w),
                          ),
                          Container(
                            child: Text("이산화탄소",
                                style: TextStyle(
                                  fontFamily: 'NotoSansKR',
                                  color: const Color(0xffc45d1a),
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                )),
                            margin: EdgeInsets.only(top: 62.w),
                          ),
                          Container(
                            child: Text("초미세먼지",
                                style: TextStyle(
                                  fontFamily: 'NotoSansKR',
                                  color: const Color(0xffc45d1a),
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                )),
                            margin: EdgeInsets.only(top: 62.w),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(sensorTemperature.toString()+"도",
                                style: TextStyle(
                                  fontFamily: 'GamjaFlower',
                                  color: const Color(0xff42372c),
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                )),
                            margin: EdgeInsets.only(top: 50.w),
                          ),
                          Container(
                            child: Text(sensorHumidity.toString()+"%",
                                style: TextStyle(
                                  fontFamily: 'GamjaFlower',
                                  color: const Color(0xff42372c),
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                )),
                            margin: EdgeInsets.only(top: 55.w),
                          ),
                          Container(
                            child: Text(sensorPm10.toString()+"㎍/㎥",
                                style: TextStyle(
                                  fontFamily: 'GamjaFlower',
                                  color: const Color(0xff42372c),
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                )),
                            margin: EdgeInsets.only(top: 45.w),
                          ),
                          Container(
                            child: Text(sensorCo2.toString()+"ppm",
                                style: TextStyle(
                                  fontFamily: 'GamjaFlower',
                                  color: const Color(0xff42372c),
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                )),
                            margin: EdgeInsets.only(top: 50.w),
                          ),
                          Container(
                            child: Text(sensorPm25.toString()+"㎍/㎥",
                                style: TextStyle(
                                  fontFamily: 'GamjaFlower',
                                  color: const Color(0xff42372c),
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                )),
                            margin: EdgeInsets.only(top: 50.w),
                          ),
                        ],
                      )
                    ],
                  ),
                )

                ///공기질
              ],
            )

            ///등원유아 수, 공기질
          ],
        ),
      );
    }
  }
}
