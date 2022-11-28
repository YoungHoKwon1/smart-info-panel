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
import 'package:provider/provider.dart';
import '../provider/chlid_life_data.dart';

class ChildLifeDataWidget extends StatefulWidget {
  const ChildLifeDataWidget({Key? key}) : super(key: key);

  @override
  State<ChildLifeDataWidget> createState() => _ChildLifeDataWidgetState();
}

class _ChildLifeDataWidgetState extends State<ChildLifeDataWidget> {
  String url = "http://tmap.aijoa.us:48764/";
  final token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZGVudGlmaWNhdGlvbiI6MjIsInZlcnNpb24iOiIwLjAuNCIsImlhdCI6MTY2NzM2MTY3NCwiZXhwIjoxNjY5OTUzNjc0LCJpc3MiOiJhaWpvYSJ9.GKbcaliPyXkYy5szr_4nJOOpfN-vvigMBt3ufShmgtY';

  Map<String, String> headers = Map();

  void initState() {
    // TODO: implement initState
    super.initState();
    headers['authorization'] = token;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 356.w,
              height: 329.w,
              margin: EdgeInsets.only(left: 249.w, top: 49.w),
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.scaleDown,
                    image: NetworkImage(
                        url + context.watch<ChildLifeProvider>().childImagePath,
                        headers: headers,
                        scale: 13.w)),
              ),
              child: Container(//데코레이션 크기가 전부 조금씩 달라서 일단 모든 데코에 적절히 맞게끔 조정해놨습니다
                margin: EdgeInsets.only(right: 23.w, bottom: 30.w),
                  child: Image.asset(
                      // 'assets/child_face_deco/age5face.png',
                      context.watch<ChildLifeProvider>().childlifeDeco,
                    fit: BoxFit.cover,
                  )),
            ),
            // AssetImage(
            //     'assets/child_face_deco/age0face.png'),
            ///아이정보
            Center(
              child: Container(
                  width: 200.w,
                  height: 254.w,
                  margin: EdgeInsets.only(left: 5.w, top: 80.w),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // context.watch<ChildLifeProvider>().bdayYear + "년 " + context.watch<ChildLifeProvider>().bdayMonth + "월 " + context.watch<ChildLifeProvider>().bdayDay + "일" + "\n" +
                      //     context.watch<ChildLifeProvider>().className + "\n" +
                      //     context.watch<ChildLifeProvider>().collectionPeriod + "개월",
                      Text(context.watch<ChildLifeProvider>().childName + "\n",
                          style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            color: const Color(0xff39605f),
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                          )),
                      Text(
                          context.watch<ChildLifeProvider>().bdayYear +
                              "년 " +
                              context.watch<ChildLifeProvider>().bdayMonth +
                              "월 " +
                              context.watch<ChildLifeProvider>().bdayDay +
                              "일" +
                              "\n",
                          style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            color: const Color(0xff39605f),
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                          )),
                      Text(context.watch<ChildLifeProvider>().className + "\n",
                          style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            color: const Color(0xff39605f),
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                          )),
                      Text(
                          "수집기간: " +
                              context
                                  .watch<ChildLifeProvider>()
                                  .collectionPeriod +
                              "개월",
                          style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            color: const Color(0xff39605f),
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                          )),
                    ],
                  )),
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
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(10))),
                    child: Center(
                      child: Text(
                        '출석일수',
                        style: TextStyle(
                          color: const Color(0xff393838),
                          fontSize: 16.sp,
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 164.w,
                    height: 41.w,
                    decoration: const BoxDecoration(color: Color(0xffc7f7f5)),
                    child: Center(
                      child: Text(
                        '평균등원시간',
                        style: TextStyle(
                          color: const Color(0xff393838),
                          fontSize: 16.sp,
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 164.w,
                    height: 41.w,
                    decoration: const BoxDecoration(color: Color(0xffc7f7f5)),
                    child: Center(
                      child: Text(
                        '평균하원시간',
                        style: TextStyle(
                          color: const Color(0xff393838),
                          fontSize: 16.sp,
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 164.w,
                    height: 41.w,
                    decoration: const BoxDecoration(color: Color(0xffc7f7f5)),
                    child: Center(
                      child: Text(
                        '신장/체중',
                        style: TextStyle(
                          color: const Color(0xff393838),
                          fontSize: 16.sp,
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 164.w,
                    height: 41.w,
                    decoration: const BoxDecoration(color: Color(0xffc7f7f5)),
                    child: Center(
                      child: Text(
                        '등원전 감정분포도',
                        style: TextStyle(
                          color: const Color(0xff393838),
                          fontSize: 16.sp,
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 164.w,
                    height: 41.w,
                    decoration: const BoxDecoration(
                        color: Color(0xffc7f7f5),
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(10))),
                    child: Center(
                      child: Text(
                        '하원전 감정분포도',
                        style: TextStyle(
                          color: const Color(0xff393838),
                          fontSize: 16.sp,
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w400,
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
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(10))),
                    child: Center(
                      child: Text(
                        context.watch<ChildLifeProvider>().attendanceCount,
                        style: TextStyle(
                          color: Color(0xff39605f),
                          fontSize: 30.sp,
                          fontFamily: 'GamjaFlower',
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
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
                        context.watch<ChildLifeProvider>().avgAttendTime,
                        style: TextStyle(
                          color: Color(0xff39605f),
                          fontSize: 30.sp,
                          fontFamily: 'GamjaFlower',
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
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
                        context.watch<ChildLifeProvider>().avgGoinghomeTime,
                        style: TextStyle(
                          color: Color(0xff39605f),
                          fontSize: 30.sp,
                          fontFamily: 'GamjaFlower',
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
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
                    // context.watch<ChildLifeProvider>().weight +"kg",
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 16.w),
                            child: Text(
                              context.watch<ChildLifeProvider>().height + "cm",
                              style: TextStyle(
                                color: Color(0xff39605f),
                                fontSize: 30.sp,
                                fontFamily: 'GamjaFlower',
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                              ),
                              strutStyle: StrutStyle(
                                fontSize: 30.sp,
                                forceStrutHeight: true,
                              ),
                            ),
                          ),Text(
                            context.watch<ChildLifeProvider>().weight +"kg",
                            style: TextStyle(
                              color: Color(0xff39605f),
                              fontSize: 30.sp,
                              fontFamily: 'GamjaFlower',
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            ),
                            strutStyle: StrutStyle(
                              fontSize: 30.sp,
                              forceStrutHeight: true,
                            ),
                          ),
                        ],
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
                        child: Column(
                      children: [
                        if (context
                                .watch<ChildLifeProvider>()
                                .beforeAttendEmotion ==
                            "행복") ...[
                          Container(
                              width: 110.w,
                              height: 66.3.w,
                              margin:
                                  EdgeInsets.only(top: 6.9.w, bottom: 5.8.w),
                              child:
                                  Image.asset("assets/childlifedata/happy.png"))
                        ] else if (context
                                .watch<ChildLifeProvider>()
                                .beforeAttendEmotion ==
                            "신남") ...[
                          Image.asset("assets/childlifedata/excited.png")
                        ] else if (context
                                .watch<ChildLifeProvider>()
                                .beforeAttendEmotion ==
                            "화남") ...[
                          Image.asset("assets/childlifedata/angry.png")
                        ] else if (context
                                .watch<ChildLifeProvider>()
                                .beforeAttendEmotion ==
                            "우울") ...[
                          Image.asset("assets/childlifedata/depressed.png")
                        ] else if (context
                                .watch<ChildLifeProvider>()
                                .beforeAttendEmotion ==
                            "슬픔") ...[
                          Image.asset("assets/childlifedata/sad.png")
                        ] else if (context
                                .watch<ChildLifeProvider>()
                                .beforeAttendEmotion ==
                            "아픔") ...[
                          Image.asset("assets/childlifedata/sick.png")
                        ],
                        Text(
                          context
                              .watch<ChildLifeProvider>()
                              .beforeAttendEmotion,
                          style: TextStyle(
                            color: Color(0xff39605f),
                            fontSize: 20.sp,
                            fontFamily: 'GamjaFlower',
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          ),
                          strutStyle: StrutStyle(
                            fontSize: 20.sp,
                            forceStrutHeight: true,
                          ),
                        ),
                      ],
                    )),
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
                        child: Column(
                          children: [
                            if (context
                                .watch<ChildLifeProvider>()
                                .beforeAttendEmotion ==
                                "행복") ...[
                              Container(
                                  width: 110.w,
                                  height: 66.3.w,
                                  margin:
                                  EdgeInsets.only(top: 6.9.w, bottom: 5.8.w),
                                  child:
                                  Image.asset("assets/childlifedata/happy.png"))
                            ] else if (context
                                .watch<ChildLifeProvider>()
                                .beforeAttendEmotion ==
                                "신남") ...[
                              Image.asset("assets/childlifedata/excited.png")
                            ] else if (context
                                .watch<ChildLifeProvider>()
                                .beforeAttendEmotion ==
                                "화남") ...[
                              Image.asset("assets/childlifedata/angry.png")
                            ] else if (context
                                .watch<ChildLifeProvider>()
                                .beforeAttendEmotion ==
                                "우울") ...[
                              Image.asset("assets/childlifedata/depressed.png")
                            ] else if (context
                                .watch<ChildLifeProvider>()
                                .beforeAttendEmotion ==
                                "슬픔") ...[
                              Image.asset("assets/childlifedata/sad.png")
                            ] else if (context
                                .watch<ChildLifeProvider>()
                                .beforeAttendEmotion ==
                                "아픔") ...[
                              Image.asset("assets/childlifedata/sick.png")
                            ],
                            Text(
                              context
                                  .watch<ChildLifeProvider>()
                                  .beforeAttendEmotion,
                              style: TextStyle(
                                color: Color(0xff39605f),
                                fontSize: 20.sp,
                                fontFamily: 'GamjaFlower',
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                              ),
                              strutStyle: StrutStyle(
                                fontSize: 20.sp,
                                forceStrutHeight: true,
                              ),
                            ),
                          ],
                        )),
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
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(10))),
                    child: Center(
                      child: Text(
                        '평균식사량',
                        style: TextStyle(
                          color: const Color(0xff393838),
                          fontSize: 16.sp,
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 164.w,
                    height: 41.w,
                    decoration: const BoxDecoration(color: Color(0xffc7f7f5)),
                    child: Center(
                      child: Text(
                        '평균수면량',
                        style: TextStyle(
                          color: const Color(0xff393838),
                          fontSize: 16.sp,
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 164.w,
                    height: 41.w,
                    decoration: const BoxDecoration(color: Color(0xffc7f7f5)),
                    child: Center(
                      child: Text(
                        '총 구토 횟수',
                        style: TextStyle(
                          color: const Color(0xff393838),
                          fontSize: 16.sp,
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 164.w,
                    height: 41.w,
                    decoration: const BoxDecoration(color: Color(0xffc7f7f5)),
                    child: Center(
                      child: Text(
                        '총 배변 횟수',
                        style: TextStyle(
                          color: const Color(0xff393838),
                          fontSize: 16.sp,
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 164.w,
                    height: 41.w,
                    decoration: const BoxDecoration(color: Color(0xffc7f7f5)),
                    child: Center(
                      child: Text(
                        '총 투약일',
                        style: TextStyle(
                          color: const Color(0xff393838),
                          fontSize: 16.sp,
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 164.w,
                    height: 41.w,
                    decoration: const BoxDecoration(
                        color: Color(0xffc7f7f5),
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(10))),
                    child: Center(
                      child: Text(
                        '총 안전사고 횟수',
                        style: TextStyle(
                          color: const Color(0xff393838),
                          fontSize: 16.sp,
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w400,
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
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(10)),
                    ),
                    child: Center(
                      child: Text(
                        context.watch<ChildLifeProvider>().avgMeal,
                        style: TextStyle(
                          color: Color(0xff39605f),
                          fontSize: 30.sp,
                          fontFamily: 'GamjaFlower',
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
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
                        //평균 수면량이 통째로들어와서 정렬하기가 애매합니다
                        //avgSleep을 잘라서 넣기에는 들어올 String의 길이가 일정하지 않습니다
                        //
                        context.watch<ChildLifeProvider>().avgSleep,
                        style: TextStyle(
                          color: Color(0xff39605f),
                          fontSize: 30.sp,
                          fontFamily: 'GamjaFlower',
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
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
                        context.watch<ChildLifeProvider>().vomitCount + "회",
                        style: TextStyle(
                          color: Color(0xff39605f),
                          fontSize: 30.sp,
                          fontFamily: 'GamjaFlower',
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
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
                        context.watch<ChildLifeProvider>().toiletCount + "회",
                        style: TextStyle(
                          color: Color(0xff39605f),
                          fontSize: 30.sp,
                          fontFamily: 'GamjaFlower',
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
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
                        context.watch<ChildLifeProvider>().medicineCount + "일",
                        style: TextStyle(
                          color: Color(0xff39605f),
                          fontSize: 30.sp,
                          fontFamily: 'GamjaFlower',
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
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
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(10)),
                    ),
                    child: Center(
                      child: Text(
                        context.watch<ChildLifeProvider>().accidentCount + "회",
                        style: TextStyle(
                          color: Color(0xff39605f),
                          fontSize: 30.sp,
                          fontFamily: 'GamjaFlower',
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
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
