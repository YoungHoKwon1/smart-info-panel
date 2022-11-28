import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:smart_info_panel/api/infopanel.dart';
import 'package:smart_info_panel/provider/class_data.dart';
import 'package:smart_info_panel/widgets/classinfo10_widget.dart';
import 'dart:async';

import '../provider/teacher_data.dart';
import 'package:provider/provider.dart';

import 'classinfo20_widget.dart';
import 'classinfo30_widget.dart';

class TeacherInfoWidget extends StatefulWidget {
  const TeacherInfoWidget({Key? key}) : super(key: key);

  @override
  State<TeacherInfoWidget> createState() => _TeacherInfoWidgetState();
}

class _TeacherInfoWidgetState extends State<TeacherInfoWidget> {
  void initState() {
    super.initState();
    // Timer(Duration(seconds: 20), () {
    //   if(context.watch<ClassDataProvider>().childNum<=10) {
    //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ClassInfo10Widget()));
    //   } else if(context.watch<ClassDataProvider>().childNum>10 || context.watch<ClassDataProvider>().childNum<20) {
    //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ClassInfo20Widget()));
    //   } else {
    //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ClassInfo30Widget()));
    //   }
    // });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ///원장
                for (int i = 0; i < context.watch<TeacherDataProvider>().directorNum; i++) ...[
                  Column(
                    children: [
                      Container(
                          width: 140.w,
                          height: 140.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xffffffff),
                          ),
                          //페이지에 따라 마진 조절 바람 건희, 성민
                          margin:
                          EdgeInsets.only(
                              left: 23.w,
                              top: 49.w),
                          child:
                          ClipRRect(
                            borderRadius: BorderRadius.circular(250),
                            child: context.watch<TeacherDataProvider>().directorImage[i]),
                            ),
                      Container(
                        width: 200.w,
                        height: 45.w,
                        margin: EdgeInsets.only(left: 28.w),
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
                        margin: EdgeInsets.only(left: 28.w),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int j = 0; j < context.watch<TeacherDataProvider>().teacherNum; j++) ...[
                    Column(
                      //사진+이름배치를 위해 column으로 시작
                      children: [
                        if (j == 0) ...[
                          Container(
                              width: 135.w,
                              height: 135.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xffffffff),
                              ),
                              margin: EdgeInsets.only(left: 23.w, top: 65.w),
                            child:
                            ClipRRect(
                                borderRadius: BorderRadius.circular(250),
                                child: context.watch<TeacherDataProvider>().teacherImage[j]),
                          ),
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
                              margin: EdgeInsets.only(left: 28.w),
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
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xffffffff),
                            ),
                              margin: EdgeInsets.only(
                                  left: 13.w, top: 65.w),
                            child:
                            ClipRRect(
                                borderRadius: BorderRadius.circular(250),
                                child: context.watch<TeacherDataProvider>().teacherImage[j]),
                          ),
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
                              margin: EdgeInsets.only(left: 23.w),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int j = 0; j < context.watch<TeacherDataProvider>().committeeNum; j++) ...[
                    Column(
                      //사진+이름배치를 위해 column으로 시작
                      children: [
                        if (j == 0) ...[
                          Container(
                              width: 135.w,
                              height: 135.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xffffffff),
                              ),
                              margin: EdgeInsets.only(
                                  left: 23.w, top: 65.w),
                            child:
                            ClipRRect(
                                borderRadius: BorderRadius.circular(250),
                                child: context.watch<TeacherDataProvider>().committeeImage[j]),
                          ),
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
                              margin: EdgeInsets.only(left: 23.w),
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
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xffffffff),
                            ),

                            margin: EdgeInsets.only(
                                  left: 13.w, top: 65.w),
                            child:
                            ClipRRect(
                                borderRadius: BorderRadius.circular(250),
                                child: context.watch<TeacherDataProvider>().committeeImage[j]),
                          ),
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
                              margin: EdgeInsets.only(left: 23.w),
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
    );
  }
}