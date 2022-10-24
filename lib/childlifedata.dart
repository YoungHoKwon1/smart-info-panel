import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';

import 'dart:math' as math;

class ChildLifeData extends StatefulWidget {
  const ChildLifeData({Key? key}) : super(key: key);

  @override
  State<ChildLifeData> createState() => _ChildLifeDataState();
}

class _ChildLifeDataState extends State<ChildLifeData> {
  double degrees = 90;
  double radians = 0;

  @override
  void initState() {
    radians = degrees * math.pi / 180;

    super.initState();
  }

  double boyrate = 67;
  double girlrate = 78;

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
  List<double> chartData = [67, 89, 30, 100, 92, 94, 89, 90];

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
                              image: AssetImage('assets/childlifedata/0_02.jpg')
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
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border:
                        Border.all(color: const Color(0x6663e6d7), width: 1),
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0x29b1b1b1),
                          offset: Offset(-2, 2),
                          blurRadius: 6,
                          spreadRadius: 0),
                      BoxShadow(
                          color: const Color(0x29dbdbdb),
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
                          color: Color(0xff39605f),
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
                          children: [
                            // 남아-02
                            Container(
                              width: 182.w,
                              height: 110.w,
                              margin: EdgeInsets.only(left: 26.w, top: 16.w),
                              child: const Image(
                                  image: AssetImage(
                                      'assets/childlifedata/02_3.jpg')),
                            ),
                            Stack(
                              children: <Widget>[
                                Transform.rotate(
                                  angle: radians,
                                  child: Container(
                                    width: 0.w,
                                    height: 50.w,
                                    //margin: EdgeInsets.only(bottom: 40.w),
                                    child: BarChart(
                                      ChildBarData(boyrate),
                                    ),
                                  ),
                                ),
                              ],
                            )
                            //남아
                          ],
                        ),

                        ///남아
                        SizedBox(
                          width: 216.w,
                        ),

                        ///여아
                        Column(
                          children: [
                            Container(
                              width: 182.w,
                              height: 110.w,
                              margin: EdgeInsets.only(top: 16.w),
                              child: const Image(
                                  image: AssetImage(
                                      'assets/childlifedata/02_4.jpg')),
                            ),
                            Stack(
                              children: <Widget>[
                                Transform.rotate(
                                  angle: radians,
                                  child: SizedBox(
                                    width: 0.w,
                                    height: 50.w,
                                    child: BarChart(
                                      ChildBarData(girlrate),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )

                        ///여아
                      ],
                    ),

                    ///학급별그래프
                    Container(
                      width: 748.w,
                      height: 320.w,
                      child: AspectRatio(
                        //그래프의 배경크기(?)인데 정확한 크기 측정 방법을 모르겠어요
                        //그냥 상위 위젯이 500 크기라 거기에 맞춰서 소숫점 바꿔봤습니다.
                        aspectRatio: 1.603.w,
                        //배경 설정
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.w),
                            color: Color(0xffffffff),
                          ),
                          //그래프와 그래프 이름
                          child: Stack(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Text(
                                      '학급별',
                                      style: TextStyle(
                                        color: Color(0xff39605f),
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 38.w,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.w),
                                        child: BarChart(
                                          ClassBarData(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 12.w,
                                    ),
                                  ],
                                ),
                              ),

                              //이걸 제거해보시면 바로 뭔지 아실텐데
                              //디자인 상 넣은거라 위치와 크기 디자인 넣을 때 잡아주시면 될듯 합니다.
                              Positioned(
                                  top: 232.w,
                                  left: 36.w,
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 10.w,
                                        width: 748.w,
                                        color: Color(0xff63e6d7),
                                      ),
                                      // Container(
                                      //   height: 0.w,
                                      //   width: 700.w,
                                      //   color: Color(0xff63e6d7),
                                      // )
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),///등원유아 수
              ),
              ///공기질
              Container(
                width: 820.w,
                height: 518.w,
                margin: EdgeInsets.only(left: 15.w, top: 12.w),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/childlifedata/sunny_01.jpg'),
                  )
                ),
                // child: Container(
                //   margin: ,
                // ),
              )///공기질
            ],
          )///등원유아 수, 공기질
        ],
      ),
    );
  }

  ///유아그래프
  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.white,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: Color(0x4d63e66d),
          width: 22.w,
          borderSide: BorderSide(color: Color(0x4d63e66d), width: 1.w),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 100,
            color: Colors.white, //배경
          ),
        ),
      ],
    );
  }

  List<BarChartGroupData> showingChildGroups() => List.generate(1, (i) {
        return makeGroupData(0, 50);
      });

  BarChartData ChildBarData(double value) {
    return BarChartData(
      alignment: BarChartAlignment.start,
      maxY: 100,
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.blueGrey,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {},
        ),
      ),
      titlesData: FlTitlesData(
        show: false,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            getTitlesWidget: getTitles,
            reservedSize: 0.w,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingChildGroups(),
      gridData: FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    TextStyle style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 14.w,
    );
    Widget text = Text('', style: style);
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  ///유아그래프
  ///
  ///
  ///반그래프
  //그래프 데이터중 막대 그래프 하나입니다
  BarChartGroupData makeClassGroupData(
    int x,
    double y, {
    // 이부분은 생성자로 사실 안 쓰입니다
    bool isTouched = false,
    Color barColor = const Color(0xffc7f7f5),
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y, //y값
          color: barColor, //색상
          width: 20.w, //두께
          borderSide: BorderSide(color: Colors.black, width: 01), //막대그래프 테두리
        ),
      ],
      showingTooltipIndicators: [0],
    );
  }

  //그래프 데이터를 만들때 사용하는 막대그래프에 데이터 넣어주는 역할입니다
  //사람 수만큼 만든다음에
  //데이터를 넣어주면 완성됩니다.
  List<BarChartGroupData> showingClassGroups() =>
      List.generate(childHeadCount, (i) {
        return makeClassGroupData(i, chartData[i]);
      });

  //데이터를 표시하는 역할입니다
  //원래는 터치를 해야만 나오는 데이터지만 위에 막대그래프 생성할때 showingTooltipIndicators: [0],로 설정을 해서 항시 표시합니다.
  BarChartData ClassBarData() {
    return BarChartData(
      //최대치 설정
      maxY: 100,
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipMargin: 0.w,
          tooltipPadding: EdgeInsets.only(bottom: 0.w),
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            //여기에서 몇퍼센트인지 표기를 합니다.
            String attendance = chartData[group.x].toString() + '%';
            //꼭 이 형식을 지켜야 하나 봅니다?
            //아래 children은 없어도 되지만 글씨가 떠서 넣었습니다.
            return BarTooltipItem(
              '',
              TextStyle(
                color: Color(0xff393838),
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: attendance,
                  style: TextStyle(
                    color: Color(0xff393838),
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
              ],
            );
          },
        ),
      ),
      //그래프의 위아래, 양옆에 데이터를 표기하고 싶으면 각각의 showtitles를 true로 바꿈됩니다.
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38.w,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingClassGroups(),
      gridData: FlGridData(show: false),
    );
  }

  //아래 반 이름을 나오게 하는 설정입니다.
  //value값은 인원수 만큼 알아서 넣어지더라고요.
  Widget getClassTitles(double value, TitleMeta meta) {
    TextStyle style = TextStyle(
      color: Color(0xff000000),
      fontFamily: '.AppleSystemUIFont',
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      fontSize: 14.w,
    );
    Widget text;
    text = Text(childClassName[value.toInt()], style: style);
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16.w,
      child: text,
    );
  }

  ///반데이터
}
