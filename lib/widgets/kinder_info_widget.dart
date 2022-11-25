import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';


import 'package:dio/dio.dart';
import 'dart:async';
import 'package:smart_info_panel/api/infopanel.dart';
import 'package:provider/provider.dart';

import '../provider/kinder_data.dart';
class KinderInfoWidget extends StatefulWidget {
  const KinderInfoWidget({Key? key}) : super(key: key);

  @override
  State<KinderInfoWidget> createState() => _KinderInfoWidgetState();
}

class _KinderInfoWidgetState extends State<KinderInfoWidget> {



  int touchedIndex = -1;

  @override
  void initState() {
    super.initState();
  }

  Dio dio = Dio();

  String url = "http://tmap.aijoa.us:48764/";
  final token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZGVudGlmaWNhdGlvbiI6MjIsInZlcnNpb24iOiIwLjAuNCIsImlhdCI6MTY2NzM2MTY3NCwiZXhwIjoxNjY5OTUzNjc0LCJpc3MiOiJhaWpvYSJ9.GKbcaliPyXkYy5szr_4nJOOpfN-vvigMBt3ufShmgtY';


  List<Color> classGraphColor = [
    const Color(0xffc7f7f5),
    const Color(0xffc6d0f4),
    const Color(0xfff4dac6),
    const Color(0xfff4f4c6),
    const Color(0xfff4c6ed)
  ];

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


  @override
  Widget build(BuildContext context) {
    return Column(
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
                child: context.watch<KinderDataProvider>().kinderImage),

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
                                        context.watch<KinderDataProvider>().classGraphName.length),
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
                                          context.watch<KinderDataProvider>().classGraphName.length;
                                      i++) ...[
                                        Row(
                                          children: [
                                            Indicator(
                                                color: classGraphColor[i],
                                                text: context.watch<KinderDataProvider>().classGraphName[i],
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
                                          context.watch<KinderDataProvider>().classGraphName.length;
                                      i++) ...[
                                        Row(
                                          children: [
                                            Text(
                                              context.watch<KinderDataProvider>().classNumEach[i]
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
                                    context.watch<KinderDataProvider>().classGraphName.length),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              for (int i = 0;
                              i < context.watch<KinderDataProvider>().classGraphName.length;
                              i++) ...[
                                Indicator(
                                    color: classGraphColor[i],
                                    text: context.watch<KinderDataProvider>().classGraphName[i],
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
                              i < context.watch<KinderDataProvider>().classGraphName.length;
                              i++) ...[
                                Row(
                                  children: [
                                    Text(
                                      context.watch<KinderDataProvider>().childNumEachAge[i]
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
                                width: 200.0 * context.watch<KinderDataProvider>().childrenCountByTeacher/100.w,
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
                                width: 200.0 * context.watch<KinderDataProvider>().childrenCountByClass/100.w,
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
                                    context.watch<KinderDataProvider>().childrenCountByTeacher
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
                                    context.watch<KinderDataProvider>().childrenCountByClass
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
                        child: Text(context.watch<KinderDataProvider>().firstRowInt[i].toString(),
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
                        child: Text(context.watch<KinderDataProvider>().firstRowInt[i].toString(),
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
                        child: Text(context.watch<KinderDataProvider>().firstRowInt[i].toString(),
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
                        child: Text(context.watch<KinderDataProvider>().firstRowInt[i].toString(),
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
                        child: Text(context.watch<KinderDataProvider>().secondRowInt[i].toString(),
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
                        child: Text(context.watch<KinderDataProvider>().secondRowInt[i].toString(),
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
                        child: Text(context.watch<KinderDataProvider>().secondRowInt[i].toString(),
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
                        child: Text(context.watch<KinderDataProvider>().secondRowInt[i].toString(),
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
                        child: Text(context.watch<KinderDataProvider>().thirdRowInt[i].toString(),
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
                        child: Text(context.watch<KinderDataProvider>().thirdRowInt[i].toString(),
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
                        child: Text(context.watch<KinderDataProvider>().thirdRowInt[i].toString(),
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
                        child: Text(context.watch<KinderDataProvider>().thirdRowInt[i].toString(),
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
    );
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
            value: context.watch<KinderDataProvider>().classGraphRate[0],
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
            value: context.watch<KinderDataProvider>().classGraphRate[1],
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
            value: context.watch<KinderDataProvider>().classGraphRate[2],
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
            value: context.watch<KinderDataProvider>().classGraphRate[3],
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
            value: context.watch<KinderDataProvider>().classGraphRate[4],
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
