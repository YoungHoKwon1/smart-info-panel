import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';

import 'dart:math' as math;

//왠지는
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
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      'assets/childlifedata/0_02.jpg'))),
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
                                      color: const Color(0x4d63e6d7),
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(10))),
                                child: Center(
                                  child: Text(
                                    '25',
                                    style: TextStyle(
                                      color: const Color(0xff39605f),
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
                                    color: const Color(0x4d63e6d7),
                                    width: 1,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    '08:35',
                                    style: TextStyle(
                                      color: const Color(0xff39605f),
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
                                    color: const Color(0x4d63e6d7),
                                    width: 1,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    '19:35',
                                    style: TextStyle(
                                      color: const Color(0xff39605f),
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
                                    color: const Color(0x4d63e6d7),
                                    width: 1,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "113cm\n22kg",
                                    style: TextStyle(
                                     color: const Color(0xff39605f),
                                      fontSize: 30.sp,
                                      //fontFamily: 'GamjaFlower',
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
                                    color: const Color(0x4d63e6d7),
                                    width: 1,
                                  ),
                                ),
                                child: Center(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: 100.w,
                                        height: 66.w,
                                        child: const Image(
                                            image: AssetImage(
                                                'assets/childlifedata/02_2.jpg')),
                                      ),
                                      Text(
                                        '신남',
                                        style: TextStyle(
                                          color: const Color(0xff39605f),
                                          fontSize: 20.sp,
                                          fontFamily: 'GamjaFlower',
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
                                      color: const Color(0x4d63e6d7),
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(10))),
                                child: Center(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: 100.w,
                                        height: 66.w,
                                        child: const Image(
                                            image: AssetImage(
                                                'assets/childlifedata/02.jpg')),
                                      ),
                                      Text(
                                        '행복',
                                        style: TextStyle(
                                          color: const Color(0xff39605f),
                                          fontSize: 20.sp,
                                          fontFamily: 'GamjaFlower',
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
                                    color: const Color(0x4d63e6d7),
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(10)),
                                ),
                                child: Center(
                                  child: Text(
                                    '조금',
                                    style: TextStyle(
                                      color: const Color(0xff39605f),
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
                                    color: const Color(0x4d63e6d7),
                                    width: 1,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    '1시간 - \n1시간 30분',
                                    style: TextStyle(
                                      color: const Color(0xff39605f),
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
                                    color: const Color(0x4d63e6d7),
                                    width: 1,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    '1회',
                                    style: TextStyle(
                                      color: const Color(0xff39605f),
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
                                    color: const Color(0x4d63e6d7),
                                    width: 1,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "3회",
                                    style: TextStyle(
                                      color: const Color(0xff39605f),
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
                                    color: const Color(0x4d63e6d7),
                                    width: 1,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    '15일',
                                    style: TextStyle(
                                      color: const Color(0xff39605f),
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
                                    color: const Color(0x4d63e6d7),
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(10)),
                                ),
                                child: Center(
                                  child: Text(
                                    '0회',
                                    style: TextStyle(
                                      color: const Color(0xff39605f),
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
                    color: const Color(0xff707070),
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
                          children: [
                            // 남아-02
                            Row(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 182.w,
                                  height: 105.w,
                                  margin: EdgeInsets.only(left: 26.w, top: 16.w),
                                  child: const Image(
                                      image: AssetImage(
                                          'assets/childlifedata/02_3.jpg')),
                                ),
                                Text("남아",
                                    style: TextStyle(
                                      fontFamily: 'GamjaFlower',
                                      color: const Color(0xff39605f),
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,


                                    )
                                )
                              ],
                            ),
                            Container(
                              width: 203.w,//336
                              height: 20.w,
                              margin: EdgeInsets.only(left: 40.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18.w),
                                color: const Color(0xFF80DB68),
                              ),
                              child: Text("67%", style: TextStyle(fontSize: 16.sp),textAlign: TextAlign.right,),
                            )
                            // Stack(
                            //   children: <Widget>[
                            //     Transform.rotate(
                            //       angle: radians,
                            //       child: Container(
                            //         width: 0.w,
                            //         height: 50.w,
                            //         //margin: EdgeInsets.only(bottom: 40.w),
                            //         child: BarChart(
                            //           ChildBarData(boyrate),
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // )
                            //남아
                          ],
                        ),
                        ///남아
                        SizedBox(
                          width: 210.w,
                        ),

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
                                  child: const Image(
                                      image: AssetImage(
                                          'assets/childlifedata/02_4.jpg')),
                                ),
                                Text("여아",
                                    style: TextStyle(
                                      fontFamily: 'GamjaFlower',
                                      color: const Color(0xff39605f),
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,


                                    )
                                )
                              ],
                            ),
                            Container(
                              width: 256.w,//336
                              height: 20.w,
                              //margin: EdgeInsets.only(left: 40.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18.w),
                                color: const Color(0xCEFF74B8)
                              ),
                              child: Text("78%", style: TextStyle(fontSize: 16.sp),textAlign: TextAlign.right,),
                            )
                            // Stack(
                            //   children: <Widget>[
                            //     Transform.rotate(
                            //       angle: radians,
                            //       child: SizedBox(
                            //         width: 0.w,
                            //         height: 50.w,
                            //         child: BarChart(
                            //           ChildBarData(girlrate),
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // )
                          ],
                        )

                        ///여아
                      ],
                    ),

                    ///학급별그래프
                    Container(
                      width: 748.w,
                      height: 309.w,
                      child: AspectRatio(
                        //그래프의 배경크기(?)인데 정확한 크기 측정 방법을 모르겠어요
                        //그냥 상위 위젯이 500 크기라 거기에 맞춰서 소숫점 바꿔봤습니다.
                        aspectRatio: 1.603.w,
                        //배경 설정
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.w),
                            color: const Color(0xffffffff),
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
                                        color: const Color(0xff39605f),
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 38.w,
                                    ),
                                    //반이름 나오던게 갑자기 안나와서 일단 보고있습니다.
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
                                      height: 10.w,
                                    ),
                                  ],
                                ),
                              ),

                              //이걸 제거해보시면 바로 뭔지 아실텐데
                              //디자인 상 넣은거라 위치와 크기 디자인 넣을 때 잡아주시면 될듯 합니다.
                              Positioned(
                                  top: 222.w,
                                  left: 36.w,
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 10.w,
                                        width: 745.w,
                                        color: const Color(0xff63e6d7),
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
                  image: AssetImage('assets/childlifedata/sunny_01.jpg'),
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
                          child: Text("22도",
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
                          child: Text("52%",
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
                          child: Text("15",
                              style: TextStyle(
                                fontFamily: 'GamjaFlower',
                                color: const Color(0xff42372c),
                                fontSize: 40.sp,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                              )),
                          margin: EdgeInsets.only(top: 43.w),
                        ),
                        Container(
                          child: Text("328ppm",
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
                          child: Text("102ppb",
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
          )

          ///등원유아 수, 공기질
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
          color: const Color(0x4d63e66d),
          width: 22.w,
          borderSide: BorderSide(color: const Color(0x4d63e66d), width: 1.w),
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
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 14.sp,
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
          borderSide: const BorderSide(color: Colors.black, width: 01), //막대그래프 테두리
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
                color: const Color(0xff393838),
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: attendance,
                  style: TextStyle(
                    color: const Color(0xff393838),
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
            getTitlesWidget: getClassTitles,
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
      color: const Color(0xff000000),
      fontFamily: '.AppleSystemUIFont',
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      fontSize: 14.sp,
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
