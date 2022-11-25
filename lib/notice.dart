import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'api/infopanel.dart';


//왠지는
class Notice extends StatefulWidget {
  const Notice({Key? key}) : super(key: key);

  @override
  State<Notice> createState() => _NoticeState();
}

class _NoticeState extends State<Notice> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {});

    _callBasicApi();
    _callEnvApi();
    _callAttendApi();
  }

  Dio dio = Dio();
  String url = "http://tmap.aijoa.us:48764/";
  final token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZGVudGlmaWNhdGlvbiI6MjIsInZlcnNpb24iOiIwLjAuNCIsImlhdCI6MTY2NzM2MTY3NCwiZXhwIjoxNjY5OTUzNjc0LCJpc3MiOiJhaWpvYSJ9.GKbcaliPyXkYy5szr_4nJOOpfN-vvigMBt3ufShmgtY';

  String news = '이번달 행사';
  String today = '오늘의 소식';
  int eventNum = 0;
  int months = 0;
  int weeks = 0;
  int row=0;
  int column = 4;
  int rest=0;
  int newImageNum = 0;
  List<String> childrenImagePath = [];
  String weekinfo = '';
  String NewsComment = '';
  List<String> event2 = [];
  String className = '새싹어린이반';
  int teacherNum = 0;
  List<String> teacherName = ['김담임', '김담임', '김담임'];
  List<String> teacherImagePath = [];
  List<Image> teacherImage = [];
  List<Image> imageList = [];
  List<String> childrenName = [
    '','','','','','','',
    '','','','','','','',
    '','','','','','','',
    '','','','','','','',
  ];

  List<Image> childrenImage = [];
  int childNum = 0;

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
    //print(month);
    Map<String, dynamic> mapResult = Map<String, dynamic>.from(responseBasic);//안해주면 Iteral뭐시기 형태로 데이터가 들어와 Map형식으로 읽을 수 없음
    // print("basic:  "+mapResult["classInfo"].toString());
    print(mapResult);//학급이벤트
    // print(mapResult["classInfo"]);//학급소개왼쪽
    //print(mapResult["classInfo"][0]);
    setState(() {
      weeks = mapResult["news"]["week"];
      months= mapResult["news"]["month"];
      weekinfo = mapResult["news"]["weekNews"];
      NewsComment = mapResult["news"]["weekNewsComment"];
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
      }

      childNum = mapResult["classInfo"][0]["children"].length;
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

      // print("row: " +row.toString());
      // print("childNum: " +childNum.toString());
      // print("column: " +column.toString());
      row = newImageNum ~/ column;
      rest = newImageNum % column;
    });
  }



  double boyrate = 0.5;
  double girlrate = 0.78;

  int childHeadCount = 8;
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
    // print(responseAttend);//데이터 뭐가오나 확인
    Map<String, dynamic> mapResult = Map<String, dynamic>.from(responseAttend);//안해주면 Iteral뭐시기 형태로 데이터가 들어와 Map형식으로 읽을 수 없음
    setState(() {
      boyrate = mapResult["maleRate"];//
      girlrate = mapResult["femaleRate"];
      childClassName = mapResult["classList"];
      chartRate = mapResult["rateByClass"].cast<double>();
    });
  }
  List<String> imagePaths = [
    "api/image/뒷산사진1.png",
    "api/image/뒷산사진2.png",
  ];
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
                height: 891.w,
                margin: EdgeInsets.only(left: 18.w, top: 16.w),
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
                child:
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 480.w,
                          height: 300.w,
                          margin: EdgeInsets.only(left: 32.w, top: 32.w),
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
                          child:Row(
                            children: [
                              Column(
                                crossAxisAlignment : CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(left: 27.w, top: 29.w),
                                      child: Text(news,
                                          style: TextStyle(
                                            fontFamily:'NotSanaKR',
                                            color: const Color(0xff898989),
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.normal,
                                          ))
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(left: 27.w, top: 30.w),
                                      child: Text(months.toString() +'월'+weeks.toString()+'주 아이좋아 어린이집 주요행사',
                                          style: TextStyle(
                                            fontFamily:'NotSanaKR',
                                            color: const Color(0xff39605f),
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.normal,
                                          ))
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(left: 27.w, top: 15.w),
                                      child: Text(weekinfo,
                                          style: TextStyle(
                                            fontFamily:'NotSanaKR',
                                            color: const Color(0xff39605f),
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.normal,
                                          ))
                                  ),

                                  Container(
                                      width: 200,
                                      margin: EdgeInsets.only(left: 27.w, top: 20.w),
                                      child: Row(
                                        children: [
                                          Flexible(
                                              child: Text(NewsComment,
                                                overflow:  TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: TextStyle(
                                                  fontFamily:'NotSanaKR',
                                                  color: const Color(0xff000000),
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle: FontStyle.normal,
                                                )
                                              )),
                                        ],
                                      )
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: 480.w,
                          height: 300.w,
                          margin: EdgeInsets.only(left: 22.w, top: 32.w),
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
                          child:Row(
                            children: [
                              Column(
                                crossAxisAlignment : CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(left: 27.w, top: 29.w),
                                      child: Text(today,
                                          style: TextStyle(
                                            fontFamily:'NotSanaKR',
                                            color: const Color(0xff898989),
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.normal,
                                          ))
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(left: 27.w, top: 65.w),
                                          child: Text("오늘은",
                                              style: TextStyle(
                                                fontFamily:'GamjaFlower',
                                                color: const Color(0xff39605f),
                                                fontSize: 30.sp,
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal,
                                              ))
                                      ),
                                      Container(
                                        width: 70.w,
                                        height: 70.w,
                                        margin: EdgeInsets.only(left: 20.w, top: 40.w),
                                        child: const Center(
                                          child: Image(
                                              image: AssetImage(
                                                  'assets/childlifedata/baby_sample.png')),
                                        ),
                                      ),
                                      Container(
                                        width: 70.w,
                                        height: 70.w,
                                        margin: EdgeInsets.only(left: 19.w, top: 40.w),
                                        child: const Center(
                                          child: Image(
                                              image: AssetImage(
                                                  'assets/childlifedata/baby_sample.png')),
                                        ),
                                      ),
                                      Container(
                                        width: 70.w,
                                        height: 70.w,
                                        margin: EdgeInsets.only(left: 19.w, top: 40.w),
                                        child: const Center(
                                          child: Image(
                                              image: AssetImage(
                                                  'assets/childlifedata/baby_sample.png')),
                                        ),
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(left: 24.w, top: 65.w),
                                          child: Text("생일!",
                                              style: TextStyle(
                                                fontFamily:'GamjaFlower',
                                                color: const Color(0xff39605f),
                                                fontSize: 30.sp,
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal,
                                              ))
                                      ),
                                    ],
                                  ),
                                  Row(
                                      children: [
                                        Container(
                                            margin: EdgeInsets.only(left: 130.w, top: 10.w),
                                            child: Text("김아가",
                                                style: TextStyle(
                                                  fontFamily:'GamjaFlower',
                                                  color: const Color(0xff39605f),
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.normal,
                                                ))
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(left: 41.w, top: 10.w),
                                            child: Text("박모세",
                                                style: TextStyle(
                                                  fontFamily:'GamjaFlower',
                                                  color: const Color(0xff39605f),
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.normal,
                                                ))
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(left: 41.w, top: 10.w),
                                            child: Text("이자랑",
                                                style: TextStyle(
                                                  fontFamily:'GamjaFlower',
                                                  color: const Color(0xff39605f),
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.normal,
                                                ))
                                        ),
                                      ]
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(left: 20.w, top: 30.w),
                                      child: Text("친구한테 생일축하한다고 말해주세요!(등의 한마디)",
                                          style: TextStyle(
                                            fontFamily:'NotSanaKR',
                                            color: const Color(0xff000000),
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.normal,
                                          ))
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 50.w, top: 50.w),
                        child: Text("행사제목 (날짜)",
                            style: TextStyle(
                              fontFamily:'NotSanaKR',
                              color: const Color(0xff39605f),
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                            ))
                    ),
                    for(int i=0;i<row;i++)...[
                      Row(
                          children: [
                            for(int j=0;j<column;j++)...[
                              Column(
                                children: [
                                  if(j==0)...[
                                    Container(
                                      width: 200.w,
                                      height: 200.w,
                                      margin: EdgeInsets.only(left: 60.w, top:10.w),
                                      child: imageList[column*i+j],
                                    )
                                  ]else ...[
                                    Container(
                                      width: 200.w,
                                      height: 200.w,
                                      margin: EdgeInsets.only(left: 20.w, top: 20.w),
                                      child: Center(
                                          child: imageList[column*i+j]
                                      ),
                                    )
                                  ],
                                ],
                              )

                            ]]),
                    ],
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 1047.w,
                    height: 97.w,
                    margin: EdgeInsets.only(left: 22.w, top: 33.w),
                    decoration: BoxDecoration(
                        color: const Color(0xff707070),
                        border:Border.all(
                          color: const Color(0xffffffff),
                          width: 1.w,
                        )
                    ),
                  )
                ],
              )
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
///wntjr