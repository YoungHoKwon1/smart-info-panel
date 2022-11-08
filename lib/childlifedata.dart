import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;
import 'package:http/http.dart' as http;
import 'package:smart_info_panel/api/airpledemo.dart';
import 'package:smart_info_panel/api/infopanel.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class ChildLifeData extends StatefulWidget {
  const ChildLifeData({Key? key}) : super(key: key);

  @override
  State<ChildLifeData> createState() => _ChildLifeDataState();
}

// class AirQ {
//   final String Temperature;
//   final String serialNum = '';
//   final String Lng = '';
//   final String Pm25 = '';
//   final String ip = '';
//   final String dataType = '';
//   final String Co2 = '';
//   final String ReportTime = '';
//   final String Tvoc = '';
//   final String Humid = '';
//   final String Pm10 = '';
//   final String myreport = '';
//   final String Lat = '';
//
//   AirQ({
//     required this.Temperature,
//     //required this.serialNum,
// });
// }

class _ChildLifeDataState extends State<ChildLifeData> {
  double degrees = 90;
  double radians = 0;
  Dio dio = Dio();
  late FormData formData;

  String Temp='';
  String Humid='';
  String Pm25='';
  String Co2='';
  String Tvoc='';

  String startTime = DateFormat('yyyyMMddHHmm00').format(DateTime.now().subtract(Duration(days: 7,hours: -9,minutes: 10, seconds: 0)));
  String endTime = DateFormat('yyyyMMddHHmm00').format(DateTime.now().subtract(Duration(days: 7,hours: -9,minutes: 9, seconds: 0)));
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    radians = degrees * math.pi / 180;
    print(startTime);
    print(endTime);
    _callAirpleApi();
    // _callAijoaEnv();
  }

  void _callAirpleApi() async {
      final client = RestAirpleDemo(dio);
      final token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZGVudGlmaWNhdGlvbiI6MjIsInZlcnNpb24iOiIwLjAuNCIsImlhdCI6MTY2NzM2MTY3NCwiZXhwIjoxNjY5OTUzNjc0LCJpc3MiOiJhaWpvYSJ9.GKbcaliPyXkYy5szr_4nJOOpfN-vvigMBt3ufShmgtY';

      formData = FormData.fromMap({
        "serialNum": "AC67B25CC502",
        "startTime": startTime,
        "endTime": endTime,
        "type": "Co2,Humid,Pm10,Pm25,Temperature,Tvoc"
      });
      final responseEnv = await client.postEnvInfo(formData).catchError((Object obj) {
        final res = (obj as DioError).response;
        switch (res!.statusCode) {
          case 401:
            debugPrint('401 : 유효하지 않은 토큰21입니다.');
            break;
          case 408:
            debugPrint('408 : 외부 api 연동 실패.(timeout of 5000ms exceeded)');
            break;
          case 419:
            debugPrint('419 : 토큰이 만료되었습니다.');
            break;
          case 500:
            debugPrint('500 : 서버 에러.');
            break;
          default:
            break;
        }
        return obj.response;

      });
      Map<String, dynamic> mapResult = Map<String, dynamic>.from(responseEnv);
      print(mapResult);
      print(mapResult["data"][0]["Temperature"]);
      print(mapResult["data"][0]["Humid"]);
      print(mapResult["data"][0]["Pm25"]);
      print(mapResult["data"][0]["Co2"]);
      print(mapResult["data"][0]["Tvoc"]);

      setState(() {
        Temp = mapResult["data"][0]["Temperature"];
        Humid = mapResult["data"][0]["Humid"];
        Pm25 = mapResult["data"][0]["Pm25"];
        Co2 = mapResult["data"][0]["Co2"];
        Tvoc = mapResult["data"][0]["Tvoc"];
      });
  }


  double boyrate = 0.5;
  double girlrate = 0.7;

  int childHeadCount = 8;
  List<String> childClassName = [
    '가나다',
    '라마바',
    '사아자',
    '차카타',
    '파하가',
    '나다라',
    '마바사',
    '아자차',
    '카타파',
    '하가나',
  ]; //반 이름입니다.
  List<double> chartRate = [0.67, 0.89, 0.30, 1.00, 0.92, 0.94, 0.89, 0.90];

  @override
  Widget build(BuildContext context) {
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
                              image: AssetImage('assets/child_face_deco/age0face.png')
                            )
                          ),
                        ),

                        ///아이정보
                        Container(
                            width: 170.w,
                            height: 195.w,
                            margin: EdgeInsets.only(left: 5.w, top: 140.w),
                            child:
                                new Text("김사랑\n2018년 5월 3일\n꽃잎사랑반\n수집기간: 6개월",
                                    style: TextStyle(
                                      fontFamily: 'NotoSansKR',
                                      color: const Color(0xff39605f),
                                      fontSize: 25.sp,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                    ))),

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
                                    '25',
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
                                    '08:35',
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
                                    '19:35',
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
                                    "113cm\n22kg",
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
                                    '08:35',
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
                                    '08:35',
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
                                    '25',
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
                                    '08:35',
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
                                    '19:35',
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
                                    "113cm\n22kg",
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
                                    '08:35',
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
                                    '08:35',
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
                                margin: EdgeInsets.only(left: 26.w, top: 16.w),
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
                        margin: EdgeInsets.only(left: 40.w,top: 40.w),
                        child: // 학급별
                        Text(
                            "학급별",
                            style:  TextStyle(
                                color:   Color(0xff39605f),
                                fontWeight: FontWeight.w700,
                                fontFamily: "NotoSansKR",
                                fontStyle:  FontStyle.normal,
                                fontSize: 20.sp
                            ),
                            textAlign: TextAlign.left
                        )
                    ),
                    Container(
                        width: 748.w,
                        height: 160.w,
                        margin: EdgeInsets.only(left: 40.w, top: 20.w),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children:[
                              for(int i=0;i<chartRate.length;i++)...[
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(bottom: 2.w),
                                        child: Text((100*chartRate[i]).toString()+"%",
                                            style: TextStyle(
                                              fontFamily: 'NotoSansKR',
                                              color: Color(0xff393838),
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.normal,
                                            )
                                        ),
                                      ),
                                      Container(
                                          width: 20.w,
                                          height: 135 * chartRate[i].w,
                                          decoration: BoxDecoration(
                                            color: Color(0xffc7f7f5),
                                            borderRadius: BorderRadius.only(topRight: Radius.circular(10.w), topLeft:Radius.circular(10.w)),
                                          )
                                      ),
                                    ]
                                ),
                              ]
                            ]
                        )
                    ),
                    Container(
                        width: 748.w,
                        height: 3.w,
                        margin: EdgeInsets.only(left: 40.w),
                        decoration: BoxDecoration(
                            color: Color(0xff63e6d7)
                        )
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 40.w),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            for(int i=0;i<chartRate.length;i++)...[
                              Text(childClassName[i],
                                  style: TextStyle(
                                    fontFamily: '.AppleSystemUIFont',
                                    color: Color(0xff000000),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                  )
                              )
                            ]
                          ]
                      ),
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
                decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/airple_weather/sunny.jpg'),
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
                          child: Text("CO2",
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
                          child: Text("VOC",
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
                    //SizedBox(width: 26.w,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(Temp+"도",
                              style: TextStyle(
                                fontFamily: 'GamjaFlower',
                                color: const Color(0xff42372c),
                                fontSize: 40.sp,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                              )),
                          margin: EdgeInsets.only(top: 40.w),
                        ),
                        Container(
                          child: Text(Humid+"%",
                              style: TextStyle(
                                fontFamily: 'GamjaFlower',
                                color: const Color(0xff42372c),
                                fontSize: 40.sp,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                              )),
                          margin: EdgeInsets.only(top: 40.w),
                        ),
                        Container(
                          child: Center(
                            child: Text(Pm25,
                                style: TextStyle(
                                  fontFamily: 'GamjaFlower',
                                  color: const Color(0xff42372c),
                                  fontSize: 40.sp,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                )),
                          ),
                          margin: EdgeInsets.only(top: 43.w),
                        ),
                        Container(
                          child: Text(Co2+"ppm",
                              style: TextStyle(
                                fontFamily: 'GamjaFlower',
                                color: const Color(0xff42372c),
                                fontSize: 40.sp,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                              )),
                          margin: EdgeInsets.only(top: 45.w),
                        ),
                        Container(
                          child: Text(Tvoc+"ppb",
                              style: TextStyle(
                                fontFamily: 'GamjaFlower',
                                color: const Color(0xff42372c),
                                fontSize: 40.sp,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                              )),
                          margin: EdgeInsets.only(top: 43.w),
                        ),
                      ],
                    )
                  ],
                ),
              )

              ///공기질
            ],
          )///등원유아 수, 공기질
        ],
      ),
    );
  }

}
