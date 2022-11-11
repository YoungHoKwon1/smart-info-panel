import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;
import 'package:http/http.dart' as http;
import 'package:smart_info_panel/api/airpledemo.dart';
import 'package:smart_info_panel/api/infopanel.dart';
import 'package:dio/dio.dart';
import 'package:smart_info_panel/kinder_info_2.dart';
import 'dart:async';
//import 'package:intl/intl.dart';

class ChildLifeData extends StatefulWidget {
  const ChildLifeData({Key? key}) : super(key: key);

  @override
  State<ChildLifeData> createState() => _ChildLifeDataState();
}

class _ChildLifeDataState extends State<ChildLifeData> {
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {});
    _callChildApi();
    _callEnvApi();
    _callAttendApi();

    Timer(Duration(seconds: 20), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>KinderInfo2()));
    });
  }
  Dio dio = Dio();

  String url = "http://tmap.aijoa.us:48764/";

  final token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZGVudGlmaWNhdGlvbiI6MjIsInZlcnNpb24iOiIwLjAuNCIsImlhdCI6MTY2NzM2MTY3NCwiZXhwIjoxNjY5OTUzNjc0LCJpc3MiOiJhaWpvYSJ9.GKbcaliPyXkYy5szr_4nJOOpfN-vvigMBt3ufShmgtY';

  Image childImage = Image.asset("name");
  String childName = "";
  String childBDay = '';
  String className = '';
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
    print(responseChild);//데이터 뭐가오나 확인
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
      className = mapResult["className"];
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
    final responseAttend = await client.getAttendInfo(token).catchError((Object obj) {
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
    Map<String, dynamic> mapResult = Map<String, dynamic>.from(responseAttend);//안해주면 Iteral뭐시기 형태로 데이터가 들어와 Map형식으로 읽을 수 없음
    setState(() {
      boyrate = mapResult["maleRate"];//
      girlrate = mapResult["femaleRate"];
      childClassName = mapResult["classList"];
      chartRate = mapResult["rateByClass"].cast<double>();
    });
  }



  String weatherTemperature='22';
  String weatherType='비';
  String weatherHumidity='85';
  String weatherPm10='비';
  String weatherPm25='비';
  var sensorLocation='비';
  var sensorTemperature='비';
  var sensorHumidity='비';
  var sensorPm25='비';
  var sensorPm10='비';
  var sensorCo2='비';
  var sensorTvoc='비';

  String weather_assets = 'assets/airple_weather/sunny.jpg';
  ///환경데이터 api
  void _callEnvApi() async {
    final client = RestInfoPanel(dio);
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
    Map<String, dynamic> mapResult = Map<String, dynamic>.from(response);//안해주면 Iteral뭐시기 형태로 데이터가 들어와 Map형식으로 읽을 수 없음
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
      weatherHumidity =  mapResult["weatherHumidity"];
      weatherPm10 =  mapResult["weatherPm10"];
      weatherPm25 =  mapResult["weatherPm25"];
      sensorLocation =  mapResult["sensorLocation"][0];
      sensorTemperature =  mapResult["sensorTemperature"][0];
      sensorHumidity =  mapResult["sensorHumidity"][0];
      sensorPm25 =  mapResult["sensorPm25"][0];
      sensorPm10 =  mapResult["sensorPm10"][0];
      sensorCo2 =  mapResult["sensorCo2"][0];
      sensorTvoc =  mapResult["sensorTvoc"][0];
    });
  }
  @override
  Widget build(BuildContext context) {

    if(childImage==Image.asset("name")) {
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
                  height: 880.w,
                  margin: EdgeInsets.only(left: 19.w, top: 10.w),
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
                          Container(
                            width: 356.w,
                            height: 329.w,
                            margin: EdgeInsets.only(left: 249.w, top: 49.w),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      'assets/child_face_deco/age0face.png')),
                            ),
                            child: childImage,
                          ),

                          ///아이정보
                          Center(
                            child: Container(
                                width: 170.w,
                                height: 195.w,
                                margin: EdgeInsets.only(left: 5.w, top: 110.w),
                                child: Text(
                                    childName +
                                        "\n\n" +
                                        bdayYear +
                                        "년 " +
                                        bdayMonth +
                                        "월 " +
                                        bdayDay +
                                        "일" +
                                        "\n\n" +
                                        className +
                                        "\n\n" +
                                        collectionPeriod +
                                        "개월",
                                    style: TextStyle(
                                      fontFamily: 'NotoSansKR',
                                      color: const Color(0xff39605f),
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                    ))),
                          ),

                          ///아이정보
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 34.w, top: 65.w),
                        child: Column(
                          children: [
                            ///첫줄 목차
                            Row(
                              children: [
                                Container(
                                  width: 164.w,
                                  height: 41.w,
                                  decoration: const BoxDecoration(
                                      color: Color(0xffc7f7f5),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10))),
                                  child: Center(
                                    child: Text(
                                      '출석일수',
                                      style: TextStyle(
                                        color: const Color(0xff393838),
                                        fontSize: 16.sp,
                                        fontFamily: 'NotoSansKR',
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 164.w,
                                  height: 41.w,
                                  decoration: const BoxDecoration(
                                      color: Color(0xffc7f7f5)),
                                  child: Center(
                                    child: Text(
                                      '평균등원시간',
                                      style: TextStyle(
                                        color: const Color(0xff393838),
                                        fontSize: 16.sp,
                                        fontFamily: 'NotoSansKR',
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 164.w,
                                  height: 41.w,
                                  decoration: const BoxDecoration(
                                      color: Color(0xffc7f7f5)),
                                  child: Center(
                                    child: Text(
                                      '평균하원시간',
                                      style: TextStyle(
                                        color: const Color(0xff393838),
                                        fontSize: 16.sp,
                                        fontFamily: 'NotoSansKR',
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 164.w,
                                  height: 41.w,
                                  decoration: const BoxDecoration(
                                      color: Color(0xffc7f7f5)),
                                  child: Center(
                                    child: Text(
                                      '신장/체중',
                                      style: TextStyle(
                                        color: const Color(0xff393838),
                                        fontSize: 16.sp,
                                        fontFamily: 'NotoSansKR',
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 164.w,
                                  height: 41.w,
                                  decoration: const BoxDecoration(
                                      color: Color(0xffc7f7f5)),
                                  child: Center(
                                    child: Text(
                                      '등원전 감정분포도',
                                      style: TextStyle(
                                        color: const Color(0xff393838),
                                        fontSize: 16.sp,
                                        fontFamily: 'NotoSansKR',
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 164.w,
                                  height: 41.w,
                                  decoration: const BoxDecoration(
                                      color: Color(0xffc7f7f5),
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10))),
                                  child: Center(
                                    child: Text(
                                      '하원전 감정분포도',
                                      style: TextStyle(
                                        color: const Color(0xff393838),
                                        fontSize: 16.sp,
                                        fontFamily: 'NotoSansKR',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            ///첫줄목차
                            ///첫줄데이터
                            Row(
                              children: [
                                Container(
                                  width: 164.w,
                                  height: 110.w,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Color(0x4d63e6d7),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10))),
                                  child: Center(
                                    child: Text(
                                      attendanceCount,
                                      style: TextStyle(
                                        color: Color(0xff39605f),
                                        fontSize: 30.sp,
                                        fontFamily: 'GamjaFlower',
                                      ),
                                      strutStyle: StrutStyle(
                                        fontSize: 30.sp,
                                        forceStrutHeight: true,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 164.w,
                                  height: 110.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Color(0x4d63e6d7),
                                      width: 1,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      avgAttendTime,
                                      style: TextStyle(
                                        color: Color(0xff39605f),
                                        fontSize: 30.sp,
                                        fontFamily: 'GamjaFlower',
                                      ),
                                      strutStyle: StrutStyle(
                                        fontSize: 30.sp,
                                        forceStrutHeight: true,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 164.w,
                                  height: 110.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Color(0x4d63e6d7),
                                      width: 1,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      avgGoinghomeTime,
                                      style: TextStyle(
                                        color: Color(0xff39605f),
                                        fontSize: 30.sp,
                                        fontFamily: 'GamjaFlower',
                                      ),
                                      strutStyle: StrutStyle(
                                        fontSize: 30.sp,
                                        forceStrutHeight: true,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 164.w,
                                  height: 110.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Color(0x4d63e6d7),
                                      width: 1,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      height + "cm\n" + weight + "kg",
                                      style: TextStyle(
                                        color: Color(0xff39605f),
                                        fontSize: 30.sp,
                                        fontFamily: 'GamjaFlower',
                                      ),
                                      strutStyle: StrutStyle(
                                        fontSize: 30.sp,
                                        forceStrutHeight: true,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 164.w,
                                  height: 110.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Color(0x4d63e6d7),
                                      width: 1,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      beforeAttendEmotion,
                                      style: TextStyle(
                                        color: Color(0xff39605f),
                                        fontSize: 30.sp,
                                        fontFamily: 'GamjaFlower',
                                      ),
                                      strutStyle: StrutStyle(
                                        fontSize: 30.sp,
                                        forceStrutHeight: true,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 164.w,
                                  height: 110.w,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Color(0x4d63e6d7),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(10))),
                                  child: Center(
                                    child: Text(
                                      beforeGoingHomeEmotion,
                                      style: TextStyle(
                                        color: Color(0xff39605f),
                                        fontSize: 30.sp,
                                        fontFamily: 'GamjaFlower',
                                      ),
                                      strutStyle: StrutStyle(
                                        fontSize: 30.sp,
                                        forceStrutHeight: true,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )

                            ///
                          ],
                        ),
                      ),

                      ///--------------------------------------------------두번째줄
                      ///
                      Container(
                        margin: EdgeInsets.only(left: 34.w, top: 50.w),
                        child: Column(
                          children: [
                            ///둘째줄 목차
                            Row(
                              children: [
                                Container(
                                  width: 164.w,
                                  height: 41.w,
                                  decoration: const BoxDecoration(
                                      color: Color(0xffc7f7f5),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10))),
                                  child: Center(
                                    child: Text(
                                      '평균식사량',
                                      style: TextStyle(
                                        color: const Color(0xff393838),
                                        fontSize: 16.sp,
                                        fontFamily: 'NotoSansKR',
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 164.w,
                                  height: 41.w,
                                  decoration: const BoxDecoration(
                                      color: Color(0xffc7f7f5)),
                                  child: Center(
                                    child: Text(
                                      '평균수면량',
                                      style: TextStyle(
                                        color: const Color(0xff393838),
                                        fontSize: 16.sp,
                                        fontFamily: 'NotoSansKR',
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 164.w,
                                  height: 41.w,
                                  decoration: const BoxDecoration(
                                      color: Color(0xffc7f7f5)),
                                  child: Center(
                                    child: Text(
                                      '총 구토 횟수',
                                      style: TextStyle(
                                        color: const Color(0xff393838),
                                        fontSize: 16.sp,
                                        fontFamily: 'NotoSansKR',
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 164.w,
                                  height: 41.w,
                                  decoration: const BoxDecoration(
                                      color: Color(0xffc7f7f5)),
                                  child: Center(
                                    child: Text(
                                      '총 배변 횟수',
                                      style: TextStyle(
                                        color: const Color(0xff393838),
                                        fontSize: 16.sp,
                                        fontFamily: 'NotoSansKR',
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 164.w,
                                  height: 41.w,
                                  decoration: const BoxDecoration(
                                      color: Color(0xffc7f7f5)),
                                  child: Center(
                                    child: Text(
                                      '총 투약일',
                                      style: TextStyle(
                                        color: const Color(0xff393838),
                                        fontSize: 16.sp,
                                        fontFamily: 'NotoSansKR',
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 164.w,
                                  height: 41.w,
                                  decoration: const BoxDecoration(
                                      color: Color(0xffc7f7f5),
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10))),
                                  child: Center(
                                    child: Text(
                                      '총 안전사고 횟수',
                                      style: TextStyle(
                                        color: const Color(0xff393838),
                                        fontSize: 16.sp,
                                        fontFamily: 'NotoSansKR',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            ///둘째줄 목차
                            ///둘째줄데이터
                            Row(
                              children: [
                                Container(
                                  width: 164.w,
                                  height: 110.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Color(0x4d63e6d7),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10)),
                                  ),
                                  child: Center(
                                    child: Text(
                                      avgMeal,
                                      style: TextStyle(
                                        color: Color(0xff39605f),
                                        fontSize: 30.sp,
                                        fontFamily: 'GamjaFlower',
                                      ),
                                      strutStyle: StrutStyle(
                                        fontSize: 30.sp,
                                        forceStrutHeight: true,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 164.w,
                                  height: 110.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Color(0x4d63e6d7),
                                      width: 1,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      avgSleep,
                                      style: TextStyle(
                                        color: Color(0xff39605f),
                                        fontSize: 30.sp,
                                        fontFamily: 'GamjaFlower',
                                      ),
                                      strutStyle: StrutStyle(
                                        fontSize: 30.sp,
                                        forceStrutHeight: true,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 164.w,
                                  height: 110.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Color(0x4d63e6d7),
                                      width: 1,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      vomitCount + "회",
                                      style: TextStyle(
                                        color: Color(0xff39605f),
                                        fontSize: 30.sp,
                                        fontFamily: 'GamjaFlower',
                                      ),
                                      strutStyle: StrutStyle(
                                        fontSize: 30.sp,
                                        forceStrutHeight: true,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 164.w,
                                  height: 110.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Color(0x4d63e6d7),
                                      width: 1,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      toiletCount + "회",
                                      style: TextStyle(
                                        color: Color(0xff39605f),
                                        fontSize: 30.sp,
                                        fontFamily: 'GamjaFlower',
                                      ),
                                      strutStyle: StrutStyle(
                                        fontSize: 30.sp,
                                        forceStrutHeight: true,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 164.w,
                                  height: 110.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Color(0x4d63e6d7),
                                      width: 1,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      medicineCount + "일",
                                      style: TextStyle(
                                        color: Color(0xff39605f),
                                        fontSize: 30.sp,
                                        fontFamily: 'GamjaFlower',
                                      ),
                                      strutStyle: StrutStyle(
                                        fontSize: 30.sp,
                                        forceStrutHeight: true,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 164.w,
                                  height: 110.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Color(0x4d63e6d7),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(10)),
                                  ),
                                  child: Center(
                                    child: Text(
                                      accidentCount + "회",
                                      style: TextStyle(
                                        color: Color(0xff39605f),
                                        fontSize: 30.sp,
                                        fontFamily: 'GamjaFlower',
                                      ),
                                      strutStyle: StrutStyle(
                                        fontSize: 30.sp,
                                        forceStrutHeight: true,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )

                            ///
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                ///광고
                Container(
                  width: 970.w,
                  height: 90.w,
                  margin: EdgeInsets.only(
                    left: 58.w,
                    top: 50.w,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Color(0xff707070),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '광고(970x90)',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontFamily: '.AppleSystemUIFont',
                      ),
                      strutStyle: StrutStyle(
                        fontSize: 20.sp,
                        forceStrutHeight: true,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            /// 등원유아 수, 공기질
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
