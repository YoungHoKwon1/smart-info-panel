import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:smart_info_panel/classinfo20.dart';
import 'package:smart_info_panel/facetime.dart';
import 'package:smart_info_panel/notice.dart';
import 'package:smart_info_panel/provider/attendance_data.dart';
import 'package:smart_info_panel/widgets/childlifedata_widget.dart';
import 'package:smart_info_panel/widgets/facetime_widget.dart';
import 'package:smart_info_panel/widgets/classinfo10_widget.dart';
import 'package:smart_info_panel/widgets/classinfo30_widget.dart';
import 'package:smart_info_panel/widgets/classinfo20_widget.dart';
import 'package:smart_info_panel/widgets/kinder_info_widget.dart';
import 'package:smart_info_panel/widgets/notice_widget.dart';
import 'package:smart_info_panel/widgets/teacher_info_widget.dart';
import 'package:smart_info_panel/widgets/test_notice_widget.dart';



import 'api/infopanel.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import 'kinder_info_3.dart';

//왠지는
class MainPanel extends StatefulWidget {
  const MainPanel({Key? key}) : super(key: key);

  @override
  State<MainPanel> createState() => _MainPanelState();
}
class _MainPanelState extends State<MainPanel> {

  //글씨색
  List<Color> weatherFontColor = [Color(0xffc45d1a), Color(0xff139894), Color(0xff7c546c), Color(0xff04acd1), Color(0xff1864a), Color(0xff5529a2),Color(0xffa27258)];
  List<Color> weatherDataFontColor = [Color(0xff42372c), Color(0xff39605f), Color(0xffffffff), Color(0xff2d3a44), Color(0xff2f3846), Color(0xffffffff), Color(0xfff45f1e)];
  //(해/구름),(바람),(눈/비),(구름),(비),(눈),(맑음)

  Color weatherFontColorReal = Color(0xffc45d1a);
  Color weatherDataFontColorReal = Color(0xffc45d1a);

  @override
  void initState() {
    super.initState();
    _callEnvApi();
  }

  Dio dio = Dio();

  String url = "http://tmap.aijoa.us:48764/";
  final token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZGVudGlmaWNhdGlvbiI6MjIsInZlcnNpb24iOiIwLjAuNCIsImlhdCI6MTY2NzM2MTY3NCwiZXhwIjoxNjY5OTUzNjc0LCJpc3MiOiJhaWpvYSJ9.GKbcaliPyXkYy5szr_4nJOOpfN-vvigMBt3ufShmgtY';


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
    // print(response);//데이터 뭐가오나 확인
    Map<String, dynamic> mapResult = Map<String, dynamic>.from(response);//안해주면 Iteral뭐시기 형태로 데이터가 들어와 Map형식으로 읽을 수 없음
    setState(() {
      weatherTemperature =  mapResult["weatherTemperature"];
      weatherType =  mapResult["weatherType"];
      switch(weatherType) {
        case "구름" :
          weather_assets = 'assets/airple_weather/cloudy.jpg';
          weatherFontColorReal = weatherFontColor[3];
          weatherDataFontColorReal = weatherDataFontColor[3];
          break;
        case "비" :
          weather_assets = 'assets/airple_weather/rain_only.jpg';
          weatherFontColorReal = weatherFontColor[4];
          weatherDataFontColorReal = weatherDataFontColor[4];
          break;
        case "눈" :
          weather_assets = 'assets/airple_weather/snow_only.jpg';
          weatherFontColorReal = weatherFontColor[5];
          weatherDataFontColorReal = weatherDataFontColor[5];
          break;
        case "눈/비" :
          weather_assets = 'assets/airple_weather/snow_rain.jpg';
          weatherFontColorReal = weatherFontColor[2];
          weatherDataFontColorReal = weatherDataFontColor[2];
          break;
        case "맑음" :
          weather_assets = 'assets/airple_weather/sunny.jpg';
          weatherFontColorReal = weatherFontColor[6];
          weatherDataFontColorReal = weatherDataFontColor[6];
          break;
        case "바람" :
          weather_assets = 'assets/airple_weather/wind.jpg';
          weatherFontColor = [weatherFontColor][1];
          weatherDataFontColor = [weatherDataFontColor][1];
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

                ///<각 페이지의 왼쪽 위젯이 들어갈 자리입니다, widgetleft
                child: KinderInfoWidget(),
                // TeacherInfoWidget()
                // ClassInfo10Widget(),
                // ClassInfo20Widget(),
                //ClassInfo30Widget(),
                // ChildLifeDataWidget(),
                //FacetimeWidget()
                // NoticeWidget()
                ///각 페이지의 왼쪽 위젯이 들어갈 자리입니다>
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

                  ),
                  ///<각 페이지의 왼쪽 위젯이 들어갈 자리입니다, widgetleft
                  child:
                    //Notice(),


                    //FacetimeWidget(),
                    //NoticeWidget(),
                    //ClassInfo30Widget(),
                      //ClassInfo20Widget(),
                     //ChildLifeDataWidget(),
                     //ChildLifeDataWidget(),
                  //TestNoticeWidget(),



                   ClassInfo10Widget(),
                  //  ClassInfo30Widget(),
                  // ChildLifeDataWidget(),

                  // KinderInfoWidget(),

                  //  TeacherInfoWidget()
                  //NoticeWidget()

                  ///각 페이지의 왼쪽 위젯이 들어갈 자리입니다>
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
                              width: 336.w,
                              height: 20.w,
                              margin: EdgeInsets.only(left: 40.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Color(0x4d63e66d),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x33adadad),
                                    offset: Offset(1, 1),
                                    blurRadius: 1,
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                              child: Container(
                                width: 336 *
                                    context
                                        .watch<AttendanceDataProvider>()
                                        .boyrate
                                        .w,
                                height: 20.w,
                                margin: EdgeInsets.only(right:(336-336*context.watch<AttendanceDataProvider>().boyrate).w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18.w),
                                  color: const Color(0x4d63e66d),
                                ),
                                child: Text(
                                  (100 *
                                      context
                                          .watch<AttendanceDataProvider>()
                                          .boyrate)
                                      .toString() +
                                      "%",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Color(0xFF393838),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "NotoSansKR",
                                    fontStyle: FontStyle.normal,
                                  ),
                                  textAlign: TextAlign.right,

                                ),
                              )
                              //남아
                            )],
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
                              width: 336.w,
                              height: 20.w,
                              margin: EdgeInsets.only(left: 20.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Color(0x4de66363),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x33adadad),
                                    offset: Offset(1, 1),
                                    blurRadius: 1,
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                              child: Container(
                                // width: 336.w,
                                height: 20.w,
                                margin: EdgeInsets.only(right:(336-336*context.watch<AttendanceDataProvider>().girlrate).w),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18.w),
                                    color: const Color(0xffffc9c9)),
                                child: Text(
                                  (100 *
                                      context
                                          .watch<AttendanceDataProvider>()
                                          .girlrate)
                                      .toString() +
                                      "%",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Color(0xFF393838),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "NotoSansKR",
                                    fontStyle: FontStyle.normal,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              )
    )],
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
                              for (int i = 0;
                                  i <
                                      context
                                          .watch<AttendanceDataProvider>()
                                          .chartRate
                                          .length;
                                  i++) ...[
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(bottom: 2.w),
                                        child: Text(
                                            (100.0 *
                                                        context
                                                            .watch<
                                                                AttendanceDataProvider>()
                                                            .chartRate[i])
                                                    .toString() +
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
                                          height: 135.0 *
                                              context
                                                  .watch<
                                                      AttendanceDataProvider>()
                                                  .chartRate[i]
                                                  .w,
                                          decoration: BoxDecoration(
                                            color: Color(0xffc7f7f5),
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(10.w),
                                                topLeft: Radius.circular(10.w)),
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
                            for (int i = 0;
                                i <
                                    context
                                        .watch<AttendanceDataProvider>()
                                        .chartRate
                                        .length;
                                i++) ...[
                              Text(
                                  context
                                      .watch<AttendanceDataProvider>()
                                      .childClassName[i]
                                      .toString(),
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
                                  color: weatherFontColorReal,
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
                                  color: weatherFontColorReal,
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
                                  color: weatherFontColorReal,
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
                                  color: weatherFontColorReal,
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
                                  color: weatherFontColorReal,
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
                                  color: weatherDataFontColorReal,
                                  fontSize: 40.sp,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                )),
                            margin: EdgeInsets.only(top: 50.w, left: 5.w),
                          ),
                          Container(
                            child: Text(sensorHumidity.toString()+"%",
                                style: TextStyle(
                                  fontFamily: 'GamjaFlower',
                                  color: weatherDataFontColorReal,
                                  fontSize: 40.sp,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                )),
                            margin: EdgeInsets.only(top: 40.w, left: 5.w),
                          ),
                          Container(
                            child: RichText(
                                text: TextSpan(
                                    children: [
                                      TextSpan(text: sensorPm10.toString(),
                                        style: TextStyle(fontFamily: 'GamjaFlower',
                                        color: weatherDataFontColorReal,
                                        fontSize: 30.sp,
                                        fontWeight: FontWeight.w400)
                                      ),
                                      TextSpan(text: '㎍/㎥',
                                          style: TextStyle(fontFamily: 'GamjaFlower',
                                            color: weatherDataFontColorReal,fontSize: 20.sp,
                                            fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,)),
                                    ])
                            ),
                            margin: EdgeInsets.only(top: 50.w, left: 5.w),
                          ),
                          Container(
                            child: RichText(
                                text: TextSpan(
                                    children: [
                                      TextSpan(text: sensorCo2.toString(),
                                          style: TextStyle(fontFamily: 'GamjaFlower',
                                              color: weatherDataFontColorReal,
                                              fontSize: 30.sp,
                                              fontWeight: FontWeight.w400)
                                      ),
                                      TextSpan(text: 'ppm',
                                          style: TextStyle(fontFamily: 'GamjaFlower',
                                            color: weatherDataFontColorReal,fontSize: 25.sp,
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,)),
                                    ])
                            ),
                            margin: EdgeInsets.only(top: 55.w, left: 12.w),
                          ),
                          Container(
                            child: RichText(
                                text: TextSpan(
                                    children: [
                                      TextSpan(text: sensorPm25.toString(),
                                          style: TextStyle(fontFamily: 'GamjaFlower',
                                              color: weatherDataFontColorReal,
                                              fontSize: 30.sp,
                                              fontWeight: FontWeight.w400)
                                      ),
                                      TextSpan(text: '㎍/㎥',
                                          style: TextStyle(fontFamily: 'GamjaFlower',
                                            color: weatherDataFontColorReal,fontSize: 20.sp,
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,)),
                                    ])
                            ),
                            margin: EdgeInsets.only(top: 50.w, left: 5.w),
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


