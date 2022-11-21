import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:smart_info_panel/api/infopanel.dart';
import 'dart:async';

class ClassInfo30Widget extends StatefulWidget {
  const ClassInfo30Widget({Key? key}) : super(key: key);

  @override
  State<ClassInfo30Widget> createState() => _ClassInfo30WidgetState();
}

class _ClassInfo30WidgetState extends State<ClassInfo30Widget> {
  void initState() {
    super.initState();
    _callBasicApi();
    _callEnvApi();
    _callAttendApi();
  }
  //swagger 참조
  //http://tmap.aijoa.us:48764/api-airple/#/infopanel/get_api_infopanel
  Dio dio = Dio();
  String url = "http://tmap.aijoa.us:48764/";
  final token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZGVudGlmaWNhdGlvbiI6MjIsInZlcnNpb24iOiIwLjAuNCIsImlhdCI6MTY2NzM2MTY3NCwiZXhwIjoxNjY5OTUzNjc0LCJpc3MiOiJhaWpvYSJ9.GKbcaliPyXkYy5szr_4nJOOpfN-vvigMBt3ufShmgtY';

  int childNum = 0;
  int column = 7;
  int row=0;
  int rest=0; //나머지 아이들
  String className = '새싹어린이반';
  int teacherNum = 0;
  List<String> teacherName = ['김담임', '김담임', '김담임'];
  List<String> teacherImagePath = [];
  List<Image> teacherImage = [];
  List<String> childrenName = [
    '','','','','','','',
    '','','','','','','',
    '','','','','','','',
    '','','','','','','',
  ];
  List<String> childrenImagePath = [];
  List<Image> childrenImage = [];
  //반 나이, 총 인원, 남아 수, 여아 수 순서
  List<int> classInfo =[0,0,0,0];
  ///학급소개페이지, 어린이집 소개, 학급공지 페이지  api
  void _callBasicApi() async {
    final client = RestInfoPanel(dio);
    Map<String, String> headers = Map();
    headers['authorization'] = token;
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
    // print("basic:  "+mapResult["classInfo"].toString());
    // print(mapResult["committees"]);//학급이벤트
    // print(mapResult["classInfo"]);//학급소개왼쪽
    // print(mapResult["classInfo"][0]);
    setState(() {
      className = mapResult["classInfo"][0]["name"];
      className = mapResult["classInfo"][0]["name"];
      teacherNum = mapResult["classInfo"][0]["teachers"].length;
      for(int i=0;i<teacherNum;i++) {
        teacherName[i] = mapResult["classInfo"][0]["teachers"][i]["name"];
        // teacherImagePath.add(mapResult["classInfo"][0]["teachers"][i]["imagePath"]);

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
      classInfo[1] = childNum;
      childrenName.clear();
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
      // print("row: " +row.toString());
      // print("childNum: " +childNum.toString());
      // print("column: " +column.toString());
      for(int i=0;i<childNum;i++) {
        if(mapResult["classInfo"][0]["children"][i]["sex"] == true) {
          classInfo[2]++;//남+1
        } else {
          classInfo[3]++;//여+1
        }
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
  ///등하원 api
  void _callAttendApi() async {
    final client = RestInfoPanel(dio);
    final responseAttend = await client.getAttendInfo(token).catchError((Object obj) {
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
    print(responseAttend);//데이터 뭐가오나 확인
    Map<String, dynamic> mapResult = Map<String, dynamic>.from(responseAttend);//안해주면 Iteral뭐시기 형태로 데이터가 들어와 Map형식으로 읽을 수 없음
      boyrate = mapResult["maleRate"];//
      girlrate = mapResult["femaleRate"];
      childClassName = mapResult["classList"];
      chartRate = mapResult["rateByClass"].cast<double>();
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
      weatherTemperature =  mapResult["weatherTemperature"];
      weatherType =  mapResult["weatherType"];
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
              width: 410.w,
              height: 278.w,
              margin: EdgeInsets.only(left: 43.w, top: 13.w),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                          'assets/class_info_deco/age1class.png'))),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      margin:
                      EdgeInsets.only(left: 40.w, top: 140.w),
                      child: Text(className,
                          style: TextStyle(
                            fontFamily: 'GamjaFlower',
                            color: const Color(0xff39605f),
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          )),
                    ),
                    Container(
                      width: 270.w,
                      height: 40.w,
                      margin: EdgeInsets.only(top: 20.w),
                      decoration: BoxDecoration(
                          color: const Color(0xffc7f7f5),
                          borderRadius:
                          BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          classInfo[0].toString() +
                              '세 | ' +
                              classInfo[1].toString() +
                              '명 | 남:' +
                              classInfo[2].toString() +
                              '명 여:' +
                              classInfo[3].toString() +
                              '명',
                          style: TextStyle(fontSize: 18.sp),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            ///담임
            for (int i = 0; i < teacherNum; i++) ...[
              Column(
                children: [
                  Container(
                      width: 100.w,
                      height: 66.w,
                      //페이지에 따라 마진 조절 바람 건희, 성민
                      margin: EdgeInsets.only(left: 60.w),
                      child: teacherImage[i]),
                  Container(
                    width: 160.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                        color: const Color(0xffc7f7f5),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text(
                        teacherName[i],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontFamily: '.AppleSystemUIFont',
                        ),
                        strutStyle: StrutStyle(
                          fontSize: 18.sp,
                          forceStrutHeight: true,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ]

            ///담임
          ],
        ),

        ///아이들
        for (int i = 0; i < row; i++) ...[
          Row(
            children: [
              for (int j = 0; j < column; j++) ...[
                Column(
                  //사진+이름배치를 위해 column으로 시작
                  children: [
                    if (j == 0) ...[
                      Container(
                          width: 110.w,
                          height: 110.w,
                          margin: EdgeInsets.only(
                              left: 31.w, top: 30.w),
                          child: childrenImage[column * i + j])
                    ] else ...[
                      Container(
                        width: 110.w,
                        height: 110.w,
                        margin: EdgeInsets.only(
                            left: 36.w, top: 30.w),
                        child: Center(
                            child: childrenImage[column * i + j]),
                      )
                    ],
                    Container(
                      width: 116.w,
                      height: 35.w,
                      decoration: BoxDecoration(
                          color: const Color(0xffc7f7f5),
                          borderRadius:
                          BorderRadius.circular(17.5)),
                      margin: EdgeInsets.only(left: 28.w),
                      child: Center(
                        child: Text(childrenName[column * i + j],
                            style: TextStyle(
                              fontFamily: 'NotoSansKR',
                              color: const Color(0xff000000),
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            )),
                      ),
                    )
                  ],
                )
              ]
            ],
          )
        ],

        ///아이들
        ///나머지 아이들
        if (rest != 0) ...[
          Row(
            children: [
              for (int j = 0; j < rest; j++) ...[
                Column(
                  //사진+이름배치를 위해 column으로 시작
                  children: [
                    if (j == 0) ...[
                      Container(
                          width: 110.w,
                          height: 110.w,
                          margin: EdgeInsets.only(
                              left: 31.w, top: 30.w),
                          child: childrenImage[row * column + j])
                    ] else ...[
                      Container(
                          width: 110.w,
                          height: 110.w,
                          margin: EdgeInsets.only(
                              left: 36.w, top: 30.w),
                          child: Center(
                              child: childrenImage[
                              row * column + j]))
                    ],
                    Container(
                      width: 116.w,
                      height: 35.w,
                      decoration: BoxDecoration(
                          color: const Color(0xffc7f7f5),
                          borderRadius:
                          BorderRadius.circular(17.5)),
                      margin: EdgeInsets.only(left: 28.w),
                      child: Center(
                        child:
                        Text(childrenName[row * column + j],
                            style: TextStyle(
                              fontFamily: 'NotoSansKR',
                              color: const Color(0xff000000),
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            )),
                      ),
                    )
                  ],

                  ///나머지 아이들
                )
              ]
            ],
          )
        ]
      ],
    );
  }
}
