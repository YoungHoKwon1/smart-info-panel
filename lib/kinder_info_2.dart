import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';


import 'api/infopanel.dart';
import 'package:dio/dio.dart';
import 'dart:async';

import 'kinder_info_3.dart';

//왠지는
class KinderInfo2 extends StatefulWidget {
  const KinderInfo2({Key? key}) : super(key: key);

  @override
  State<KinderInfo2> createState() => _KinderInfo2State();
}

class _KinderInfo2State extends State<KinderInfo2> {


  int touchedIndex = -1;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {});
    _callBasicApi();
    _callEnvApi();
    _callAttendApi();
    // 자동 라우팅, Timer()쓰려면 import 'dart:async'; 필요
    // Timer(Duration(seconds: 10), () {
    //   Navigator.push(context, MaterialPageRoute(builder: (context)=>KinderInfo3()));
    // });
  }

  Dio dio = Dio();

  String url = "http://tmap.aijoa.us:48764/";
  final token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZGVudGlmaWNhdGlvbiI6MjIsInZlcnNpb24iOiIwLjAuNCIsImlhdCI6MTY2NzM2MTY3NCwiZXhwIjoxNjY5OTUzNjc0LCJpc3MiOiJhaWpvYSJ9.GKbcaliPyXkYy5szr_4nJOOpfN-vvigMBt3ufShmgtY';


  List<double> classGraphRate = [20, 20, 20, 20, 20];
  List<dynamic> classGraphName = [
    '만 3세반',
    '만 4세반',
    '만 5세반',
    '혼합 3-4세반',
    '혼합 4-5세반'
  ];
  int classNumTotal=0;
  List<int> classNumEach = [1, 3, 3, 1, 1];
  List<Color> classGraphColor = [
    const Color(0xffc7f7f5),
    const Color(0xffc6d0f4),
    const Color(0xfff4dac6),
    const Color(0xfff4f4c6),
    const Color(0xfff4c6ed)
  ];
  int childNumTotal = 40;
  List<dynamic> childNumEachAge = [12, 6, 11, 12, 1];
  double childrenperteacher = 0.5;
  var childrenCountByTeacher;
  var childrenCountByClass;
  List<String> firstRowStr = [
    "교실수",
    "면적",
    "실내",
    "면적",
    "실외",
    "면적",
    "옥상",
    "면적",
    "인근",
    "면적"
  ];
  List<dynamic> firstRowInt = [4, 199, 0, 0, 0, 0, 1, 170, 0, 0];

  List<String> secondRowStr = [
    "수",
    "면적",
    "수",
    "면적",
    "수",
    "면적",
    "수",
    "면적",
  ];
  List<dynamic> secondRowInt = [0, 0, 0, 0, 1, 37, 1, 37];

  List<String> thirdRowStr = [
    "수",
    "면적",
    "수",
    "면적",
    "수",
    "면적",
    "수",
    "면적",
  ];
  List<dynamic> thirdRowInt = [0, 0, 0, 0, 1, 37, 1, 37];
  Image kinderImage = Image.asset("name");
  ///어린이집소개 좌측용
  void _callBasicApi() async {
    Map<String, String> headers = Map();
    headers['authorization'] = token;
    final client = RestInfoPanel(dio);
    final responseBasic = await client.getHouseInfo(token).catchError((Object obj) {
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
    Map<String, dynamic> mapResult = Map<String, dynamic>.from(responseBasic);//안해주면 Iteral뭐시기 형태로 데이터가 들어와 Map형식으로 읽을 수 없음
    // print(mapResult["kindergarten"]);
    setState(() {
      kinderImage = Image.network(
        url+mapResult["kindergarten"]["imagePath"],
        headers: headers,
        width: 128.w,
        height: 146.w,
        fit: BoxFit.cover,
      );
      classNumEach = mapResult["kindergarten"]["classCounts"].cast<int>();//원형그래프:각 나이별 학급 수
      classGraphName = mapResult["kindergarten"]["classAges"];//원형그래프:학급수
      childNumEachAge = mapResult["kindergarten"]["childrenCounts"];//원형그래프: 유아수
      //원형그래프 비율 구하기
      for(int i=0;i<classGraphName.length;i++) { //총 학급수 계산
        classNumTotal += classNumEach[i];
      }
      for(int i=0;i<classGraphName.length;i++) { //그래프 비율 계산
        classGraphRate[i] = classNumEach[i] / classNumTotal;
      }
      childrenCountByTeacher =mapResult["kindergarten"]["childrenCountByTeacher"];//교사당 유아수
      childrenCountByClass = mapResult["kindergarten"]["childrenCountByClass"];//학급당 유아수
      firstRowInt[0] =  mapResult["kindergarten"]["classroomCount"];
      firstRowInt[1] =  mapResult["kindergarten"]["classroomArea"];
      firstRowInt[2] =  mapResult["kindergarten"]["indoorgymCount"];
      firstRowInt[3] =  mapResult["kindergarten"]["indoorgymArea"];
      firstRowInt[4] =  mapResult["kindergarten"]["outdoorgymCount"];
      firstRowInt[5] =  mapResult["kindergarten"]["outdoorgymArea"];
      firstRowInt[6] =  mapResult["kindergarten"]["roofgymCount"];
      firstRowInt[7] =  mapResult["kindergarten"]["roofgymArea"];
      firstRowInt[8] =  mapResult["kindergarten"]["neargymCount"];
      firstRowInt[9] =  mapResult["kindergarten"]["neargymArea"];

      secondRowInt[0] =  mapResult["kindergarten"]["healthroomCount"];
      secondRowInt[1] =  mapResult["kindergarten"]["healthroomArea"];
      secondRowInt[2] =  mapResult["kindergarten"]["restroomCount"];
      secondRowInt[3] =  mapResult["kindergarten"]["restroomArea"];
      secondRowInt[4] =  mapResult["kindergarten"]["kitchenCount"];
      secondRowInt[5] =  mapResult["kindergarten"]["kitchenArea"];
      secondRowInt[6] =  mapResult["kindergarten"]["cafeteriaCount"];
      secondRowInt[7] =  mapResult["kindergarten"]["cafeteriaArea"];


      thirdRowInt[0] =  mapResult["kindergarten"]["directorroomCount"];
      thirdRowInt[1] =  mapResult["kindergarten"]["directorroomArea"];
      thirdRowInt[2] =  mapResult["kindergarten"]["teacherroomCount"];
      thirdRowInt[3] =  mapResult["kindergarten"]["teacherroomArea"];
      thirdRowInt[4] =  mapResult["kindergarten"]["counselingroomCount"];
      thirdRowInt[5] =  mapResult["kindergarten"]["counselingroomArea"];
      thirdRowInt[6] =  mapResult["kindergarten"]["otherplaceCount"];
      thirdRowInt[7] =  mapResult["kindergarten"]["otherplaceArea"];

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
    final token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZGVudGlmaWNhdGlvbiI6MjIsInZlcnNpb24iOiIwLjAuNCIsImlhdCI6MTY2NzM2MTY3NCwiZXhwIjoxNjY5OTUzNjc0LCJpc3MiOiJhaWpvYSJ9.GKbcaliPyXkYy5szr_4nJOOpfN-vvigMBt3ufShmgtY';

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
    final token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZGVudGlmaWNhdGlvbiI6MjIsInZlcnNpb24iOiIwLjAuNCIsImlhdCI6MTY2NzM2MTY3NCwiZXhwIjoxNjY5OTUzNjc0LCJpc3MiOiJhaWpvYSJ9.GKbcaliPyXkYy5szr_4nJOOpfN-vvigMBt3ufShmgtY';

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
    print(response);//데이터 뭐가오나 확인
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
  var length;
  @override
  Widget build(BuildContext context) {
    length = weatherType?.length ?? 0; // 리스트 데이터갯수

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
                  height: 1048.w,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///<어린이집 사진
                          Container(
                              width: 400.w,
                              height: 490.w,
                              margin: EdgeInsets.only(left: 34.w, top: 34.w),
                              decoration: BoxDecoration(
                                  // color: Colors.black,
                                  borderRadius: BorderRadius.circular(20.w)),
                              child: kinderImage),

                          ///어린이집 사진>

                          ///<학급수, 유아수 그래프
                          Column(children: [
                            Row(children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 76.w, top: 122.w),
                                    child: Text("학급수",
                                        style: TextStyle(
                                            color: const Color(0xff393838),
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "NotoSansKR",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 16.0.sp),
                                        textAlign: TextAlign.left),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ///<원형그래프:학급수
                                      Container(
                                        width: 279.w,
                                        height: 143.w,
                                        margin: EdgeInsets.only(
                                            left: 40.w, top: 15.w),
                                        child: Row(
                                          children: [
                                            AspectRatio(
                                              aspectRatio: 1,
                                              child: PieChart(
                                                PieChartData(
                                                  borderData: FlBorderData(
                                                    show: false,
                                                  ),
                                                  sectionsSpace: 0,
                                                  centerSpaceRadius: 30.w,
                                                  sections: showingSections(
                                                      classGraphName.length),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Column(
                                                  // mainAxisAlignment: MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    for (int i = 0;
                                                        i <
                                                            classGraphName
                                                                .length;
                                                        i++) ...[
                                                      Row(
                                                        children: [
                                                          Indicator(
                                                              color:
                                                                  classGraphColor[
                                                                      i],
                                                              text:
                                                                  classGraphName[
                                                                      i],
                                                              isSquare: true),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 7.w,
                                                      ),
                                                    ]
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 10.w,
                                                ),
                                                Column(
                                                  // mainAxisAlignment: MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    for (int i = 0;
                                                        i <
                                                            classGraphName
                                                                .length;
                                                        i++) ...[
                                                      Row(
                                                        children: [
                                                          Text(
                                                            classNumEach[i]
                                                                    .toString() +
                                                                '개',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'NotoSansKR',
                                                              color: const Color(
                                                                  0xff393838),
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 7.w,
                                                      ),
                                                    ]
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                      ///원형그래프:학급수>
                                    ],
                                  ),
                                ],
                              ),

                              ///<원형그래프: 유아수
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 40.w, top: 122.w),
                                    child: Text("유아수",
                                        style: TextStyle(
                                            color: const Color(0xff393838),
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "NotoSansKR",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 16.0.sp),
                                        textAlign: TextAlign.left),
                                  ),
                                  Container(
                                    width: 279.w,
                                    height: 143.w,
                                    margin: EdgeInsets.only(top: 15.w),
                                    child: Row(
                                      children: [
                                        AspectRatio(
                                          aspectRatio: 1,
                                          child: PieChart(
                                            PieChartData(
                                              borderData: FlBorderData(
                                                show: false,
                                              ),
                                              sectionsSpace: 0,
                                              centerSpaceRadius: 30.w,
                                              sections: showingSections(
                                                  classGraphName.length),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            for (int i = 0;
                                                i < classGraphName.length;
                                                i++) ...[
                                              Indicator(
                                                  color: classGraphColor[i],
                                                  text: classGraphName[i],
                                                  isSquare: true),
                                              SizedBox(
                                                height: 7.w,
                                              ),
                                            ]
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Column(
                                          // mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            for (int i = 0;
                                                i < classGraphName.length;
                                                i++) ...[
                                              Row(
                                                children: [
                                                  Text(
                                                    childNumEachAge[i]
                                                            .toString() +
                                                        '명',
                                                    style: TextStyle(
                                                      fontFamily: 'NotoSansKR',
                                                      color: const Color(
                                                          0xff393838),
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 7.w,
                                              ),
                                            ]
                                          ],
                                        ),
                                      ],
                                    ),

                                    ///원형그래프:유아수>
                                  ),
                                ],
                              )
                            ]),
                            Container(
                                width: 544.w,
                                height: 150.w,
                                margin: EdgeInsets.only(left: 43.w, top: 30.w),
                                decoration: BoxDecoration(
                                  color: const Color(0xffffffff),
                                  borderRadius: BorderRadius.circular(20.w),
                                  boxShadow: [
                                    BoxShadow(
                                        color: const Color(0x29b1b1b1),
                                        offset: const Offset(-2, 2),
                                        blurRadius: 6.w,
                                        spreadRadius: 0),
                                    BoxShadow(
                                        color: const Color(0x29dbdbdb),
                                        offset: const Offset(-2, -4),
                                        blurRadius: 6.w,
                                        spreadRadius: 0)
                                  ],
                                  border: Border.all(
                                      color: const Color(0x6663e6d7), width: 1),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 93.w, top: 23.w),
                                      child: Text("교사당/학급당 유아수",
                                          style: TextStyle(
                                            fontFamily: 'NotoSansKR',
                                            color: const Color(0xff393838),
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.normal,
                                          )),
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 93.w, top: 20.w),
                                              child: Text("교사당 유아수",
                                                  style: TextStyle(
                                                    fontFamily: 'NotoSansKR',
                                                    color:
                                                        const Color(0xff393838),
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w400,
                                                    fontStyle: FontStyle.normal,
                                                  )),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 93.w, top: 20.w),
                                              child: Text("학급당 유아수",
                                                  style: TextStyle(
                                                    fontFamily: 'NotoSansKR',
                                                    color:
                                                        const Color(0xff393838),
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w400,
                                                    fontStyle: FontStyle.normal,
                                                  )),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 200 * boyrate.w,
                                              height: 20.w,
                                              margin: EdgeInsets.only(
                                                  left: 20.w, top: 20.w),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10.w),
                                                    bottomRight:
                                                        Radius.circular(10.w)),
                                                color: const Color(0xffc7f7f5),
                                              ),
                                            ),
                                            Container(
                                              width: 200 * childrenperteacher.w,
                                              height: 20.w,
                                              margin: EdgeInsets.only(
                                                  left: 20.w, top: 20.w),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10.w),
                                                    bottomRight:
                                                        Radius.circular(10.w)),
                                                color: const Color(0xff39605f),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 40.w, top: 20.w),
                                              child: Text(
                                                  childrenCountByTeacher
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontFamily: 'NotoSansKR',
                                                    color: Color(0xff393838),
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w400,
                                                    fontStyle: FontStyle.normal,
                                                  )),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 40.w, top: 20.w),
                                              child: Text(
                                                  childrenCountByClass
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontFamily: 'NotoSansKR',
                                                    color: Color(0xff393838),
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w400,
                                                    fontStyle: FontStyle.normal,
                                                  )),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                )),
                          ])

                          ///학급수, 유아수 그래프>
                        ],
                      ),

                      ///<첫번째줄
                      Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 200.w,
                                height: 41.w,
                                margin: EdgeInsets.only(left: 39.w, top: 50.w),
                                decoration: BoxDecoration(
                                    color: const Color(0xffeffffe),
                                    border: Border.all(
                                        color: const Color(0x4d63e6d7),
                                        width: 1),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20.w))),
                                child: Center(
                                  child: Text("교실",
                                      style: TextStyle(
                                        fontFamily: 'NotoSansKR',
                                        color: const Color(0xff393838),
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                      )),
                                ),
                              ),
                              Container(
                                width: 784.w,
                                height: 41.w,
                                margin: EdgeInsets.only(top: 50.w),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20.w)),
                                    border: Border.all(
                                        color: const Color(0x4d63e6d7),
                                        width: 1),
                                    color: const Color(0xffeffffe)),
                                child: Center(
                                  child: Text("체육장/놀이터",
                                      style: TextStyle(
                                        fontFamily: 'NotoSansKR',
                                        color: const Color(0xff393838),
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                      )),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 39.w,
                              ),
                              for (int i = 0; i < 2; i++) ...[
                                Container(
                                  width: 100.w,
                                  height: 41.w,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffc7f7f5),
                                    border: Border.all(
                                      color: const Color(0x4d63e6d7),
                                      //width: 0.5.w,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(firstRowStr[i],
                                        style: TextStyle(
                                          fontFamily: 'NotoSansKR',
                                          color: const Color(0xff393838),
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                        )),
                                  ),
                                ),
                              ],
                              for (int i = 2; i < 10; i++) ...[
                                Container(
                                  width: 98.w,
                                  height: 41.w,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffc7f7f5),
                                    border: Border.all(
                                      color: const Color(0x4d63e6d7),
                                      //width: 0.5.w,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(firstRowStr[i],
                                        style: TextStyle(
                                          fontFamily: 'NotoSansKR',
                                          color: const Color(0xff393838),
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                        )),
                                  ),
                                )
                              ]
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 39.w,
                              ),
                              for (int i = 0; i < 2; i++) ...[
                                if (i == 0) ...[
                                  Container(
                                    width: 100.w,
                                    height: 41.w,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffffffff),
                                      border: Border.all(
                                        color: const Color(0x4d63e6d7),
                                        //width: 0.5.w,
                                      ),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(20.w)),
                                    ),
                                    child: Center(
                                      child: Text(firstRowInt[i].toString(),
                                          style: TextStyle(
                                            fontFamily: 'NotoSansKR',
                                            color: const Color(0xff393838),
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                          )),
                                    ),
                                  ),
                                ] else ...[
                                  Container(
                                    width: 100.w,
                                    height: 41.w,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffffffff),
                                      border: Border.all(
                                        color: const Color(0x4d63e6d7),
                                        //width: 0.5.w,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(firstRowInt[i].toString(),
                                          style: TextStyle(
                                            fontFamily: 'NotoSansKR',
                                            color: const Color(0xff393838),
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                          )),
                                    ),
                                  ),
                                ]
                              ],
                              for (int i = 2; i < 10; i++) ...[
                                if (i == 9) ...[
                                  Container(
                                    width: 98.w,
                                    height: 41.w,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffffffff),
                                      border: Border.all(
                                        color: const Color(0x4d63e6d7),
                                        //width: 0.5.w,
                                      ),
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(20.w)),
                                    ),
                                    child: Center(
                                      child: Text(firstRowInt[i].toString(),
                                          style: TextStyle(
                                            fontFamily: 'NotoSansKR',
                                            color: const Color(0xff393838),
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                          )),
                                    ),
                                  )
                                ] else ...[
                                  Container(
                                    width: 98.w,
                                    height: 41.w,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffffffff),
                                      border: Border.all(
                                        color: const Color(0x4d63e6d7),
                                        //width: 0.5.w,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(firstRowInt[i].toString(),
                                          style: TextStyle(
                                            fontFamily: 'NotoSansKR',
                                            color: const Color(0xff393838),
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                          )),
                                    ),
                                  )
                                ]
                              ]
                            ],
                          )
                        ],
                      ),

                      ///첫번째줄>
                      ///
                      /// <두번째줄
                      Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 200.w,
                                height: 41.w,
                                margin: EdgeInsets.only(left: 39.w, top: 30.w),
                                decoration: BoxDecoration(
                                    color: const Color(0xffeffffe),
                                    border: Border.all(
                                        color: const Color(0x4d63e6d7),
                                        width: 1),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20.w))),
                                child: Center(
                                  child: Text("보건실",
                                      style: TextStyle(
                                        fontFamily: 'NotoSansKR',
                                        color: const Color(0xff393838),
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                      )),
                                ),
                              ),
                              Container(
                                width: 261.w,
                                height: 41.w,
                                margin: EdgeInsets.only(top: 30.w),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0x4d63e6d7),
                                        width: 1),
                                    color: const Color(0xffeffffe)),
                                child: Center(
                                  child: Text("위생시설(목욕실/화장실)",
                                      style: TextStyle(
                                        fontFamily: 'NotoSansKR',
                                        color: const Color(0xff393838),
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                      )),
                                ),
                              ),
                              Container(
                                width: 263.w,
                                height: 41.w,
                                margin: EdgeInsets.only(top: 30.w),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0x4d63e6d7),
                                        width: 1),
                                    color: const Color(0xffeffffe)),
                                child: Center(
                                  child: Text("조리실",
                                      style: TextStyle(
                                        fontFamily: 'NotoSansKR',
                                        color: const Color(0xff393838),
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                      )),
                                ),
                              ),
                              Container(
                                width: 262.w,
                                height: 41.w,
                                margin: EdgeInsets.only(top: 30.w),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20.w)),
                                    border: Border.all(
                                        color: const Color(0x4d63e6d7),
                                        width: 1),
                                    color: const Color(0xffeffffe)),
                                child: Center(
                                  child: Text("급식실",
                                      style: TextStyle(
                                        fontFamily: 'NotoSansKR',
                                        color: const Color(0xff393838),
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                      )),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 39.w,
                              ),
                              for (int i = 0; i < 2; i++) ...[
                                Container(
                                  width: 100.w,
                                  height: 41.w,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffc7f7f5),
                                    border: Border.all(
                                      color: const Color(0x4d63e6d7),
                                      //width: 0.5.w,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(secondRowStr[i],
                                        style: TextStyle(
                                          fontFamily: 'NotoSansKR',
                                          color: const Color(0xff393838),
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                        )),
                                  ),
                                ),
                              ],
                              for (int i = 2; i < 8; i++) ...[
                                Container(
                                  width: 131.w,
                                  height: 41.w,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffc7f7f5),
                                    border: Border.all(
                                      color: const Color(0x4d63e6d7),
                                      //width: 0.5.w,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(secondRowStr[i],
                                        style: TextStyle(
                                          fontFamily: 'NotoSansKR',
                                          color: const Color(0xff393838),
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                        )),
                                  ),
                                )
                              ]
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 39.w,
                              ),
                              for (int i = 0; i < 2; i++) ...[
                                if (i == 0) ...[
                                  Container(
                                    width: 100.w,
                                    height: 41.w,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffffffff),
                                      border: Border.all(
                                        color: const Color(0x4d63e6d7),
                                        //width: 0.5.w,
                                      ),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(20.w)),
                                    ),
                                    child: Center(
                                      child: Text(secondRowInt[i].toString(),
                                          style: TextStyle(
                                            fontFamily: 'NotoSansKR',
                                            color: const Color(0xff393838),
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                          )),
                                    ),
                                  ),
                                ] else ...[
                                  Container(
                                    width: 100.w,
                                    height: 41.w,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffffffff),
                                      border: Border.all(
                                        color: const Color(0x4d63e6d7),
                                        //width: 0.5.w,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(secondRowInt[i].toString(),
                                          style: TextStyle(
                                            fontFamily: 'NotoSansKR',
                                            color: const Color(0xff393838),
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                          )),
                                    ),
                                  ),
                                ]
                              ],
                              for (int i = 2; i < 8; i++) ...[
                                if (i == 7) ...[
                                  Container(
                                    width: 131.w,
                                    height: 41.w,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffffffff),
                                      border: Border.all(
                                        color: const Color(0x4d63e6d7),
                                        //width: 0.5.w,
                                      ),
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(20.w)),
                                    ),
                                    child: Center(
                                      child: Text(secondRowInt[i].toString(),
                                          style: TextStyle(
                                            fontFamily: 'NotoSansKR',
                                            color: const Color(0xff393838),
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                          )),
                                    ),
                                  )
                                ] else ...[
                                  Container(
                                    width: 131.w,
                                    height: 41.w,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffffffff),
                                      border: Border.all(
                                        color: const Color(0x4d63e6d7),
                                        //width: 0.5.w,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(secondRowInt[i].toString(),
                                          style: TextStyle(
                                            fontFamily: 'NotoSansKR',
                                            color: const Color(0xff393838),
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                          )),
                                    ),
                                  )
                                ]
                              ]
                            ],
                          )
                        ],
                      ),

                      /// 두번째줄>
                      ///
                      /// <세번째줄
                      Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 200.w,
                                height: 41.w,
                                margin: EdgeInsets.only(left: 39.w, top: 30.w),
                                decoration: BoxDecoration(
                                    color: const Color(0xffeffffe),
                                    border: Border.all(
                                        color: const Color(0x4d63e6d7),
                                        width: 1),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20.w))),
                                child: Center(
                                  child: Text("원장실",
                                      style: TextStyle(
                                        fontFamily: 'NotoSansKR',
                                        color: const Color(0xff393838),
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                      )),
                                ),
                              ),
                              Container(
                                width: 261.w,
                                height: 41.w,
                                margin: EdgeInsets.only(top: 30.w),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0x4d63e6d7),
                                        width: 1),
                                    color: const Color(0xffeffffe)),
                                child: Center(
                                  child: Text("교사실",
                                      style: TextStyle(
                                        fontFamily: 'NotoSansKR',
                                        color: const Color(0xff393838),
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                      )),
                                ),
                              ),
                              Container(
                                width: 263.w,
                                height: 41.w,
                                margin: EdgeInsets.only(top: 30.w),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0x4d63e6d7),
                                        width: 1),
                                    color: const Color(0xffeffffe)),
                                child: Center(
                                  child: Text("상담실",
                                      style: TextStyle(
                                        fontFamily: 'NotoSansKR',
                                        color: const Color(0xff393838),
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                      )),
                                ),
                              ),
                              Container(
                                width: 262.w,
                                height: 41.w,
                                margin: EdgeInsets.only(top: 30.w),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20.w)),
                                    border: Border.all(
                                        color: const Color(0x4d63e6d7),
                                        width: 1),
                                    color: const Color(0xffeffffe)),
                                child: Center(
                                  child: Text("기타공간",
                                      style: TextStyle(
                                        fontFamily: 'NotoSansKR',
                                        color: const Color(0xff393838),
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                      )),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 39.w,
                              ),
                              for (int i = 0; i < 2; i++) ...[
                                Container(
                                  width: 100.w,
                                  height: 41.w,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffc7f7f5),
                                    border: Border.all(
                                      color: const Color(0x4d63e6d7),
                                      //width: 0.5.w,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(thirdRowStr[i],
                                        style: TextStyle(
                                          fontFamily: 'NotoSansKR',
                                          color: const Color(0xff393838),
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                        )),
                                  ),
                                ),
                              ],
                              for (int i = 2; i < 8; i++) ...[
                                Container(
                                  width: 131.w,
                                  height: 41.w,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffc7f7f5),
                                    border: Border.all(
                                      color: const Color(0x4d63e6d7),
                                      //width: 0.5.w,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(thirdRowStr[i],
                                        style: TextStyle(
                                          fontFamily: 'NotoSansKR',
                                          color: const Color(0xff393838),
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                        )),
                                  ),
                                )
                              ]
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 39.w,
                              ),
                              for (int i = 0; i < 2; i++) ...[
                                if (i == 0) ...[
                                  Container(
                                    width: 100.w,
                                    height: 41.w,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffffffff),
                                      border: Border.all(
                                        color: const Color(0x4d63e6d7),
                                        //width: 0.5.w,
                                      ),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(20.w)),
                                    ),
                                    child: Center(
                                      child: Text(thirdRowInt[i].toString(),
                                          style: TextStyle(
                                            fontFamily: 'NotoSansKR',
                                            color: const Color(0xff393838),
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                          )),
                                    ),
                                  ),
                                ] else ...[
                                  Container(
                                    width: 100.w,
                                    height: 41.w,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffffffff),
                                      border: Border.all(
                                        color: const Color(0x4d63e6d7),
                                        //width: 0.5.w,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(thirdRowInt[i].toString(),
                                          style: TextStyle(
                                            fontFamily: 'NotoSansKR',
                                            color: const Color(0xff393838),
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                          )),
                                    ),
                                  ),
                                ]
                              ],
                              for (int i = 2; i < 8; i++) ...[
                                if (i == 7) ...[
                                  Container(
                                    width: 131.w,
                                    height: 41.w,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffffffff),
                                      border: Border.all(
                                        color: const Color(0x4d63e6d7),
                                        //width: 0.5.w,
                                      ),
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(20.w)),
                                    ),
                                    child: Center(
                                      child: Text(thirdRowInt[i].toString(),
                                          style: TextStyle(
                                            fontFamily: 'NotoSansKR',
                                            color: const Color(0xff393838),
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                          )),
                                    ),
                                  )
                                ] else ...[
                                  Container(
                                    width: 131.w,
                                    height: 41.w,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffffffff),
                                      border: Border.all(
                                        color: const Color(0x4d63e6d7),
                                        //width: 0.5.w,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(thirdRowInt[i].toString(),
                                          style: TextStyle(
                                            fontFamily: 'NotoSansKR',
                                            color: const Color(0xff393838),
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                          )),
                                    ),
                                  )
                                ]
                              ]
                            ],
                          )
                        ],
                      ),

                      /// 세번째줄>
                      ///
                      /// 각종 차트들>
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
                                Text(childClassName[i].toString(),
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
                        width: 24.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(sensorTemperature.toString()+"도",
                                style: TextStyle(
                                  fontFamily: 'GamjaFlower',
                                  color: const Color(0xff42372c),
                                  fontSize: 35.sp,
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
                                  fontSize: 35.sp,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                )),
                            margin: EdgeInsets.only(top: 45.w),
                          ),
                          Container(
                            child: Text(sensorPm10.toString()+"㎍/㎥",
                                style: TextStyle(
                                  fontFamily: 'GamjaFlower',
                                  color: const Color(0xff42372c),
                                  fontSize: 35.sp,
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
                                  fontSize: 35.sp,
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
                                  fontSize: 35.sp,
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


  /// 원형그래프
  List<PieChartSectionData> showingSections(int num) {
    return List.generate(num, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0.sp : 16.0.sp;
      final radius = isTouched ? 60.0.w : 20.0.w; //그래프 테두리 두깨
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xffc7f7f5),
            value: classGraphRate[0],
            radius: radius,
            titleStyle: const TextStyle(
              //강제로 fontSize: 0 지정해줘야 숫자 안뜸
              fontSize: 0,
              fontWeight: FontWeight.bold,
              color: Color(0xffffffff),
            ),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xffc6d0f4),
            value: classGraphRate[1],
            radius: radius,
            titleStyle: const TextStyle(
              fontSize: 0,
              fontWeight: FontWeight.bold,
              color: Color(0xffffffff),
            ),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xfff4dac5),
            value: classGraphRate[2],
            radius: radius,
            titleStyle: const TextStyle(
              fontSize: 0,
              fontWeight: FontWeight.bold,
              color: Color(0xffffffff),
            ),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xfff4f4c6),
            value: classGraphRate[3],
            title: '15%',
            radius: radius,
            titleStyle: const TextStyle(
              fontSize: 0,
              fontWeight: FontWeight.bold,
              color: Color(0xffffffff),
            ),
          );
        case 4:
          return PieChartSectionData(
            color: const Color(0xfff4c6ed),
            value: classGraphRate[4],
            radius: radius,
            titleStyle: const TextStyle(
              fontSize: 0,
              fontWeight: FontWeight.bold,
              color: Color(0xffffffff),
            ),
          );
        default:
          throw Error();
      }
    });
  }

  ///
}

class Indicator extends StatelessWidget {
  final Color color;
  final Color textColor;
  final String text;
  final bool isSquare;
  final double size;

  const Indicator({
    Key? key,
    required this.color,
    this.textColor = Colors.white,
    required this.text,
    required this.isSquare,
    this.size = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size.w,
          height: size.w,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Text(
          text,
          style: TextStyle(
            color: const Color(0xff393838),
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontFamily: "NotoSansKR",
          ),
        )
      ],
    );
  }
}
