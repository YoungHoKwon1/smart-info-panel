import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:smart_info_panel/api/infopanel.dart';
import 'dart:async';

import '../provider/class_data.dart';
import 'package:provider/provider.dart';

class ClassInfo30Widget extends StatefulWidget {
  const ClassInfo30Widget({Key? key}) : super(key: key);

  @override
  State<ClassInfo30Widget> createState() => _ClassInfo30WidgetState();
}

class _ClassInfo30WidgetState extends State<ClassInfo30Widget> {
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
                      margin:
                      EdgeInsets.only(left: 40.w, top: 140.w),
                      child: Text(context.watch<ClassDataProvider>().className,
                          style: TextStyle(
                            fontFamily: 'GamjaFlower',
                            color: const Color(0xff39605f),
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          )),
                    ),
                    Container(
                      width: 270.w,
                      height: 40.w,
                      margin: EdgeInsets.only(top: 20.w),
                      decoration: BoxDecoration(
                          color: const Color(0xffc7f7f5),
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
                          style: TextStyle(fontSize: 18.sp),
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
                      width: 100.w,
                      height: 66.w,
                      //페이지에 따라 마진 조절 바람 건희, 성민
                      margin: EdgeInsets.only(left: 60.w),
                      child: context.watch<ClassDataProvider>().teacherImage[i]),
                  Container(
                    width: 160.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                        color: const Color(0xffc7f7f5),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text(
                        context.watch<ClassDataProvider>().teacherName[i],
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
        for (int i = 0; i < context.watch<ClassDataProvider>().row; i++) ...[
          Row(
            children: [
              for (int j = 0; j < context.watch<ClassDataProvider>().column; j++) ...[
                Column(
                  //사진+이름배치를 위해 column으로 시작
                  children: [
                    if (j == 0) ...[
                      Container(
                          width: 110.w,
                          height: 110.w,
                          margin: EdgeInsets.only(
                              left: 31.w, top: 30.w),
                          child: context.watch<ClassDataProvider>().childrenImage[context.watch<ClassDataProvider>().column * i + j])
                    ] else ...[
                      Container(
                        width: 110.w,
                        height: 110.w,
                        margin: EdgeInsets.only(
                            left: 36.w, top: 30.w),
                        child: Center(
                            child: context.watch<ClassDataProvider>().childrenImage[context.watch<ClassDataProvider>().column * i + j]),
                      )
                    ],
                    Container(
                      width: 116.w,
                      height: 35.w,
                      decoration: BoxDecoration(
                          color: const Color(0xffc7f7f5),
                          borderRadius:
                          BorderRadius.circular(17.5)),
                      margin: EdgeInsets.only(left: 28.w),
                      child: Center(
                        child: Text(context.watch<ClassDataProvider>().childrenName[context.watch<ClassDataProvider>().column * i + j],
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
                          width: 110.w,
                          height: 110.w,
                          margin: EdgeInsets.only(
                              left: 31.w, top: 30.w),
                          child: context.watch<ClassDataProvider>().childrenImage[context.watch<ClassDataProvider>().row * context.watch<ClassDataProvider>().column + j])
                    ] else ...[
                      Container(
                          width: 110.w,
                          height: 110.w,
                          margin: EdgeInsets.only(
                              left: 36.w, top: 30.w),
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
                      margin: EdgeInsets.only(left: 28.w),
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
