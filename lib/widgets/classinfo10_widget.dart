import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:smart_info_panel/api/infopanel.dart';
import 'dart:async';

import '../provider/class_data.dart';
import 'package:provider/provider.dart';

class ClassInfo10Widget extends StatefulWidget {
  const ClassInfo10Widget({Key? key}) : super(key: key);

  @override
  State<ClassInfo10Widget> createState() => _ClassInfo10WidgetState();
}

class _ClassInfo10WidgetState extends State<ClassInfo10Widget> {
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 464.w,
              height: 298.w,
              margin: EdgeInsets.only(left: 170.w),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                          'assets/class_info_deco/age2class.png'))),
              child: Center(
                child: Column(
                  children: [
                    //교실이름구역
                    Container(
                      margin:
                      EdgeInsets.only(left: 60.w, top: 143.w),
                      child: Text(context.watch<ClassDataProvider>().className,
                          style: TextStyle(
                            fontFamily: 'GamjaFlower',
                            color: Color(0xff39605f),
                            fontSize: 33.sp,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          )),
                    ),
                    Container(
                      width: 351.w,
                      height: 53.w,
                      margin: EdgeInsets.only(top: 20.w),
                      decoration: new BoxDecoration(
                          color: Color(0xffc7f7f5),
                          borderRadius:
                          BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          context.watch<ClassDataProvider>().classInfo[0].toString() +
                              '세 | ' +
                              context.watch<ClassDataProvider>().classInfo[1].toString() +
                              '명 | 남:' +
                              context.watch<ClassDataProvider>().classInfo[2].toString() +
                              '명 여:' +
                              context.watch<ClassDataProvider>().classInfo[3].toString() +
                              '명',
                          style: TextStyle(
                              fontSize: 20.sp,
                              color: Colors.black,
                              fontFamily: '.AppleSystemUIFont'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            ///담임
            for (int i = 0; i < context.watch<ClassDataProvider>().teacherNum; i++) ...[
              Column(
                children: [
                  Container(
                      width: 150.w,
                      height: 100.w,
                      //페이지에 따라 마진 조절 바람 건희, 성민
                      child: context.watch<ClassDataProvider>().teacherImage[i]),
                  Container(
                    width: 190.w,
                    height: 47.w,
                    decoration: BoxDecoration(
                        color: Color(0xffc7f7f5),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text(
                        context.watch<ClassDataProvider>().teacherName[i],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.sp,
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
        for (int i = 0; i < context.watch<ClassDataProvider>().row; i++) ...[
          Row(
            children: [
              for (int j = 0; j < context.watch<ClassDataProvider>().column; j++) ...[
                Column(
                  //사진+이름배치를 위해 column으로 시작
                  children: [
                    if (j == 0) ...[
                      Container(
                          width: 120.w,
                          height: 120.w,
                          margin: EdgeInsets.only(
                              left: 151.w, top: 82.w),
                          child: context.watch<ClassDataProvider>().childrenImage[context.watch<ClassDataProvider>().column * i + j]),
                      Container(
                        width: 116.w,
                        height: 35.w,
                        decoration: BoxDecoration(
                            color: const Color(0xffc7f7f5),
                            borderRadius:
                            BorderRadius.circular(17.5)),
                        margin: EdgeInsets.only(left: 151.w),
                        child: Center(
                          child: Text(
                              context.watch<ClassDataProvider>().childrenName[context.watch<ClassDataProvider>().column * i + j],
                              style: TextStyle(
                                fontFamily: 'NotoSansKR',
                                color: const Color(0xff000000),
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                              )),
                        ),
                      )
                    ] else ...[
                      Container(
                        width: 120.w,
                        height: 120.w,
                        margin: EdgeInsets.only(
                            left: 92.w, top: 82.w),
                        child: Center(
                            child: context.watch<ClassDataProvider>().childrenImage[context.watch<ClassDataProvider>().column * i + j]),
                      ),
                      Container(
                        width: 116.w,
                        height: 35.w,
                        decoration: BoxDecoration(
                            color: const Color(0xffc7f7f5),
                            borderRadius:
                            BorderRadius.circular(17.5)),
                        margin: EdgeInsets.only(left: 94.w),
                        child: Center(
                          child: Text(
                              context.watch<ClassDataProvider>().childrenName[context.watch<ClassDataProvider>().column * i + j],
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
                  ],
                )
              ]
            ],
          )
        ],

        ///아이들
        ///나머지 아이들
        if (context.watch<ClassDataProvider>().rest != 0) ...[
          Row(
            children: [
              for (int j = 0; j < context.watch<ClassDataProvider>().rest; j++) ...[
                Column(
                  //사진+이름배치를 위해 column으로 시작
                  children: [
                    if (j == 0) ...[
                      Container(
                          width: 120.w,
                          height: 120.w,
                          margin: EdgeInsets.only(
                              left: 90.w, top: 78.w),
                          child: context.watch<ClassDataProvider>().childrenImage[context.watch<ClassDataProvider>().row * context.watch<ClassDataProvider>().column + j]),
                      Container(
                        width: 116.w,
                        height: 35.w,
                        decoration: BoxDecoration(
                            color: const Color(0xffc7f7f5),
                            borderRadius:
                            BorderRadius.circular(17.5)),
                        margin: EdgeInsets.only(left: 94.w),
                        child: Center(
                          child: Text(
                              context.watch<ClassDataProvider>().childrenName[context.watch<ClassDataProvider>().row * context.watch<ClassDataProvider>().column + j],
                              style: TextStyle(
                                fontFamily: 'NotoSansKR',
                                color: const Color(0xff000000),
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                              )),
                        ),
                      )
                    ] else ...[
                      Container(
                          width: 120.w,
                          height: 120.w,
                          margin: EdgeInsets.only(
                              left: 90.w, top: 78.w),
                          child: Center(
                              child: context.watch<ClassDataProvider>().childrenImage[
                              context.watch<ClassDataProvider>().row * context.watch<ClassDataProvider>().column + j]))
                    ],
                    Container(
                      width: 116.w,
                      height: 35.w,
                      decoration: BoxDecoration(
                          color: const Color(0xffc7f7f5),
                          borderRadius:
                          BorderRadius.circular(17.5)),
                      margin: EdgeInsets.only(left: 94.w),
                      child: Center(
                        child:
                        Text(context.watch<ClassDataProvider>().childrenName[context.watch<ClassDataProvider>().row * context.watch<ClassDataProvider>().column + j],
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
