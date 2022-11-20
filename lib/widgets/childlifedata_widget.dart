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

class ChildLifeDataWidget extends StatefulWidget {
  const ChildLifeDataWidget({Key? key}) : super(key: key);

  @override
  State<ChildLifeDataWidget> createState() => _ChildLifeDataWidgetState();
}

class _ChildLifeDataWidgetState extends State<ChildLifeDataWidget> {
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {});
    _callChildApi();
    _callEnvApi();
    _callAttendApi();

    // Timer(Duration(seconds: 20), () {
    //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>KinderInfo2()));
    // });
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
    return Column(
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
    );
  }
}
