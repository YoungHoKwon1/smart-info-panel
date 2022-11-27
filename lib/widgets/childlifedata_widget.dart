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
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 250.w,
              height: 250.w,
              margin: EdgeInsets.only(left: 310.w, top: 108.w),
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                        'assets/child_face_deco/age0face.png')),
              ),
              child: context.watch<ChildLifeProvider>().childImage,
            ),

            ///아이정보
            Center(
              child: Container(
                  width: 169.w,
                  height: 195.w,
                  margin: EdgeInsets.only(left: 50.w, top: 110.w),
                  child: Text(
                      context.watch<ChildLifeProvider>().childName +
                          "\n\n" +
                          context.watch<ChildLifeProvider>().bdayYear +
                          "년 " +
                          context.watch<ChildLifeProvider>().bdayMonth +
                          "월 " +
                          context.watch<ChildLifeProvider>().bdayDay +
                          "일" +
                          "\n\n" +
                          context.watch<ChildLifeProvider>().className +
                          "\n\n" +
                          context.watch<ChildLifeProvider>().collectionPeriod +
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
                        context.watch<ChildLifeProvider>().attendanceCount,
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
                        context.watch<ChildLifeProvider>().avgAttendTime,
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
                        context.watch<ChildLifeProvider>().avgGoinghomeTime,
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
                        context.watch<ChildLifeProvider>().height + "cm\n" + context.watch<ChildLifeProvider>().weight + "kg",
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
                        context.watch<ChildLifeProvider>().beforeAttendEmotion,
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
                        context.watch<ChildLifeProvider>().beforeGoingHomeEmotion,
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
                        context.watch<ChildLifeProvider>().avgMeal,
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
                        context.watch<ChildLifeProvider>().avgSleep,
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
                        context.watch<ChildLifeProvider>().vomitCount + "회",
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
                        context.watch<ChildLifeProvider>().toiletCount + "회",
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
                        context.watch<ChildLifeProvider>().medicineCount + "일",
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
                        context.watch<ChildLifeProvider>().accidentCount + "회",
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
