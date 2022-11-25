import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:smart_info_panel/api/infopanel.dart';
import 'dart:async';

import '../provider/teacher_data.dart';
import 'package:provider/provider.dart';

class TeacherInfoWidget extends StatefulWidget {
  const TeacherInfoWidget({Key? key}) : super(key: key);

  @override
  State<TeacherInfoWidget> createState() => _TeacherInfoWidgetState();
}

class _TeacherInfoWidgetState extends State<TeacherInfoWidget> {
  void initState() {
    super.initState();
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
        height: 895.w,
        margin: EdgeInsets.only(left: 16.w, top: 16.w),
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
                ///원장
                for (int i = 0; i < context.watch<TeacherDataProvider>().teacherNum; i++) ...[
                  Column(
                    children: [
                      Container(
                          width: 140.w,
                          height: 140.w,
                          //페이지에 따라 마진 조절 바람 건희, 성민
                          margin:
                          EdgeInsets.only(left: 102.w, top: 49.w),
                          child: context.watch<TeacherDataProvider>().directorImage[i]),
                      Container(
                        width: 200.w,
                        height: 45.w,
                        margin: EdgeInsets.only(left: 102.w),
                        decoration: BoxDecoration(
                            color: const Color(0xff71d8d4),
                            borderRadius:
                            BorderRadius.circular(22.5)),
                        child: Center(
                          child: Text(
                            context.watch<TeacherDataProvider>().directorName[i],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.sp,
                              fontFamily: '.NotoSansKR',
                            ),
                            strutStyle: StrutStyle(
                              fontSize: 18.sp,
                              forceStrutHeight: true,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 200.w,
                        height: 45.w,
                        margin: EdgeInsets.only(left: 102.w),
                        child: Center(
                          child: Text(
                            context.watch<TeacherDataProvider>().directorIntroduction[i],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontFamily: '.NotoSansKR',
                            ),
                            strutStyle: StrutStyle(
                              fontSize: 18.sp,
                              forceStrutHeight: true,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ]
                ///원장
              ],
            ),

            ///선생님
            for (int i = 0; i < 1; i++) ...[
              // 총 row줄, row column 잘 안먹으면 일단 그냥 정수 박으세요
              Row(
                children: [
                  for (int j = 0; j < context.watch<TeacherDataProvider>().teacherNum; j++) ...[
                    Column(
                      //사진+이름배치를 위해 column으로 시작
                      children: [
                        if (j == 0) ...[
                          Container(
                              width: 135.w,
                              height: 135.w,
                              margin: EdgeInsets.only(
                                  left: 23.w, top: 65.w),
                              child: context.watch<TeacherDataProvider>().teacherImage[j]),
                          Container(
                            width: 180.w,
                            height: 45.w,
                            margin: EdgeInsets.only(left: 28.w),
                            decoration: new BoxDecoration(
                                color: const Color(0xffc7f7f5),
                                borderRadius:
                                BorderRadius.circular(22.5)),
                            child: Center(
                              child: Text(context.watch<TeacherDataProvider>().teacherName[j],
                                  style: TextStyle(
                                    fontFamily: '.NotoSansKR',
                                    color: const Color(0xff000000),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                  )),
                            ),
                          ),
                          Container(
                              width: 160.w,
                              height: 47.w,
                              margin: EdgeInsets.only(left: 38.w),
                              child: Center(
                                  child: Text(context.watch<TeacherDataProvider>().teacherIntroduction[j],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontFamily: '.NotoSansKR',
                                      ),
                                      strutStyle: StrutStyle(
                                        fontSize: 18.sp,
                                        forceStrutHeight: true,
                                      ))))
                        ] else ...[
                          Container(
                              width: 135.w,
                              height: 135.w,
                              margin: EdgeInsets.only(
                                  left: 13.w, top: 65.w),
                              child: context.watch<TeacherDataProvider>().teacherImage[j]),
                          Container(
                            width: 180.w,
                            height: 45.w,
                            margin: EdgeInsets.only(left: 23.w),
                            decoration: new BoxDecoration(
                                color: const Color(0xffc7f7f5),
                                borderRadius:
                                BorderRadius.circular(17.5)),
                            child: Center(
                              child: Text(context.watch<TeacherDataProvider>().teacherName[j],
                                  style: TextStyle(
                                    fontFamily: 'NotoSansKR',
                                    color: const Color(0xff000000),
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                  )),
                            ),
                          ),
                          Container(
                              width: 160.w,
                              height: 47.w,
                              margin: EdgeInsets.only(left: 43.w),
                              child: Center(
                                  child: Text(context.watch<TeacherDataProvider>().teacherIntroduction[j],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontFamily: '.NotoSansKR',
                                      ),
                                      strutStyle: StrutStyle(
                                        fontSize: 18.sp,
                                        forceStrutHeight: true,
                                      ))))
                        ],
                      ],
                    )
                  ]
                ],
              )
            ],

            ///학부모
            for (int i = 0; i < 1; i++) ...[
              // 총 row줄, row column 잘 안먹으면 일단 그냥 정수 박으세요
              Row(
                children: [
                  for (int j = 0; j < context.watch<TeacherDataProvider>().committeeNum; j++) ...[
                    Column(
                      //사진+이름배치를 위해 column으로 시작
                      children: [
                        if (j == 0) ...[
                          Container(
                              width: 135.w,
                              height: 135.w,
                              margin: EdgeInsets.only(
                                  left: 23.w, top: 65.w),
                              child: context.watch<TeacherDataProvider>().committeeImage[j]),
                          Container(
                            width: 180.w,
                            height: 45.w,
                            margin: EdgeInsets.only(left: 28.w),
                            decoration: new BoxDecoration(
                                color: const Color(0xffffc9c9),
                                borderRadius:
                                BorderRadius.circular(22.5)),
                            child: Center(
                              child: Text(context.watch<TeacherDataProvider>().committeeName[j],
                                  style: TextStyle(
                                    fontFamily: '.NotoSansKR',
                                    color: const Color(0xff000000),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                  )),
                            ),
                          ),
                          Container(
                              width: 160.w,
                              height: 47.w,
                              margin: EdgeInsets.only(left: 38.w),
                              child: Center(
                                  child: Text(context.watch<TeacherDataProvider>().committeeClassName[j],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontFamily: '.NotoSansKR',
                                      ),
                                      strutStyle: StrutStyle(
                                        fontSize: 18.sp,
                                        forceStrutHeight: true,
                                      ))))
                        ] else ...[
                          Container(
                              width: 135.w,
                              height: 135.w,
                              margin: EdgeInsets.only(
                                  left: 13.w, top: 65.w),
                              child: context.watch<TeacherDataProvider>().committeeImage[j]),
                          Container(
                            width: 180.w,
                            height: 45.w,
                            margin: EdgeInsets.only(left: 23.w),
                            decoration: new BoxDecoration(
                                color: const Color(0xffffc9c9),
                                borderRadius:
                                BorderRadius.circular(17.5)),
                            child: Center(
                              child: Text(context.watch<TeacherDataProvider>().committeeName[j],
                                  style: TextStyle(
                                    fontFamily: 'NotoSansKR',
                                    color: const Color(0xff000000),
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                  )),
                            ),
                          ),
                          Container(
                              width: 160.w,
                              height: 47.w,
                              margin: EdgeInsets.only(left: 33.w),
                              child: Center(
                                  child: Text(context.watch<TeacherDataProvider>().committeeClassName[j],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontFamily: '.NotoSansKR',
                                      ),
                                      strutStyle: StrutStyle(
                                        fontSize: 18.sp,
                                        forceStrutHeight: true,
                                      ))))
                        ],
                      ],
                    )
                  ]
                ],
              )
            ]
          ],
        ),
      ),
      ],
    )
    ]
    ),
    );
  }
}