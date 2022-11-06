import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';

import 'dart:math' as math;

//왠지는
class ClassInfo30 extends StatefulWidget {
  const ClassInfo30({Key? key}) : super(key: key);

  @override
  State<ClassInfo30> createState() => _ClassInfo30State();
}

class _ClassInfo30State extends State<ClassInfo30> {
  int childNum = 28;
  int column = 7;
  double row=4;
  @override
  void initState() {
    row = childNum / column;
    super.initState();
  }

  double boyrate = 0.5;
  double girlrate = 0.7;

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
  List<double> chartRate = [0.67, 0.89, 0.30, 1.00, 0.92, 0.94, 0.89, 0.90];

  int teacherNum = 3;
  List<String> teacherName = ['김담임', '김담임', '김담임'];
  String className = '새싹어린이반';
  List<int> classInfo =[0,10,6,4]; //반 나이, 총 인원, 남아 수, 여아 수 순서


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
                child: Column(
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
                                  margin: EdgeInsets.only(left: 40.w, top: 140.w),
                                  child: Text(className,
                                      style: TextStyle(
                                        fontFamily: 'GamjaFlower',
                                        color: const Color(0xff39605f),
                                        fontSize: 30.sp,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                      )
                                  ),
                                ),
                                Container(
                                    width: 270.w,
                                    height: 40.w,
                                    margin: EdgeInsets.only(top: 20.w),
                                    decoration: BoxDecoration(
                                        color: const Color(0xffc7f7f5),
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                  child: Center(
                                    child: Text(classInfo[0].toString() + '세 | '+classInfo[1].toString()+'명 | 남:'
                                    +classInfo[2].toString()+'명 여:'+classInfo[3].toString()+'명', style: TextStyle(fontSize: 18.sp),),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                        ///담임
                        for(int i=0;i<teacherNum;i++)...[
                          Column(
                            children: [
                              Container(
                                width: 100.w,
                                height: 66.w,
                                //페이지에 따라 마진 조절 바람 건희, 성민
                                margin: EdgeInsets.only(left: 60.w),
                                child: const Image(
                                    image: AssetImage(
                                        'assets/childlifedata/02_2.jpg')),
                              ),
                              Container(
                                  width: 160.w,
                                  height: 40.w,
                                  decoration: BoxDecoration(
                                      color: const Color(0xffc7f7f5),
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                child: Center(
                                  child: Text(teacherName[i],
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
                    for(int i=0;i<4;i++) ...[// 총 row줄, row column 잘 안먹으면 일단 그냥 정수 박으세요
                      Row(
                        children: [
                          for(int j=0;j<column;j++)...[
                            Column(//사진+이름배치를 위해 column으로 시작
                              children: [
                                if(j==0)...[
                                  Container(
                                    width: 110.w,
                                    height: 110.w,
                                    margin: EdgeInsets.only(left: 31.w, top: 30.w),
                                    child: const Image(
                                        image: AssetImage(
                                            'assets/childlifedata/baby_sample.png')),
                                  )
                                ] else ...[
                                  Container(
                                    width: 110.w,
                                    height: 110.w,
                                    margin: EdgeInsets.only(left: 36.w, top: 30.w),
                                    child: const Center(
                                      child: Image(
                                          image: AssetImage(
                                              'assets/childlifedata/baby_sample.png')),
                                    ),
                                  )
                                ],
                                Container(
                                    width: 116.w,
                                    height: 35.w,
                                    decoration: BoxDecoration(
                                        color: const Color(0xffc7f7f5),
                                        borderRadius: BorderRadius.circular(17.5)
                                    ),
                                  margin: EdgeInsets.only(left: 28.w),
                                  child: Center(
                                    child: Text("김아가",
                                        style: TextStyle(
                                          fontFamily: 'NotoSansKR',
                                          color: const Color(0xff000000),
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                        )
                                    ),
                                  ),
                                )
                              ],
                            )
                          ]
                        ],
                      )
                    ]
                    ///아이들
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

}
